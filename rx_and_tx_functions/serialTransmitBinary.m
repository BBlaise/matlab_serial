function serialTransmitBinary(serial_port, serial_config, tx)
    n_tx = serial_config.n_tx;
    data_type = serial_config.tx_data_type;

    switch data_type
    case 'float32'
        % Transmit a vector of float32s
        for jj = 1:n_tx
            temp = typecast(single(tx(jj)), 'uint8');
    %         temp = fliplr(temp);                % for msp432?
            fwrite(serial_port, temp, 'uint8');
        end
    case 'int32'
        % Transmit a vector of int32s
        for jj = 1:n_tx
            temp = fliplr(typecast(int32(tx(jj)), 'uint8'));
            fwrite(serial_port, temp, 'uint8');
        end
    case 'int16'
        % Transmit a vector of int16s
        for jj = 1:n_tx
            temp = fliplr(typecast(int16(tx(jj)), 'uint8'));
            fwrite(serial_port, temp, 'uint8');
        end
    case 'int8'
        % Transmit a vector of int8s
        for jj = 1:n_tx
            temp = fliplr(typecast(int8(tx(jj)), 'uint8'));
            fwrite(serial_port, temp, 'uint8');
        end
    case 'uint32'
        % Transmit a vector of uint32s
        for jj = 1:n_tx
            temp = fliplr(typecast(uint32(tx(jj)), 'uint8'));
%             temp = fliplr(temp);                % for msp432?
            fwrite(serial_port, temp, 'uint8');
        end
    case 'uint16'
        % Transmit a vector of uint16s
        for jj = 1:n_tx
            temp = fliplr(typecast(uint16(tx(jj)), 'uint8'));
            % temp = fliplr(temp);                % for msp432?
            fwrite(serial_port, temp, 'uint8');
        end
    case 'uint8'
        % Transmit a vector of uint8s
        for jj = 1:n_tx
%             fwrite(serial_port, tx(jj), 'uint8');
            temp = typecast(uint8(tx(jj)), 'uint8');
            fwrite(serial_port, temp, 'uint8');

            %        tx = fliplr(temp);                % for msp432?
        end
    otherwise
        % Default to transmit a vector of float32s
        for jj = 1:n_tx
            temp = typecast(single(tx(jj)), 'uint8');
    %         temp = fliplr(temp);                % for msp432?
            fwrite(serial_port, temp, 'uint8');
        end
    end
end