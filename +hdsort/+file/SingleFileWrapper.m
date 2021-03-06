classdef SingleFileWrapper < hdsort.file.FileWrapperInterface
    
    properties (Hidden)
        file_idx
    end
    
    properties
        fileName
        parent
    end
    
    methods
        %------------------------------------------------------------------
        function self = SingleFileWrapper(derivedClassName, samplesPerSecond, MultiElectrode, fileName, parent, file_idx)
            if nargin < 5
                parent = [];
                file_idx = 1;
            else
                assert(nargin == 6, 'You must provide a file_idx together with the parent object!');
            end
            
            self = self@hdsort.file.FileWrapperInterface(derivedClassName, samplesPerSecond, MultiElectrode)
            
            self.fileName = fileName;
            self.parent = parent;
            self.file_idx = file_idx;
            
            self.name = fileName;
            self.info = 'If this info message is displayed, there has been an error in the construction of this object!';
        end
        
        %------------------------------------------------------------------
        function wf = getScaledWaveform(self, nCut, channelIndex, varargin)
            wf = self.getWaveform(nCut, channelIndex, varargin{:})*self.getLSB();
        end
        
        %------------------------------------------------------------------
        function X = getScaledData(self, timeIndex, channelIndex)
            tmp = self.getData(timeIndex, channelIndex)*self.getLSB();
        end
        
        %------------------------------------------------------------------
        function getNSamples_(self)
            error('Must be implemented in the derived class!')
        end
        function getData_(self)
            error('Must be implemented in the derived class!')
        end
        %function getWaveform_(self)
        %    error('Must be implemented in the derived class!')
        %end
        
        function X = getFilteredData(self, varargin)
            hpf = 300;
            lpf = 7000;
            fir_filterOrder = 110;
            b  = hdsort.util.filter_design_fir(hpf, lpf, self.getSampleRate(), fir_filterOrder);
            
            X = self.getData(varargin{:});
            
            X = double(X);
            X = bsxfun(@minus, X, mean(X,1));
            X = conv2(X, b(:), 'same');
        end
        
        %------------------------------------------------------------------
        function wf = getWaveform_(self, nCut, channelindex, cutLength, t1, t2)
            wf = zeros(nCut, length(channelindex)*cutLength);
            % Build complete index set and access data with a single
            % entry
            IDX = zeros(1, nCut*cutLength);
            for i = 1:nCut
                idx_idx = (i-1)*cutLength +1 : i*cutLength;
                IDX(idx_idx) = t1(i):t2(i); 
            end 
            X = self.getData_(IDX, channelindex);
            %X = bsxfun(@minus, X, median(X));
            X = reshape(X, [cutLength nCut length(channelindex)]);
            for i = 1:nCut
                wf(i,:) = hdsort.waveforms.m2v(squeeze(X(:, i, :))');
            end
        end
        
        
        
        
        
    end
end
