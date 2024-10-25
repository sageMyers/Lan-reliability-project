function avgTransmissions = runTwoSeriesLinkSim(K, p, numIterations)
    % Maximum allowed attempts per packet
    maxAttempts = 5000;
    
    % Initialize variable to store total transmissions
    totalTransmissions = 0;
    
    for iter = 1:numIterations
        transmissions = 0;
        % Simulate the transmission of all K packets
        for pkt = 1:K
            % Count how many attempts it takes to successfully send the packet
            % through two series links (each link has failure probability p).
            success = false;
            attempts = 0;
            while ~success && attempts < maxAttempts
                attempts = attempts + 1;
                if rand > p && rand > p
                    success = true;
                end
            end
            transmissions = transmissions + attempts;
        end
        totalTransmissions = totalTransmissions + transmissions;
    end
    
    % Calculate average number of transmissions
    avgTransmissions = totalTransmissions / numIterations;
end
