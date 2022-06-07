%%%%%%%%%%%%%%
% Title  : SERN Contour Prediction Using Linear Regression
% Author : Neelay Doshi
%%%%%%%%%%%%%%
%
% Note : 
% -> This is a function file for creating feature-matrix "X"
% -> bias-unit has not been added
%
%%%%%%%%%%%%%%
function out = create_feature_matrix(x, M0, Me)

%%%%%%%%%%%%%%
% initializing some variables
m       = size(x, 1); % number of training examples
poly    = [0.5, 1, 2, 3, 4]; % number of "x^n" type of polynomial features
n_poly  = length(poly);

%%%%%%%%%%%%%%
% creating features
%
% [sqrt(x), x, x^2, x^3, x^4]
f_x = (x*ones(1, n_poly)).^poly; % "x^n" feature matrix
%
% [M0, M0*sqrt(x), M0*x, M0^2*x, M0*x^2]
f_M0 = M0.*[ones(m, 1), sqrt(x), x, M0.*x, x.^2]; % feature matrix with M0 
%
% [Me, Me*sqrt(x), Me*x, Me^2*x, M0*x^2]
f_Me = Me.*[ones(m, 1), sqrt(x), x, Me.*x, x.^2]; % feature matrix with Me

%%%%%%%%%%%%%%
% combining features into single matrix
out = [f_x, f_M0, f_Me]; % final feature matrix

end



% %%%%%%%%%%%%%%
% % normalizing features 
% f_x     = f_x./max(f_x, [], 1);
% f_M0    = f_M0./max(f_M0, [], 1);
% f_Me    = f_Me./max(f_Me, [], 1);