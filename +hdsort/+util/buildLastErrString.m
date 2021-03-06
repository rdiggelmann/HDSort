
function str = buildLastErrString(ME)
    if nargin < 1
        err = lasterror;
    else
        err = ME;
    end
    
    str = sprintf(['+++++++++ERROR: ' err.identifier '\n' err.message]);
    for i=1:size(err.stack,1)
        str = [str sprintf('%s: %d\n', err.stack(i).file, err.stack(i).line)];
    end