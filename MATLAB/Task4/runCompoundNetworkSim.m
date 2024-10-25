function transmissions = runCompoundNetworkSim(K, p, maxAttempts)
    % runCompoundNetworkSim: Simulate the number of transmissions required
    % to successfully transmit K packets across a compound network.
    % K: Number of packets to send
    % p: Probability of unsuccessful transmission
    % maxAttempts: Limit on the number of attempts
    
    transmissions = 0;
    successfulPackets = 0;
    
    while successfulPackets < K && transmissions < maxAttempts
        transmissions = transmissions + 1; % Count each transmission attempt
        if rand() > p % Transmission success if rand > p
            successfulPackets = successfulPackets + 1;
        end
    end
    
    if successfulPackets < K
        transmissions = NaN; % Assign NaN if transmission fails after maxAttempts
    end
end
