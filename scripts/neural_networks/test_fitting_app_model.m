
%% Load Data

train_data = readmatrix('data/coke_gas_train.csv');
test_data  = readmatrix('data/coke_gas_test.csv');

X_test = test_data(:, 1:4);
Y_test = test_data(:, 5);

%% Load Neural Network Fitting App Model
load('results/models/nn_fitting_app_network.mat');

Y_pred = net(X_test');

%% Plot Results

figure;

plot(Y_test, '--b', 'LineWidth', 1.5);
hold on;

plot(Y_pred', '-r', 'LineWidth', 1.5);

grid on;

xlabel('Sample index');
ylabel('Ethylene fraction concentration (%)');

legend('Real values', 'Model prediction');

title('Neural Network Fitting App: Test Prediction');

hold off;

saveas(gcf, 'results/plots/nn_fitting_app_test_prediction.png');

%% Save Predictions

results = [Y_test, Y_pred'];

writematrix(results, ...
    'results/metrics/nn_fitting_app_test_predictions.csv');