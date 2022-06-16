function rx = serialReceiveAscii(serial_port, port_config)
    if strcmp(port_config.rx_data_type, 'float32')
        format_spec = '%f';
        for ii = 1:(port_config.n_rx-1)
            format_spec = strcat(format_spec, port_config.delimeter, '%f');
        end
    elseif strcmp(port_config.rx_data_type, 'int32') || strcmp(port_config.rx_data_type, 'int16') || ...
           strcmp(port_config.rx_data_type, 'int8') || strcmp(port_config.rx_data_type, 'uint32') || ...
           strcmp(port_config.rx_data_type, 'uint16') || strcmp(port_config.rx_data_type, 'uint8')
        format_spec = '%i';
        for ii = 1:(port_config.n_rx-1)
            format_spec = strcat(format_spec, port_config.delimeter, '%i');
        end
    end

    rx = zeros(1, port_config.n_rx);
    rx = fscanf(serial_port, format_spec, [1, port_config.n_rx]);
end