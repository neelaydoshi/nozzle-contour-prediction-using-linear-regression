%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
% 
% Note : 
% -> This file checks the weights (theta) calculated by "main_2_normal_train.m"...
% ... by using them to predict "y_pred" for the "nozzle_test.txt" dataset.
% 
%%%%%%%%%%%%%%
% Variables you may alter :
%%%%%%%%%%%%%%
% interval  : change the multiple to skip plotting some of the nozzles
%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%
clc
clear

%%%%%%%%%%%%%%
% loading data 
data    = load('data/nozzle_test.txt');
load('data/parameters_normal.mat');
%
x   = data(:, 1); 
M0  = data(:, 2);
Me  = data(:, 3);
y   = data(:, 4);

%%%%%%%%%%%%%%
mach = 50; % number of characteristic lines
m = length(x); % total number of examples

%%%%%%%%%%%%%%
% creating feature matrix for testing exmple
%%%%%%%%%%%%%%
X = create_feature_matrix(x, M0, Me);
X = [ones(m, 1), X]; % adding bias unit

%%%%%%%%%%%%%%
% predicted "y" values
%%%%%%%%%%%%%%
y_pred = X*theta;

%%%%%%%%%%%%%%
% calculating cost
J   = sum( (y_pred - y).^2 )/(2*m);
fprintf('############## \n');
fprintf('Cost = %.6f \n', J);
fprintf('############## \n');

%%%%%%%%%%%%%%
% plotting 
interval = 4*mach; % multiple of number of characteristic-lines
for i = 1 : interval : m-interval
    figure(1)
    plot(x(i:i+mach-1), y_pred(i:i+mach-1), linewidth=2);
    hold on
    plot(x(i:i+mach-1), y(i:i+mach-1), '*k', linewidth=2);
    axis equal
end









