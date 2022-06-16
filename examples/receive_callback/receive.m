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
global callback_handle;
callback_handle = @uartCallback;
configure_uart;
mcu_serial_port = uartConfig(uart_config);              % configure serial port

%% Data Formatting nd Initialization
duration = 5;               % [sec]
frequency = 1;     % how often data is sent to/from microcontroller
t_inc = 1 / frequency;
n_samples = frequency * duration;   % Cuts off UART after approx 5 seconds for this example
n_tx = uart_config.n_tx;                           % number of values to be transmitted via UART (w/o indicator)
n_rx = uart_config.n_rx;                           % number of values to be received via UART (w/o indicator)
save_timestamp = true;

rx = zeros(1, n_rx);           % vector to be populated with int32s from UART
n_rx_bytes = n_rx * sizeof(uart_config.rx_data_type);

if save_timestamp == true
    data = zeros(n_samples, 2+n_rx);  % time stamped data storage array to hold received data [index, time, ...]
else
    data = zeros(n_samples, n_rx);  % data storage array to hold received data
end

%% Flush Input and Start The Program
% prompt = 'Press any key to start the program!';
% input(prompt);

fprintf('Starting! \n');
flushinput(mcu_serial_port);
flushoutput(mcu_serial_port);
tic;                                    % start timing

%% Receive Data
while toc < duration
end

%% Wait At End of Program Until Any Key Is Pressed
% prompt = 'Press any key to end the program! \n';
% input(prompt);

%% Close Serial Port
fprintf('end of data logging \n');
closeSerialPort(mcu_serial_port);

%% Call Back Function
function uartCallback(port, ~)
    fprintf('yo! \n');
    % TODO figure out how to pass workspace variables here (probably need
    % OOP)
end