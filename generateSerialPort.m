function serial_port = generateSerialPort(config)
%% Close any open serial ports
% Double check serial ports are closed
% seriallist;      % TODO (might be useful)
% Problem if you need to open multiple ports in a single script
temp = instrfind;
if isempty(temp) ~= 1
    fclose(temp);
    delete(temp);
    clear temp;
    fprintf('Serial port closed \n');
end

%% Configure Then Open serial port
serial_port = serial(config.com_port);               % open the serial port
set(serial_port, 'BaudRate', config.baud_rate);
set(serial_port, 'Timeout', config.timeout);
set(serial_port, 'ByteOrder', config.byte_order);
set(serial_port, 'Terminator', config.terminator);

%% Enable Callback Function (if applicable)
global callback_handle
if config.use_callback == true
    serial_port.BytesAvailableFcn = {callback_handle};
    if strcmp(config.encoding, 'ascii')
        serial_port.BytesAvailableFcnMode = 'terminator';
    else
        serial_port.BytesAvailableFcnMode = 'byte';
        serial_port.BytesAvailableFcnCount = config.n_rx_bytes;
    end
%     serial_port.BytesAvailableFcn = {config.callback_handle};
    % serial_port.BytesAvailableFcn = {@uartCallback};
    % serial_port.BytesAvailableFcn = {@uartCallback, data};      % If
        % you figure out how to pass data by reference
end

fopen(serial_port);
fprintf('Serial port opened \n');

% Flush any initial data
flushinput(serial_port);
flushoutput(serial_port);