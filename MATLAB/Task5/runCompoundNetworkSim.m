function transmissions = runCompoundNetworkSim(K, p, maxAttempts)
    % runCompoundNetworkSim: Simulate the number of transmissions required
    % to successfully transmit K packets across a compound network.
    %
    % Parameters:
    %   K - Number of packets to transmit
    %   p - Probability of unsuccessful transmission
    %   maxAttempts - Maximum number of transmission attempts allowed
    %
    % Returns:
    %   transmissions - The number of transmission attempts required
    
    transmissions = 0;        % Counter for the number of attempts
    successfulPackets = 0;    % Counter for the number of successfully transmitted packets
    
    % Keep attempting transmissions until either K packets are sent or maxAttempts is reached
    while successfulPackets < K && transmissions < maxAttempts
        transmissions = transmissions + 1;  % Increment the transmission count
        if rand() > p  % Transmission is successful if random value > p
            successfulPackets = successfulPackets + 1;
        end
    end
    
    % If we hit the maximum number of attempts without success, mark as NaN
    if successfulPackets < K
        transmissions = NaN;
    end
end
