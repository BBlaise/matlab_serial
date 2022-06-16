function closeSerialPort(serial_port)
fclose(serial_port);
delete(serial_port);
clear serial_port;

% Make sure all serial ports are closed
f = instrfind;
if ~isempty(f)
    fclose(f);
end
clear f;
fprintf('serial port closed \n');