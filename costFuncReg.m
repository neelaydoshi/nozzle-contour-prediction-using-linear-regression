%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
%
% Note :
% -> This file computes the cost-function (J) and gradient (grad)
%
%%%%%%%%%%%%%%
function [J, grad] = costFuncReg(theta, X, y, lambda)

%%%%%%%%%%%%%%
% number of training examples
m = length(y); 
%
%%%%%%%%%%%%%%
% hypothesis function
% [m x (n+1)] * [(n+1) x 1] = [m x 1]
h = X*theta;
%
%%%%%%%%%%%%%%
% cost function
% do NOT use "theta_0" for regularization
% sum([m x 1]) = [1 x 1] 
reg = lambda*sum(theta(2:end).^2)/(2*m);
J   = sum( (h - y).^2 )/(2*m) + reg;
%
%%%%%%%%%%%%%%
% gradient 
% computing gradient of "theta_0" without regularization parameter
% [1 x m] * [m x x(n+1)] = [(n+1) x 1]' = [1 x (n+1)]
grad    = ( (h - y)' * X )'/m + lambda*theta/m;
grad(1) = grad(1) - lambda*theta(1)/m;

end
