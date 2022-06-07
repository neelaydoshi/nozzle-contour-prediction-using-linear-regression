%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
% 
% Note : 
% -> This is a function file for scaling the feature-matrix "X"
% -> X must NOT contain the bias-unit
% -> Use the same "mu" and "sigma" value when running the test case
%
%%%%%%%%%%%%%%
function [X_scaled, mu, sigma] = feature_scaling(X)
mu      = mean(X, 1); % mean
sigma   = std(X, 1); % standard deviation
X_scaled= (X - mu)./sigma;
end