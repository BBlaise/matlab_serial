function rx_vec = serialReceiveMixed(serial_port, rx_sequence)
    n_rx = length(rx_sequence);
    rx_vec = zeros(1, n_rx);
    for jj = 1:n_rx
        temp = fread(serial_port, 4, 'uint8');
        temp = typecast(uint8(temp), 'uint32');
        temp = typecast(temp, 'single');
%         temp = swapbytes(temp);           % msp432?
        rx_vec(jj) = temp;           
    end
end