function [D, maxTaus, TupShiftDown, FupShiftDown, tauRange, tauIdx,...
          subTauRange, subTauIdx, amplitudeChannelIdx, amplitudes] = ...
       vTemplateMatching(WFS, T, nC, Toffset, varargin)
    % Performs template matching on each row of WFS with the templates in T.
    % Mutliple channels must be concatenated in each row of WFS and T.
    % T can be made to contain matched filters of the form F = T*C^-1 
    % by passing the noise covariance matrix as parameter
    % "noiseCovariance". The subresampling should not be done on the
    % filters but on the templates!
    %
    % Keep in mind that if T is not zero at the right end of each channel,
    % there might be upsample artefacts! However, those will tend to
    % undererstimate the correct value, thus the energy of Tup will be
    % lower which is not too dramatic for the BOTM functions (since the
    % reference energy will be the correct full energy).
    %
    % Input:
    %   WFS - waveforms, each row one waveform, multiple channels
    %       concatenated
    %   T - templates to match waveforms with. Waveforms in T can be
    %       shorter then those in WFS. If so, specify offset between T and WFS
    %  nC - number of channels in WFS and T
    % Toffset - offset of templates in T in respect to spikes in WFS. Defines
    %           what a shift of 0 is. Possible shifts -maxShift:maxShift
    %           around this offset are then evaluated. offset points to the
    %           sample index into WFS where the first sample of T needs to be
    %           placed for an alignment of 0:
    %
    %           Example, offset 4, shift 0:
    %                       ch 1                          ch 2
    %           T:       x x x x x x          |       x x x x x x 
    %           WFS: x x x x x x x x x x x x  | x x x x x x x x x x x x x 
    %
    % Ouput:
    %   D - discriminant values for each row in WFS for each waveform in T
    % tau - shift (with subsample precision) of the corresponding T for
    %       each row in D that gave the maximal discriminant (best match)
    % TupShiftDown - cell array with one cell for each Template containing 
    %                the subsample shifted version of the templates
    % FupShiftDown - cell array with one cell for each Template containing 
    %                the subsample shifted version of filters for the
    %                corresponding template. If no noiseCovariance matrix
    %                is given this is identical to TupShiftDown
    % tauRange     - range of full sample shifts that was considered. This
    %                depends on the possible shifts of T in WFS
    
    P.upsample = 5;    % upsample T (but not WFS!) to do subsample fine matching
    P.maxShift = 5;    % allow for shifts +- maxShifts to find optimal alignment
    P.noiseCovariance = [];
    P.TupShiftDown = {}; % provide this if is was already computed
    P.FupShiftDown = {}; % provide this if is was already computed
    P.chunkSize    = []; % if WFS is a data source handle into a file which cannot
                         % be loaded due to memory concerns, the matching can be done in chunks
    P = hdsort.util.parseInputs(P, varargin, 'error');
    
    nS = size(WFS,1);
    TfX = size(WFS,2)/nC;
    
    nT = size(T,1);
    TfT = size(T,2)/nC;
    D = -inf(nS, nT);
    
    % Do matching only on temporal window defined by the templates
    idxstart = Toffset;
    idxstop  = idxstart + TfT - 1;
    
    % compute the matching not only with the alignment tau=0 as
    % given by the templates derived from aligned spikes. The
    % spikes in WFS were not aligned yet !!
    % So we "filter" the spikes in WFS with the filters
    % by shifting the filters some samples left and some right and
    % taking the maximum value of any shifted filter
    tauRange = -P.maxShift:P.maxShift;
    % remove invalid shifts if WFS is too short. Other possibility is to crop
    % T but this could lead to artefacts at the borders if T is shifted out
    % of the window and looses too much energy!
    tauRange(tauRange+idxstart<=0) = [];
    tauRange(tauRange+idxstop>TfX) = [];

    % Compute the subsample shifted templates and filters, but only if they
    % are not already provided in the optional arguments
    if isempty(P.FupShiftDown) 
        if isempty(P.TupShiftDown)
            % compute the subsample shifted versions of T
            [TupShiftDown subTauRange] = hdsort.waveforms.vComputeSubsampleShiftedVersions(T, nC, P.upsample);
        else
            TupShiftDown = P.TupShiftDown;
            upsample = size(TupShiftDown,3);
            subTauRange = (0:upsample-1)/upsample;
        end
        FupShiftDown = TupShiftDown;
        if ~isempty(P.noiseCovariance)
            for i=1:size(TupShiftDown,3)
                FupShiftDown(:,:,i) = FupShiftDown(:,:,i)/P.noiseCovariance;
            end
        end
    else
        FupShiftDown = P.FupShiftDown;
        subTauRange = (0:size(FupShiftDown,3)-1)/size(FupShiftDown,3);
    end
    
    % now compute for each full sample step tau all the subsample step taus
    maxTaus = zeros(nS,nT);
    tauIdx  = zeros(nS,nT);
    subTauIdx = zeros(nS,nT);
    D_ = D;
    
    amplitudeChannelIdx = []; amplitudes = [];
    
    chk = hdsort.util.Chunker(nS, 'chunkSize', P.chunkSize, ...
                             'chunkOverlap', 0);
    while chk.hasNextChunk()
        fprintf('Matching Spikes Chunk %d of %d\n', chk.currentChunk, chk.nChunks);
        [chunkOverlap, chunk, chunkLen] = chk.getNextChunk();
        chunk_idx = chunk(1):chunk(2);
        chunkedWFS = WFS(chunk_idx,:);
        for taui = 1:length(tauRange)
            tau = tauRange(taui);
            % get index into WFS for shifts tau of T
            idx_tau = hdsort.waveforms.vSubIdx(TfX, nC, (idxstart:idxstop)+tau);

            % compute for each template individually all subshift matchings                
            for k = 1:nT
                if ndims(FupShiftDown)==2
                    [D_(chunk_idx,k) subTauIdx(chunk_idx,k)] = max(chunkedWFS(:,idx_tau)*squeeze(FupShiftDown(k,:)'), [], 2);
                else
                    [D_(chunk_idx,k) subTauIdx(chunk_idx,k)] = max(chunkedWFS(:,idx_tau)*squeeze(FupShiftDown(k,:,:)), [], 2);
                end
                [D(chunk_idx,k) choice] = max([D(chunk_idx,k) D_(chunk_idx,k)], [], 2);
                % choice is 1 if the old value was greater and two if we found
                % a new maximum of the matching. In the later case, update the
                % shift
                choice_idx = find(choice==2)+chunk_idx(1)-1;
                idx = intersect(choice_idx,chunk_idx);
                maxTaus(idx,k) = tau - subTauRange(subTauIdx(idx,k));
                tauIdx(idx,k) = taui;
            end
        end
        
        wfstmp = hdsort.waveforms.v2t(chunkedWFS, nC);
        [ampsChIdx_, amps_] = hdsort.waveforms.maxChannel(wfstmp);
        amplitudeChannelIdx = [amplitudeChannelIdx; ampsChIdx_]; 
        amplitudes = [amplitudes; amps_];
    end
    
end