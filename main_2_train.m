%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
% 
% Note : 
% -> Training dataset with 50 nozzle, each with 50 points
% -> This means we have a total of 2500 examples
%
% Regularization: 
% -> lambda = 0 performs well even on test dataset 
%
% "fminunc" : 
% -> max_iter = 500 seems to suffice
% -> often reaches convergence even before max_iter 
% 
%%%%%%%%%%%%%%
% Variables you may alter :
%%%%%%%%%%%%%%
% k         : number of examples to import from dataset
% max_iter  : maximum number of iterations allowed for "fminunc" function
% interval  : change the multiple to skip plotting some of the nozzles
%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%
% Features : 
%%%%%%%%%%%%%%
% sqrt(x), x, x^2, x^3, x^4, ... 
% M0, M0*sqrt(x), M0*x, M0^2*x, M0*x^2, ...
% Me, Me*sqrt(x), Me*x, Me^2*x, M0*x^2
%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%
clc
clear
format short g


%%%%%%%%%%%%%%
% loading data 
%%%%%%%%%%%%%%
data= load('data/nozzle_train.txt');
k   = size(data, 1); % restricting dataset size (if needed)
x   = data(1:k, 1); 
M0  = data(1:k, 2);
Me  = data(1:k, 3);
y   = data(1:k, 4);

%%%%%%%%%%%%%%
% optimization parameters
lambda  = 0; % regularization parameter
max_iter= 500; % number of iterations in gradientd-escent

%%%%%%%%%%%%%%
% creating feature matrix
%%%%%%%%%%%%%%
X = create_feature_matrix(x, M0, Me);
[m, n] = size(X); % number of training examples and features
[X, mu, sigma] = feature_scaling(X);
X = [ones(m, 1), X]; % adding bias unit

%%%%%%%%%%%%%%
% weight matrix
%%%%%%%%%%%%%%
initial_theta = ones(n, 1); % [n x 1] weight matrix
initial_theta = [1; initial_theta]; % [(n+1) x 1] adding bias unit

%%%%%%%%%%%%%%
% optimal weights (theta)
%%%%%%%%%%%%%%
options = optimset('GradObj', 'on', 'MaxIter', max_iter);
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
% predicted "y" values
y_pred = X*theta;
% 
% plotting 
mach        = 50; % number of points in a single nozzle contour
interval    = 7*mach; % multiple of number of characteristic-lines
%
figure(1)
for i = 1 : interval : m-interval
    plot(x(i:i+mach-1), y_pred(i:i+mach-1), linewidth=2);
    hold on
    plot(x(i:i+mach-1), y(i:i+mach-1), '*k', linewidth=2);
    axis equal
end



%% %%%%%%%%%%%%
%%%%%%%%%%%%%%
% saving data
%%%%%%%%%%%%%%
%
% saving the necessary data to ".mat" file, so that it can be inported...
% ... by "main_2_test.m" for testing on "nozzle_test.txt" dataset.
%
save('data/parameters_2.mat', 'theta', 'lambda', 'mu', 'sigma');








