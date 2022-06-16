function serialTransmitAscii(serial_port, port_config, tx)
    n_tx = port_config.n_tx;
    data_type = port_config.tx_data_type;

    switch data_type
        case 'float32'
            format_spec = '%.1f';
            for ii = 1:(n_tx-1)
                format_spec = strcat(format_spec, port_config.delimeter, '%f');
            end
        otherwise
            format_spec = '%i';
            for ii = 1:(n_tx-1)
                format_spec = strcat(format_spec, port_config.delimeter, '%i');
            end
    end

    if strcmp(port_config.terminator, 'LF')
        format_spec = strcat(format_spec, '\n');
    elseif strcmp(port_config.terminator, 'CR')
        format_spec = strcat(format_spec, '\r');
    elseif strcmp(port_config.terminator, 'CR/LF')
        format_spec = strcat(format_spec, '\r\n');
    elseif strcmp(port_config.terminator, 'LF/CR')
        format_spec = strcat(format_spec, '\n\r');
    end

    format_spec
    fprintf(serial_port, format_spec, tx);
    fprintf(format_spec, tx);
end