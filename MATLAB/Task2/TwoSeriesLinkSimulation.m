% Main script to run simulations for different K values and plot results

% Parameters
K_values = [1, 5, 15, 50, 100];  % Different values of K
p_values = 0:0.01:1;  % Probability of unsuccessful transmission
numIterations = 10;  % Number of iterations for the simulation

% Initialize figure for combined plot of all K values
figure;
hold on;
colors = lines(length(K_values));  % Color scheme for different K values

% Initialize waitbar
hWaitBar = waitbar(0, 'Running simulations...');

% Total number of iterations across all K and p values
totalSteps = length(K_values) * length(p_values);
currentStep = 0;

try
    % Loop over each K value
    for i = 1:length(K_values)
        K = K_values(i);
        
        % Preallocate arrays for results
        simulatedResults = zeros(size(p_values));
        calculatedResults = zeros(size(p_values));
        
        % Loop over each probability value
        for j = 1:length(p_values)
            p = p_values(j);
            
            % Run simulation
            simulatedResults(j) = runTwoSeriesLinkSim(K, p, numIterations);
            
            % Calculated result for the expected number of transmissions
            calculatedResults(j) = K * (1 / (1 - p)^2);  % Derived formula for 2 series links
            
            % Update the progress bar
            currentStep = currentStep + 1;
            waitbar(currentStep / totalSteps, hWaitBar, sprintf('Progress: %d%%', round((currentStep / totalSteps) * 100)));
        end
        
        % Plot results for this value of K
        figure;
        semilogy(p_values, calculatedResults, 'LineWidth', 2, 'Color', colors(i, :));
        hold on;
        semilogy(p_values, simulatedResults, 'o', 'MarkerEdgeColor', colors(i, :), 'MarkerFaceColor', 'none');
        title(['Simulated vs Calculated Results for K = ', num2str(K)]);
        xlabel('Probability of Unsuccessful Transmission (p)');
        ylabel('Average Number of Transmissions');
        legend('Calculated', 'Simulated');
        grid on;
        
        % Add this K value to the combined plot
        semilogy(p_values, calculatedResults, 'LineWidth', 2, 'Color', colors(i, :));
        semilogy(p_values, simulatedResults, 'o', 'MarkerEdgeColor', colors(i, :), 'MarkerFaceColor', 'none');
    end
    
    % Customize the combined plot
    figure(1);
    title('Simulated vs Calculated Results for All K Values');
    xlabel('Probability of Unsuccessful Transmission (p)');
    ylabel('Average Number of Transmissions');
    legend(arrayfun(@(K) ['K = ', num2str(K)], K_values, 'UniformOutput', false));
    grid on;
    hold off;

catch ME
    % Handle any errors that occur during execution
    disp('An error occurred during simulation:');
    disp(ME.message);
end

% Close the waitbar when finished
close(hWaitBar);
