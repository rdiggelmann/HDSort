
function X = shiftRowsInterpolated(X, t, nC)
    if nargin < 3
        nC = 1;
    end
    range = 1:size(X,2)/nC;
    for i=1:size(X,1)
        if abs(t(i))>.001
            xsinc = hdsort.waveforms.mSincfun(hdsort.waveforms.v2m(X(i,:), nC));            
            X(i,:) = hdsort.waveforms.m2v(xsinc(range-t(i)));
        end
    end
end