%% Feature Extraction

temperature = data(:,1);
valve_opening = data(:,2);
coke_gas_flow = data(:,3);
nitrogen_flow = data(:,4);

ethylene_concentration = data(:,5);

%% Visualization

figure;

plot(temperature, ...
     ethylene_concentration, ...
     'o-', ...
     'LineWidth', 1.5);

grid on;

xlabel('Temperature (C)');
ylabel('Ethylene Fraction Concentration (%)');

title('Dependence of Ethylene Concentration on Temperature');

%% Polynomial Approximation

poly_degree = 9;

poly_coefficients = polyfit( ...
    temperature, ...
    ethylene_concentration, ...
    poly_degree);

temperature_fit = linspace( ...
    min(temperature), ...
    max(temperature), ...
    200);

y_fit = polyval(poly_coefficients, temperature_fit);

figure;

plot(temperature, ...
     ethylene_concentration, ...
     'bo');

hold on;

plot(temperature_fit, ...
     y_fit, ...
     'r-', ...
     'LineWidth', 2);

grid on;

xlabel('Temperature (C)');
ylabel('Ethylene Fraction Concentration (%)');

title('Polynomial Approximation');

legend('Experimental data', ...
       'Polynomial fit');

hold off;

%% Spline Interpolation

spline_fit = spline( ...
    temperature, ...
    ethylene_concentration, ...
    temperature_fit);

figure;

plot(temperature, ...
     ethylene_concentration, ...
     'bo');

hold on;

plot(temperature_fit, ...
     spline_fit, ...
     'g-', ...
     'LineWidth', 2);

grid on;

xlabel('Temperature (C)');
ylabel('Ethylene Fraction Concentration (%)');

title('Spline Interpolation');

legend('Experimental data', ...
       'Spline interpolation');

hold off;

%% Statistical Analysis

minimum_value = min(ethylene_concentration);
maximum_value = max(ethylene_concentration);

mean_value = mean(ethylene_concentration);

standard_deviation = std(ethylene_concentration);

disp('Statistical analysis:');

fprintf('Minimum value: %.3f\n', minimum_value);
fprintf('Maximum value: %.3f\n', maximum_value);
fprintf('Mean value: %.3f\n', mean_value);
fprintf('Standard deviation: %.3f\n', standard_deviation);