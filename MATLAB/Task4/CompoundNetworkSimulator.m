% Main script to run simulations

% Set up parameters
K_values = [1, 5, 15, 50, 100]; % Different K values
p_values = linspace(0, 1, 100); % Transmission failure probabilities (p)
iterations = 1000; % Number of simulation iterations
maxAttempts = 1000; % Maximum number of transmission attempts

% Preallocate space for results
all_results = NaN(length(K_values), length(p_values));

% Loop over different K values
for k_idx = 1:length(K_values)
    K = K_values(k_idx);
    avg_transmissions = NaN(1, length(p_values)); % To store average transmissions for each p
    
    % Loop over different values of p
    for p_idx = 1:length(p_values)
        p = p_values(p_idx);
        transmissions_record = NaN(1, iterations);
        
        % Run simulation for 1000 iterations
        for i = 1:iterations
            transmissions_record(i) = runCompoundNetworkSim(K, p, maxAttempts);
        end
        
        % Calculate average number of transmissions, excluding NaN (failed cases)
        avg_transmissions(p_idx) = nanmean(transmissions_record);
    end
    
    % Store results
    all_results(k_idx, :) = avg_transmissions;
    
    % Plot results for this K
    figure;
    semilogy(p_values, avg_transmissions, 'ro'); % Plot with hollow circles
    title(['Average Transmissions for K = ', num2str(K)]);
    xlabel('Probability of unsuccessful transmission (p)');
    ylabel('Average number of transmissions');
    grid on;
end

% Plot all K values on a single figure
figure;
hold on;
for k_idx = 1:length(K_values)
    K = K_values(k_idx);
    semilogy(p_values, all_results(k_idx, :), 'o-', 'DisplayName', ['K = ' num2str(K)]);
end
hold off;
title('Average Transmissions for different K values');
xlabel('Probability of unsuccessful transmission (p)');
ylabel('Average number of transmissions');
legend show;
grid on;
set(gca, 'YScale', 'log'); % Logarithmic y-scale for readability
