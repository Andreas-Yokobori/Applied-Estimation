% function [outlier,Psi] = associate_known(S_bar,z,W,Lambda_psi,Q,known_associations)
%           S_bar(t)            4XM
%           z(t)                2Xn
%           W                   2XN
%           Lambda_psi          1X1
%           Q                   2X2
%           known_associations  1Xn
% Outputs: 
%           outlier             1Xn
%           Psi(t)              1XnXM
function [outlier,Psi] = associate_known(S_bar,z,W,Lambda_psi,Q,known_associations)
% FILL IN HERE

%BE SURE THAT YOUR innovation 'nu' has its second component in [-pi, pi]

% also notice that you have to do something here even if you do not have to maximize the likelihood.


M = size(S_bar,2);
N = size(W,2);
n = size(z,2);

z_hat = zeros(2,M,N);
nu = zeros(size(z_hat));
Psi = zeros(n,M);
psi = zeros(n,M,N);
outlier = zeros(1,n);

for landmark=1:N
    z_hat(:,:,landmark) = observation_model(S_bar,W,landmark);
end

normal = 1/(2*pi*sqrt(det(Q)));

for obs = 1:n
    for particle = 1:M
        for landmark = 1:N
            nu(:,particle,landmark) = z(:,obs) - z_hat(:,particle,landmark);
            nu(2,particle,landmark) = mod(nu(2,particle,landmark) + pi, 2 * pi) - pi;
            psi(obs,particle,landmark) = normal * exp(-1/2 * (nu(:,particle,landmark)' * inv(Q) * nu(:,particle,landmark)));
        end
        
        Psi(obs,particle) = psi(obs,particle,known_associations(obs));

    end

    outlier(obs) = mean(Psi(obs,:)) <= Lambda_psi;
end

Psi=reshape(Psi,[1 n M]);

end





