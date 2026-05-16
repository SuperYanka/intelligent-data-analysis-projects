%% Load prepared datasets

train_data = readmatrix('data/coke_gas_train.csv');
test_data  = readmatrix('data/coke_gas_test.csv');


%% Prepare inputs and targets

X_train = train_data(:, 1:4)';
Y_train = train_data(:, 5)';

X_test = test_data(:, 1:4)';
Y_test = test_data(:, 5)';

%% Create neural network

hidden_layer_1 = 5;
hidden_layer_2 = 40;

net = newff( ...
    minmax(X_train), ...
    [hidden_layer_1 hidden_layer_2 1], ...
    {'tansig', 'tansig', 'purelin'}, ...
    'trainlm');

net.trainParam.show = 1;
net.trainParam.epochs = 10000;
net.trainParam.goal = 0.01;

% Train model

net = train(net, X_train, Y_train);

% Train prediction

Y_train_pred = sim(net, X_train);

figure;
plot(Y_train', '--b');
hold on;
plot(Y_train_pred', '-r');
legend('Real values', 'Model prediction');
grid on;
title('Neural Network Approximation on Training Data');
xlabel('Sample index');
ylabel('Ethylene fraction concentration (%)');
hold off;

% Test prediction

Y_test_pred = sim(net, X_test);

figure;
plot(Y_test', '--b');
hold on;
plot(Y_test_pred', '-r');
legend('Real values', 'Model prediction');
grid on;
title('Neural Network Approximation on Test Data');
xlabel('Sample index');
ylabel('Ethylene fraction concentration (%)');
hold off;

%% Save model and results

% save('results/models/nn_5_40_goal001.mat', 'net');
% 
% writematrix(Y_train_pred', 'results/metrics/nn_train_predictions.csv');
% writematrix(Y_test_pred', 'results/metrics/nn_test_predictions.csv');