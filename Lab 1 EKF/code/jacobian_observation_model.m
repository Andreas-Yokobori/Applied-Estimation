% function H = jacobian_observation_model(mu_bar,M,j,z,i)
% This function is the implementation of the H function
% Inputs:
%           mu_bar(t)   3X1
%           M           2XN
%           j           1X1 which M column
%           z_hat       2Xn
%           i           1X1  which z column
% Outputs:  
%           H           2X3
function H = jacobian_observation_model(mu_bar,M,j,z_hat,i)
% Fill In This Part

H = zeros(2,3);
H(1,1) = (mu_bar(1) - M(1,j)) / z_hat(1,i);
H(1,2) = (mu_bar(2) - M(2,j)) / z_hat(1,i);
H(1,3) = 0;
H(2,1) = -(mu_bar(2) - M(2,j)) / z_hat(1,i)^2;
H(2,2) = (mu_bar(1) - M(1,j)) / z_hat(1,i)^2;
H(2,3) = -1;
end
