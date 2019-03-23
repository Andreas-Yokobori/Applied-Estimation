% function [mu,sigma,R,Q,Lambda_M] = init()
% This function initializes the parameters of the filter.
% Outputs:
%			mu(0):			3X1
%			sigma(0):		3X3
%			R:				3X3
%			Q:				2X2
function [mu,sigma,R,Q,Lambda_M] = init()
mu = [0;0;0]; % initial estimate of state
sigma = 1e-10*diag([1 1 1]); % initial covariance matrix
delta_m = 0.999; %0.999 originally
Lambda_M = chi2inv(delta_m,2);
% Fill In This Part

% runlocalization_track('so_o3_ie.txt', 'map_o3.txt', 1, 1, 1, 2);

% R = diag([0.01 0.01 pi/180].^2); 
% Q = diag([0.01 pi/180].^2);         %Q and R for 1st map

% runlocalization_track('so_pb_10_outlier.txt','map_pent_big_10.txt', 1, 1, 1, 2);

R = diag([0.01 0.01 2*pi/180].^2);
Q = diag([0.2 0.2].^2);               %Q and R for 2nd map
 
% runlocalization_track('so_pb_40_no.txt','map_pent_big_40.txt', 1, 1, 1, 2);

% R = diag([1 1 1].^2);
% Q = diag([0.1 0.1].^2);               %Q and R for 3rd map
end