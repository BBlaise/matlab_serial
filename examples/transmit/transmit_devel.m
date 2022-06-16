clear; clc; close all;
format shortG; format compact;

% TODO figure out why reading doesn't clear the serial line

% Add Windows Paths
pth = 'C:\Users\Bryan\Desktop\codebase\matlab\utility_functions'; addpath(genpath(pth)); % used to add subfolders
addpath('C:\Users\Bryan\Desktop\codebase\matlab\matlab_serial');
addpath('C:\Users\Bryan\Desktop\codebase\matlab\matlab_serial\rx_and_tx_functions');

% Add Linux Paths
% pth = '/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/utility_functions';
% addpath(genpath(pth));
% cd('/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/uart');
% addpath('/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/uart');
% addpath('/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/uart/rx_and_tx_functions');

%% Configure the Serial Port
configure_serial;
mcu_serial_port = generateSerialPort(serial_config);              % configure serial port

%% Data Formatting nd Initialization
duration = 1;               % [sec]
frequency = 1;     % how often data is sent to/from microcontroller
t_inc = 1 / frequency;
n_samples = frequency * duration;   % Cuts off UART after approx 5 seconds for this example
n_tx = serial_config.n_tx;                           % number of values to be transmitted via UART (w/o indicator)
n_rx = serial_config.n_rx;                           % number of values to be received via UART (w/o indicator)
save_timestamp = false;

rx = zeros(1, n_rx);           % vector to be populated with int32s from UART
n_rx_bytes = n_rx * sizeof(serial_config.rx_data_type);

if save_timestamp == true
    rx_data = zeros(n_samples, 2+n_rx);  % time stamped data storage array to hold received data [index, time, ...]
else
    rx_data = zeros(n_samples, n_rx);  % data storage array to hold received data
end

%% Enable Callback Function (if applicable)
% mcu_serial_port.BytesAvailableFcnMode = 'terminator';
% mcu_serial_port.BytesAvailableFcn = {@serialCallback};
% mcu_serial_port.BytesAvailableFcn = {@serialCallback, data};      % If
    % you figure out how to pass data by reference

%% Flush Input and Start The Program
% prompt = 'Press any key to start the program!';
% input(prompt);

fprintf('Starting! \n');
% fread(mcu_serial_port, mcu_serial_port.BytesAvailable, 'uint8');
% mcu_serial_port.BytesAvailable
flushinput(mcu_serial_port);
flushoutput(mcu_serial_port);
tic;                                    % start timing

%% Receive and Send Data
ii = 1;
while toc < duration
% TODO : implement wait function with tic - last_tic to wait for timer
% period (might be unnecessary)

    % Individual Values to Transmit
%     tx = 254;         serial_config.tx_data_type = 'uint8';
%     tx = 65534;       serial_config.tx_data_type = 'uint16';
%     tx = 111222333;     serial_config.tx_data_type = 'uint32';
%     tx = -126;            serial_config.tx_data_type = 'int8';
%     tx = -32766;            serial_config.tx_data_type = 'int16';
%     tx = -111222333;  serial_config.tx_data_type = 'int32';
%     tx = -10;         serial_config.tx_data_type = 'int16';
%     tx = -1.2;        serial_config.tx_data_type = 'float32';

    tx = -111222333;  serial_config.tx_data_type = 'int32';

    % Data Array to Transmit
%     tx = [1, 111222333];   serial_config.tx_data_type = 'uint32'; serial_config.n_tx = 2;
%     tx = [1, -111222333];   serial_config.tx_data_type = 'int32'; serial_config.n_tx = 2;
%     tx = [-1, 10000];      serial_config.tx_data_type = 'int16'; serial_config.n_tx = 2;
%     tx = [-1.2, 3.4];      serial_config.tx_data_type = 'float32';  serial_config.n_tx = 2;

    serial_config.encoding = 'ascii';

    if strcmp(serial_config.encoding, 'binary')
        serialTransmitBinary(mcu_serial_port, serial_config, tx); 
    elseif strcmp(serial_config.encoding, 'ascii')
        serialTransmitAscii(mcu_serial_port, serial_config, tx); 
    end

    disp("Data Sent");
    pause(1);               % wait for one second
end

%% Wait At End of Program Until Any Key Is Pressed
% prompt = 'Press any key to end the program! \n';
% input(prompt);

%% Close Serial Port
disp("End of Data Logging");
% closeSerialPort(mcu_serial_port);

if ~isempty(instrfind)
    opened_port = instrfind;
    fclose(opened_port);
    disp("Port Closed");
end