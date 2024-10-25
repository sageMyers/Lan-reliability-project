% MATLAB Script to simulate the average number of transmissions

K_values = [1, 5, 15, 50, 100];   % Different K values to simulate
p_values = linspace(0, 1, 50);    % Range of failure probabilities
iterations = 1000;                % Number of simulation iterations
maxAttempts = 5000;               % Maximum number of attempts to prevent infinite loops

% Store the average number of transmissions for each K and p
average_transmissions = zeros(length(K_values), length(p_values));

% Loop through each value of K and simulate
for kIdx = 1:length(K_values)
    K = K_values(kIdx);
    for pIdx = 1:length(p_values)
        p = p_values(pIdx);
        transmissions = zeros(iterations, 1); % To store the result of each iteration
        
        % Run simulations for the current K and p
        for iter = 1:iterations
            transmissions(iter) = runTwoParallelLinkSim(K, p, maxAttempts);
        end
        
        % Calculate the average number of transmissions
        average_transmissions(kIdx, pIdx) = mean(transmissions);
    end
    
    % Plot the simulated result for current K
    figure;
    semilogy(p_values, average_transmissions(kIdx, :), 'ro'); % Hollow circles with log scale
    title(['Simulated Avg. Transmissions for K = ', num2str(K)]);
    xlabel('Failure probability (p)');
    ylabel('Average number of transmissions');
    grid on;
end

% Plot the results for all K values in one figure
figure;
hold on;
for kIdx = 1:length(K_values)
    semilogy(p_values, average_transmissions(kIdx, :), 'o', 'DisplayName', ['K = ', num2str(K_values(kIdx))]);
end
hold off;
title('Simulated Avg. Transmissions for All K Values');
xlabel('Failure probability (p)');
ylabel('Average number of transmissions');
legend show;
set(gca, 'YScale', 'log');
grid on;
