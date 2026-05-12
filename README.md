# Intelligent Data Analysis and Neural Modeling in MATLAB

This project contains a comparative study of machine learning, clustering, neural network, and fuzzy logic approaches for modeling industrial process data in MATLAB.

The work includes:

* fuzzy clustering (FCM and Subtractive Clustering),
* feedforward neural networks,
* ANFIS neuro-fuzzy systems,
* fuzzy inference systems,
* model comparison and testing.

The experiments were performed on industrial process monitoring data related to low-temperature coke gas separation.

## Dataset

The dataset contains industrial process monitoring data related to low-temperature coke gas separation.

### Input Features

* Temperature
* Valve opening percentage
* Coke gas flow
* Nitrogen flow

### Target Variable

* Ethylene fraction concentration

The dataset was divided into:

* training subset (`coke_gas_train.csv`)
* testing subset (`coke_gas_test.csv`)

## Methods

The project includes several intelligent data analysis approaches implemented in MATLAB:

### Fuzzy Clustering

* Fuzzy C-Means (FCM)
* Subtractive Clustering

### Neural Networks

* Feedforward neural networks
* Levenberg-Marquardt training algorithm
* Multiple hidden layer configurations

### Neuro-Fuzzy Modeling

* ANFIS (Adaptive Neuro-Fuzzy Inference System)
* Sugeno FIS models
* Grid Partition and Subtractive Clustering initialization

### Fuzzy Inference Systems

* Mamdani fuzzy systems
* Rule-based decision making
