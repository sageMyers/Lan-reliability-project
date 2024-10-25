% SingleLinkSimulation.m
% Main program to simulate and plot results for different K values

% Values for the number of packets K
K_values = [1, 5, 15, 50, 100];

% Number of simulations to run
N = 1000;

% Values of probability p (probability of packet failure)
p_values = 0:0.01:0.99; % avoid p = 1 to prevent division by zero in calculation

% Preallocate matrices to store the simulated and calculated results
simulated_results = zeros(length(K_values), length(p_values));
calculated_results = zeros(length(K_values), length(p_values));

% Loop over each value of K
for k_idx = 1:length(K_values)
    K = K_values(k_idx);
    
    % Loop over each value of p
    for p_idx = 1:length(p_values)
        p = p_values(p_idx);
        
        % Run the simulation and store the result
        simulated_results(k_idx, p_idx) = runSingleLinkSim(K, p, N);
        
        % Calculate the theoretical number of transmissions
        calculated_results(k_idx, p_idx) = K / (1 - p);
    end
    
    % Plot results for each K value individually
    figure;
    semilogy(p_values, calculated_results(k_idx, :), 'LineWidth', 2, 'DisplayName', 'Calculated');
    hold on;
    semilogy(p_values, simulated_results(k_idx, :), 'o', 'DisplayName', 'Simulated');
    xlabel('Probability of Packet Failure (p)');
    ylabel('Average Number of Transmissions');
    title(['K = ' num2str(K) ' packets']);
    legend show;
    grid on;
end

% Plot all K values on a single figure
figure;
hold on;
colors = lines(length(K_values)); % Generate distinct colors for each K
for k_idx = 1:length(K_values)
    K = K_values(k_idx);
    semilogy(p_values, calculated_results(k_idx, :), 'Color', colors(k_idx, :), 'LineWidth', 2, 'DisplayName', ['Calculated K=' num2str(K)]);
    semilogy(p_values, simulated_results(k_idx, :), 'o', 'Color', colors(k_idx, :), 'DisplayName', ['Simulated K=' num2str(K)]);
end
xlabel('Probability of Packet Failure (p)');
ylabel('Average Number of Transmissions');
title('Calculated and Simulated Results for Different K Values');
legend show;
grid on;