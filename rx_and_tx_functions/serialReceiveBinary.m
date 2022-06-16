function rx = serialReceiveBinary(serial_port, port_config)
    rx = zeros(1, port_config.n_rx);
    % TODO - combine this and uartReceiveAscii
    
    switch port_config.rx_data_type
    case 'float32'
        % Receive a vector of float32s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 4, 'uint8');
            temp = typecast(uint8(temp), 'uint32');
            temp = typecast(temp, 'single');
            % temp = swapbytes(temp);           % msp432?
            rx(jj) = temp;           
        end
    case 'int32'
        % Receive a vector of int32s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 4, 'uint8');
            temp = typecast(uint8(temp), 'int32');
            temp = swapbytes(temp);
            rx(jj) = temp;
        end
    case 'int16'
        % Receive a vector of int16s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 2, 'uint8');
            temp = typecast(uint8(temp), 'int16');
            temp = swapbytes(temp);
            rx(jj) = temp;
        end
    case 'int8'
        % Receive a vector of int8s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 1, 'uint8');
            temp = typecast(uint8(temp), 'int8');
            temp = swapbytes(temp);
            rx(jj) = temp;
        end
    case 'uint32'
        % Receive a vector of uint32s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 4, 'uint8');
            temp = typecast(uint8(temp), 'uint32');
            temp = swapbytes(temp);
            rx(jj) = temp;
        end
    case 'uint16'
        % Receive a vector of uint16s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 2, 'uint8');
            temp = typecast(uint8(temp), 'uint16');
            temp = swapbytes(temp);
            rx(jj) = temp;
        end
    case 'uint8'
        % Receive a vector of uint8s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 1, 'uint8');
            rx(jj) = temp;
        end
    otherwise
        % Default to receive a vector of float32s
        for jj = 1:port_config.n_rx
            temp = fread(serial_port, 4, 'uint8');
            temp = typecast(uint8(temp), 'uint32');
            temp = typecast(temp, 'single');
            % temp = swapbytes(temp);           % msp432?
            rx(jj) = temp;           
        end
    end
end