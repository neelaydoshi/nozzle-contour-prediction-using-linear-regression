%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
% 
% Note : 
% -> In this file we are only trying to see if linear-regression can be...
% ... used for fitting the non-linear curve of nozzle contour.
% -> You may vary the number of features in the feature-matrix "X"...
% ... to see how well the curve fits to the data.
% -> A 4th degree polynomial seems to do the job quite well.
%
% Regularization: 
% -> lambda = 0 : performs well
% -> lambda > 0 : not required 
%
% "fminunc" : 
% -> max_iter = 500 seems to suffice
% -> often reaches convergence even before max_iter 
% 
%%%%%%%%%%%%%%
% Variables you may alter :
%%%%%%%%%%%%%%
% lambda    : regularization parameter
% poly      : polynomial terms in the feature matrix 
% max_iter  : maximum number of iterations allowed for "fminunc" function
%%%%%%%%%%%%%%
%%%%%%%%%%%%%%
clc
clear
format short g

%%%%%%%%%%%%%%
% loading data 
%%%%%%%%%%%%%%
data = load('data/nozzle_1.txt');
x = data(:, 1); 
y = data(:, 2);

%%%%%%%%%%%%%%
% parameters for feature matrix
%%%%%%%%%%%%%%
m       = size(x, 1); % number of training examples
poly    = [0.5, 1, 2, 3, 4]; % powers of "x" : [x^0.5, x, x^2, x^3, x^4]
n_poly  = length(poly); % number of polynomial features
n       = n_poly; % total number of features

%%%%%%%%%%%%%%
% creating feature matrix
%%%%%%%%%%%%%%
%
% polynomial feature matrix
% X     = [x^0.5, x, x^2, x^3, x^4]
% dim   = [m x n_poly]
X = (x*ones(1, n_poly)).^poly; 
%
% normalizing the polynomial terms
% dim = [m x n_poly]
[X, mu, sigma] = feature_scaling(X);
%
% adding [bias-unit]
% dim = [m x (n+1)]
X = [ones(m, 1), X];

%%%%%%%%%%%%%%
% weight matrix
%%%%%%%%%%%%%%
initial_theta = ones(n, 1); % [n x 1] weight matrix
initial_theta = [1; initial_theta]; % [(n+1) x 1] adding bias unit

%%%%%%%%%%%%%%
% optimization 
%%%%%%%%%%%%%%
%
% set options for optimization function "fminunc"
lambda      = 0; % regularization parameter
max_iter    = 500; % maximum number of iterations
options     = optimset('GradObj', 'on', 'MaxIter', max_iter);
%
% computing optimal weights (theta)
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFuncReg(t, X, y, lambda)), initial_theta, options);

%%%%%%%%%%%%%%
% printing output
%%%%%%%%%%%%%%
fprintf('############## \n');
fprintf('Cost \t = %.3e \n', J);
fprintf('############## \n');
disp('Weights:');
disp([theta]);
fprintf('############## \n');

%%%%%%%%%%%%%%
% comparing 
%%%%%%%%%%%%%%
%
% predicted "y" values
y_pred = X*theta;
%
% plotting 
figure(1)
plot(x, y_pred, linewidth=2); % predicted "y" values
hold on
plot(x, y, '*k', linewidth=2); % original "y" values
legend('predicted', 'original', 'location', 'best')
axis equal

