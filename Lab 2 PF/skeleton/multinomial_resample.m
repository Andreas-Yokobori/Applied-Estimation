% function S = multinomial_resample(S_bar)
% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = multinomial_resample(S_bar)
% FILL IN HERE

M = size(S_bar,2);
cdf = cumsum(S_bar(4,:));
S = zeros(4,M);

for m = 1:M
    r = rand;
    i = find(cdf >= r, 1, 'first');
    S(:,m) = S_bar(:,i);
end

S(4,:) = 1/M * ones(1,M);
end