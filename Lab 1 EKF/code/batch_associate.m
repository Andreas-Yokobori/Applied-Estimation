% function [c,outlier, nu_bar, H_bar] = batch_associate(mu_bar,sigma_bar,z,M,Lambda_m,Q)
% This function should perform the maximum likelihood association and outlier detection.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           Q                   2X2
%           z(t)                2Xn
%           M                   2XN
%           Lambda_m            1X1
% Outputs: 
%           c(t)                1Xn
%           outlier             1Xn
%           nu_bar(t)           2nX1
%           H_bar(t)            2nX3
function [c,outlier, nu_bar, H_bar] = batch_associate(mu_bar,sigma_bar,z,M,Lambda_m,Q)
% FILL IN HERE

    N = size(M,2);
    n = size(z,2);
    H = zeros(2,3,N);
    S = zeros(2,2,N);
    psi = zeros(1,N);
    z_hat = zeros(2,N);
    nu = zeros(2,N);
    c = zeros(1,N);
    outlier = zeros(1,N);
    D = zeros(1,N);
    nu_bar = zeros(2 * N,1);
    H_bar = zeros(2 * N,3);



    for j = 1:N
        z_hat(:,j) = observation_model(mu_bar,M,j);
        H(:,:,j) = jacobian_observation_model(mu_bar,M,j,z_hat,j);
        S(:,:,j) = H(:,:,j) * sigma_bar * H(:,:,j)' + Q;
    end

    for i = 1:n
        for j = 1:N
            nu(:,j) = z(:,i) - z_hat(:,j);
            nu(2,j) = mod(nu(2,j) + pi,2 * pi) - pi;
            D(1,j) = nu(:,j)' * inv(S(:,:,j)) * nu(:,j);
            psi(j) = 1/sqrt(det(2 * pi * S(:,:,j))) * exp(-1/2 * D(1,j));    
        end

        [~, c(i)] = max(psi);
        outlier(i) = (D(c(i)) >= Lambda_m);

        nu_bar(2 * i - 1: 2 * i) = nu(:,c(i));
        H_bar(2 * i - 1: 2 * i,:) = H(:,:,c(i));   


    end
end