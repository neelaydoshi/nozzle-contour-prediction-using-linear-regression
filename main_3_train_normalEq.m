%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
% 
% Note : 
% -> This function file computes the closed-form solution to linear... 
% ... regression using the normal equations.
% -> Feature scaling is not required.
% -> Training dataset with 50 nozzle, each with 50 points.
% -> This means we have a total of 2500 examples.
% 
% Regularization: 
% -> lambda = 0 performs well even on test dataset 
% 
%%%%%%%%%%%%%%
% Variables you may alter :
%%%%%%%%%%%%%%
% k         : number of examples to import from dataset
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
k   = size(data, 1); % restricting dataset size
x   = data(1:k, 1); 
M0  = data(1:k, 2);
Me  = data(1:k, 3);
y   = data(1:k, 4);


%%%%%%%%%%%%%%
% creating feature matrix
%%%%%%%%%%%%%%
X = create_feature_matrix(x, M0, Me);
m = size(X, 1); % number of training examples
n = size(X, 2); % number of features
X = [ones(m, 1), X]; % adding bias unit

%%%%%%%%%%%%%%
% weight matrix
%%%%%%%%%%%%%%
lambda  = 0;
theta   = normalEq(X, y, lambda);

%%%%%%%%%%%%%%
% calculating cost
%%%%%%%%%%%%%%
y_pred  = X*theta;
J       = sum( (y_pred - y).^2 )/(2*m);

%%%%%%%%%%%%%%
fprintf('############## \n');
fprintf('Cost = %.6f \n', J);
fprintf('############## \n');
disp('Weights:');
disp([theta]);
fprintf('############## \n');


%%%%%%%%%%%%%%
% plotting 
mach = 50; % number of points in a single nozzle contour
interval = 7*mach; % multiple of number of characteristic-lines
for i = 1 : interval : m-interval
    figure(1)
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
% ... by "main_2_test_normal.m" for testing on "nozzle_test.txt" dataset.
%
save('data/parameters_normal.mat', 'theta', 'lambda');




