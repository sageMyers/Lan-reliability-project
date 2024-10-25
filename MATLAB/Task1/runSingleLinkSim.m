% runSingleLinkSim.m
function result = runSingleLinkSim(K, p, N)
    % Simulate the number of transmissions required to transmit K packets
    % through a single link with failure probability p, over N simulations.

    simResults = ones(1, N); % a place to store the result of each simulation

    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        % Simulate the transmission of K packets
        while pktSuccessCount < K
            r = rand; % generate random number to determine if packet is successful
            txAttemptCount = txAttemptCount + 1; % count the first attempt

            % If the random number is greater than p, the packet is successful
            while r < p
                r = rand; % retransmit, generate a new success check value
                txAttemptCount = txAttemptCount + 1; % count additional attempts
            end

            pktSuccessCount = pktSuccessCount + 1; % increase success count
        end

        simResults(i) = txAttemptCount; % record total number of attempts
    end

    result = mean(simResults); % return the average number of transmissions
end
