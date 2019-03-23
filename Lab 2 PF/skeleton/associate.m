% function [outlier,Psi] = associate(S_bar,z,W,Lambda_psi,Q)
%           S_bar(t)            4XM
%           z(t)                2Xn
%           W                   2XN
%           Lambda_psi          1X1
%           Q                   2X2
% Outputs: 
%           outlier             1Xn
%           Psi(t)              1XnXM
function [outlier,Psi] = associate(S_bar,z,W,Lambda_psi,Q)
% FILL IN HERE

%BE SURE THAT YOUR innovation 'nu' has its second component in [-pi, pi]


n = size(z,2);
M = size(S_bar,2);
N = size(W,2);

z_hat = zeros(2,n,M);
Psi = zeros(1,n,M);

Q_inv_diag = diag(inv(Q));
big_Q = repmat(Q_inv_diag, [1 N M]);



for j = 1:N
    z_hat(:,j,:) = observation_model(S_bar, W, j);
end

normal = 1/(2*pi*sqrt(det(Q)));

for obs = 1:n
    nu(1,:,:) = z(1,obs) - z_hat(1,:,:);
    nu(2,:,:) = mod(z(2,obs) - z_hat(2,:,:) + pi,2 * pi) - pi;
    psi = squeeze(exp(sum(-1/2 * nu .* big_Q .* nu,1)));
    Psi(1,obs,:) = normal * max(psi,[],1);
end

outlier = mean(reshape(Psi, n, M),2) <= Lambda_psi;

end
