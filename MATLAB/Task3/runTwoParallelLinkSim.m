function transmissions = runTwoParallelLinkSim(K, p, maxAttempts)
    % Simulates the number of transmissions needed to send K packets across 
    % two parallel links, where each link has a failure probability p.
    % maxAttempts limits the number of transmission attempts.
    
    transmissions = 0; % Initialize transmission count
    
    for i = 1:K
        success = false;
        attemptCount = 0;
        
        % Repeat until the packet is successfully transmitted across one link
        while ~success && attemptCount < maxAttempts
            attemptCount = attemptCount + 1;
            transmissions = transmissions + 1; % One transmission per packet
            
            % Success occurs if at least one of the two links successfully transmits
            if rand() > p || rand() > p
                success = true;
            end
        end
    end
end
