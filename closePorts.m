function closePorts()
% Make sure all serial ports are closed
% seriallist;      % TODO (might be useful)
s = instrfind;
if ~isempty(s)
    fclose(s);
    delete(s);
    clear s;
end
fprintf('serial port closed \n');