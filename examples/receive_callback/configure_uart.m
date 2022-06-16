% Baud Rate
uart_config.n_tx = 0;           % length of outgoing vector
uart_config.n_rx = 2;           % length of incoming vector

uart_config.baud_rate = 115200;
% uart_config.baud_rate = 9600;
% uart_config.baud_rate = 460800;

% COM PORT
uart_config.com_port = 'COM5';        % COM port on Windows (usually Teensy 3.6)
% uart_config.com_port = 'COM4';        % COM port on Windows (usually Arduino Uno)
% uart_config.com_port = '/dev/ttyACM0';        % COM port on Linux
% uart_config.com_port = '/dev/ttyS0';        % COM port on Linux

% Little or Big Endian
uart_config.byte_order = 'bigEndian';       % MSP432 and Teensy 3.6
% uart_config.byte_order = 'littleEndian';    

% Terminator (if using ASCII)
uart_config.terminator = 'CR/LF';

% Timeout (Before MCU must respond)
uart_config.timeout = 5;

% Use callback or not
uart_config.use_callback = false;
% uart_config.use_callback = true;

uart_config.encoding = 'binary';
% uart_config.encoding = 'ascii';

% % Transmitting/Outgoing Data Type
uart_config.tx_data_type = 'float32';
% uart_config.tx_data_type = 'int32';
% uart_config.tx_data_type = 'int16';
% uart_config.tx_data_type = 'int8';
% uart_config.tx_data_type = 'uint32';
% uart_config.tx_data_type = 'uint16';
% uart_config.tx_data_type = 'uint8';

% % Received/Incoming Data Type
uart_config.rx_data_type = 'float32';
% uart_config.rx_data_type = 'int32';
% uart_config.rx_data_type = 'int16';
% % uart_config.rx_data_type = 'int8';
% % uart_config.rx_data_type = 'uint32';
% % uart_config.rx_data_type = 'uint16';
% % uart_config.rx_data_type = 'uint8';

% Mixed Outgoing Data Types
% uart_config.tx_sequence = {float32, int32}

% Mixed Incoming Data Types
% uart_config.rx_sequence = {int32, float32}

%% Enable Callback Function (if applicable)
uart_config.use_callback = true;
uart_config.n_rx_bytes = sizeof(uart_config.rx_data_type) * uart_config.n_rx;