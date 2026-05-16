%% Load Data

train_data = readmatrix('data/coke_gas_train.csv');
test_data  = readmatrix('data/coke_gas_test.csv');

%% FCM Clustering

num_clusters = 2;

[cluster_centers, membership_matrix] = fcm(train_data(:, 1:4), num_clusters);
[~, dominant_cluster] = max(membership_matrix, [], 1);

cluster_1 = train_data(dominant_cluster == 1, :);
cluster_2 = train_data(dominant_cluster == 2, :);

%% Plot Clustered Data

figure;

plot(cluster_1(:,1), cluster_1(:,5), 'ro');
hold on;
plot(cluster_2(:,1), cluster_2(:,5), 'bo');

grid on;

xlabel('Temperature (C)');
ylabel('Ethylene fraction concentration (%)');

legend('Cluster 1', 'Cluster 2');
title('FCM Clustering of Training Data');

hold off;

saveas(gcf, 'results/plots/clustered_data_fcm.png');

%% Train Neural Network for Cluster 1

X_cluster_1 = cluster_1(:, 1:4)';
Y_cluster_1 = cluster_1(:, 5)';

hidden_layer_1 = 5;
hidden_layer_2 = 20;

net_cluster_1 = newff( ...
    minmax(X_cluster_1), ...
    [hidden_layer_1 hidden_layer_2 1], ...
    {'tansig', 'tansig', 'purelin'}, ...
    'trainlm');

net_cluster_1.trainParam.show = 1;
net_cluster_1.trainParam.epochs = 10000;
net_cluster_1.trainParam.goal = 0.01;

net_cluster_1 = train(net_cluster_1, X_cluster_1, Y_cluster_1);

Y_cluster_1_pred = sim(net_cluster_1, X_cluster_1);

figure;

plot(Y_cluster_1', '--b', 'LineWidth', 1.5);
hold on;
plot(Y_cluster_1_pred', '-r', 'LineWidth', 1.5);

grid on;

xlabel('Sample index');
ylabel('Ethylene fraction concentration (%)');

legend('Real values', 'Model prediction');
title('Cluster 1 Neural Network Approximation');

hold off;

saveas(gcf, 'results/plots/cluster1_nn_prediction.png');

%% Train Neural Network for Cluster 2

X_cluster_2 = cluster_2(:, 1:4)';
Y_cluster_2 = cluster_2(:, 5)';

net_cluster_2 = newff( ...
    minmax(X_cluster_2), ...
    [hidden_layer_1 hidden_layer_2 1], ...
    {'tansig', 'tansig', 'purelin'}, ...
    'trainlm');

net_cluster_2.trainParam.show = 1;
net_cluster_2.trainParam.epochs = 10000;
net_cluster_2.trainParam.goal = 0.01;

net_cluster_2 = train(net_cluster_2, X_cluster_2, Y_cluster_2);

Y_cluster_2_pred = sim(net_cluster_2, X_cluster_2);

figure;

plot(Y_cluster_2', '--b', 'LineWidth', 1.5);
hold on;
plot(Y_cluster_2_pred', '-r', 'LineWidth', 1.5);

grid on;

xlabel('Sample index');
ylabel('Ethylene fraction concentration (%)');

legend('Real values', 'Model prediction');
title('Cluster 2 Neural Network Approximation');

hold off;

saveas(gcf, 'results/plots/cluster2_nn_prediction.png');

%% Test Both Cluster Models on External Test Dataset

X_test = test_data(:, 1:4)';
Y_test = test_data(:, 5)';

Y_test_pred_cluster_1 = sim(net_cluster_1, X_test);
Y_test_pred_cluster_2 = sim(net_cluster_2, X_test);

figure;

plot(Y_test', '--b', 'LineWidth', 1.5);
hold on;
plot(Y_test_pred_cluster_1', '-r', 'LineWidth', 1.5);
plot(Y_test_pred_cluster_2', '-g', 'LineWidth', 1.5);

grid on;

xlabel('Sample index');
ylabel('Ethylene fraction concentration (%)');

legend( ...
    'Real values', ...
    'Cluster 1 model', ...
    'Cluster 2 model');

title('Clustered Neural Networks: External Test Prediction');

hold off;

saveas(gcf, 'results/plots/clustered_nn_test_prediction.png');

%% Save Models and Metrics

save('results/models/net_cluster_1.mat', 'net_cluster_1');
save('results/models/net_cluster_2.mat', 'net_cluster_2');

cluster_summary = [
    1, size(cluster_1, 1), mean(cluster_1(:,5)), std(cluster_1(:,5));
    2, size(cluster_2, 1), mean(cluster_2(:,5)), std(cluster_2(:,5))
];

cluster_summary_table = array2table(cluster_summary, ...
    'VariableNames', {'Cluster', 'Samples', 'MeanTarget', 'StdTarget'});

writetable(cluster_summary_table, ...
    'results/metrics/cluster_summary.csv');

predictions = [
    Y_test', ...
    Y_test_pred_cluster_1', ...
    Y_test_pred_cluster_2'
];

predictions_table = array2table(predictions, ...
    'VariableNames', { ...
    'RealValue', ...
    'Cluster1ModelPrediction', ...
    'Cluster2ModelPrediction'});

writetable(predictions_table, ...
    'results/metrics/clustered_nn_test_predictions.csv');