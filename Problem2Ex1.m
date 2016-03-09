%% Problem 2
%% Task a
%
% error: e = sum(y_i-yhat_i)^2
%   = sum(y_i-a*x_i)^2
%
% Find a which gives lowest error:
%
% de/da = 2*sum((y_i-a*x_i)*x_i)
%       = 2*sum(y_i*x_i)-2*a*sum(x_i^2)
%
% Find best a => de/da = 0
%
% a = sum(y_i*x_i)/sum(x_i^2)
% Doing MATLAB-simulation gives: a = 0.3955
