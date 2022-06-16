clear; clc; close all;
format shortG; format compact;

% Add Windows Paths
pth = 'C:\Users\Bryan\Desktop\codebase\matlab\utility_functions';
addpath(genpath(pth));
addpath('C:\Users\Bryan\Desktop\codebase\matlab\uart');
addpath('C:\Users\Bryan\Desktop\codebase\matlab\uart\rx_and_tx_functions');

% Add Linux Paths
% pth = '/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/utility_functions';
% addpath(genpath(pth));
% cd('/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/uart');
% addpath('/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/uart');
% addpath('/media/bblaise/Windows/Users/Bryan/Desktop/codebase/matlab/uart/rx_and_tx_functions');

%% Configure the Serial Port
configure_uart;             % configure serial port options
mcu_serial_port = uartConfig(uart_config);

%% Data Formatting and Initialization
duration = 5;               % [sec]
frequency = 1;     % how often data is sent to/from microcontroller
t_inc = 1 / frequency;
n_samples = frequency * duration;   % Cuts off UART after approx 5 seconds for this example
n_tx = uart_config.n_tx;                           % number of values to be transmitted via UART (w/o indicator)
n_rx = uart_config.n_rx;                           % number of values to be received via UART (w/o indicator)save_timestamp = true;
n_rx_bytes = uart_config.n_rx_bytes;              % number of bytes in a single transmission

tx = zeros(1, n_tx);
rx = zeros(1, n_rx);

save_timestamp = true;
if save_timestamp == true
    data = zeros(n_samples, 2+n_rx);  % time stamped data storage array to hold received data [index, time, ...]
else
    data = zeros(n_samples, n_rx);  % data storage array to hold received data
end
    
%% Flush Input and Start The Program
% prompt = 'Press any key to start the program!';
% input(prompt);

pause on;

fprintf('Starting! \n');
flushinput(mcu_serial_port);
flushoutput(mcu_serial_port);
tic;                                    % start timing

%% Receive and Send Data
ii = 1;
while toc < duration
    % Transmit Values
    tx = [-1.2, 3.4];      % test data (if sending floats)
    uartTransmit(mcu_serial_port, tx, n_tx, uart_config.tx_data_type);
    pause(1);               % wait for one second
    rx = uartReceive(mcu_serial_port, n_rx, uart_config.rx_data_type);
    
    % Receive Values
    if save_timestamp == true
        data(ii, 1) = ii;                   % save the current index
        data(ii, 2) = toc;                  % save the current time
        data(ii, 3:(2+n_rx)) = rx;           % save received values
    else
        data(ii, 1:n_rx) = rx;           % save received values
    end
    rx = zeros(size(rx));
    
    data(ii,:)              % output current timestep data to console (unnecessary)
    ii = ii+1;              % increment index    
end

%% Wait At End of Program Until Any Key Is Pressed
% prompt = 'Press any key to end the program! \n';
% input(prompt);

%% Close Serial Port
fprintf('end of data logging \n');
closeSerialPort(mcu_serial_port);
fprintf('serial port closed \n');