% TODO: - run this via a function call in the calling script without serial_config being a global variable in
% the workspace

% port_variable_name = ''; % then set port name to this and clear
% serial_config

% % Length of transmitted/received vectors per timestep/transmission
serial_config.n_tx = 0;           % length of outgoing vector
serial_config.n_rx = 2;           % length of incoming vector

% Baud Rate
serial_config.baud_rate = 115200;
% serial_config.baud_rate = 9600;

% COM PORT
serial_config.com_port = 'COM5';        % COM port on Windows
% serial_config.com_port = 'COM4';        % COM port on Windows 
% serial_config.com_port = '/dev/ttyACM0';        % COM port on Linux
% serial_config.com_port = '/dev/ttyS0';        % COM port on Linux

% Little or Big Endian
serial_config.byte_order = 'bigEndian';       % MSP432 and Teensy 3.6
% serial_config.byte_order = 'littleEndian';

% Starter (if using ASCII)
serial_config.starter = '.-/';

% Terminator (if using ASCII)
% serial_config.terminator = 'LF';
serial_config.terminator = 'CR/LF';
% serial_config.terminator = 'CR';
% serial_config.terminator = 'LF/CR';

% % Delimeter
serial_config.delimeter = ',';
% serial_config.delimeter = '';       % no delimeter
% serial_config.delimeter = ' ';      % space
% serial_config.delimeter = '\t';     % tab
% serial_config.delimeter = '.';
% serial_config.delimeter = '-';

% Timeout (Before MCU must respond)
serial_config.timeout = 5;

% Use callback or not
serial_config.use_callback = false;
% serial_config.use_callback = true;

% Callback Function Name
serial_config.callback_handle = @uartCallback;

serial_config.encoding = 'binary';
% serial_config.encoding = 'ascii';

% % Transmitting/Outgoing Data Type
serial_config.tx_data_type = 'float32';
% serial_config.tx_data_type = 'int32';
% serial_config.tx_data_type = 'int16';
% serial_config.tx_data_type = 'int8';
% serial_config.tx_data_type = 'uint32';
% serial_config.tx_data_type = 'uint16';
% serial_config.tx_data_type = 'uint8';

% % Received/Incoming Data Type
% serial_config.rx_data_type = 'float32';
% serial_config.rx_data_type = 'int32';
serial_config.rx_data_type = 'int16';       % i.e. Arduino Uno
% serial_config.rx_data_type = 'int8';
% serial_config.rx_data_type = 'uint32';
% serial_config.rx_data_type = 'uint16';
% serial_config.rx_data_type = 'uint8';

% Mixed Incoming Data Types
% serial_config.rx_sequence = {int32, float32}

% Mixed Outgoing Data Types

%% Enable Callback Function (if applicable)
serial_config.use_callback = false;
serial_config.n_rx_bytes = sizeof(serial_config.rx_data_type) * serial_config.n_rx;