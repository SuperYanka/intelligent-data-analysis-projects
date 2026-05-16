%% Random Data Generation
% Synthetic dataset for fuzzy clustering experiments

rng(9);                     % Reproducibility
random_data = rand(27,2);   % 27 points, 2 features

%% Fuzzy C-Means Clustering

num_clusters = 3;

[cluster_centers, U, objective_function] = ...
    fcm(random_data, num_clusters);

%% Visualization

figure;
hold on;
grid on;

plot(random_data(:,1), random_data(:,2), ...
    'ko', 'MarkerFaceColor', 'w');

title('Fuzzy Clustering of Synthetic Data');
xlabel('Feature 1');
ylabel('Feature 2');

% Dominant cluster for each point
[~, dominant_cluster] = max(U, [], 1);

markers = {'ro','go','bo','mo','co','yo'};

for i = 1:num_clusters

    idx = dominant_cluster == i;

    plot(random_data(idx,1), ...
         random_data(idx,2), ...
         markers{i}, ...
         'MarkerSize', 7, ...
         'LineWidth', 1.5);
end

%% FCM Cluster Centers

plot(cluster_centers(:,1), ...
     cluster_centers(:,2), ...
     'ks', ...
     'MarkerSize', 12, ...
     'LineWidth', 2);

%% Subtractive Clustering

[subtractive_centers, S] = subclust(random_data, 0.5);

plot(subtractive_centers(:,1), ...
     subtractive_centers(:,2), ...
     'kd', ...
     'MarkerSize', 12, ...
     'LineWidth', 2);

legend( ...
    'Data points', ...
    'Cluster 1', ...
    'Cluster 2', ...
    'Cluster 3', ...
    'FCM centers', ...
    'Subtractive centers');

hold off;

%% Membership Matrix

disp('Membership matrix U:');
disp(U);