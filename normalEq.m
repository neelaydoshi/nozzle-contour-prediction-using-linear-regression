%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
%
% This function file computes the closed-form solution to linear... 
% ... regression using the normal equations.
%
%%%%%%%%%%%%%%
function [theta] = normalEq(X, y, lambda)

% [(n+1) x (n+1)]
I_semi = eye(size(X, 2));
I_semi(1, 1) = I_semi(1, 1) - 1;

% [(n+1) x 1] = ( [(n+1) x (n+1)] * [(n+1) x m] ) * [m x 1]
theta  = inv( X'*X + lambda*I_semi ) * X' * y;

end
