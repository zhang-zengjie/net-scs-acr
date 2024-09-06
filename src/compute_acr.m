%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Zengjie Zhang
% Date: 2022.08.21

function E = compute_acr(Ts, T, P)
%
% COMPUTE_ACR computes the ACR using the proposed numerical method
% 
% Inputs:
% Ts: the length of a trial
% T: the maximum triggering interval
% P: the P coefficients
%
% Output:
% E(1:Ts): the computed ACR

E_0 = 1;
E = zeros(1, Ts);


for k = 1:Ts
    E(k) = 1;
    if k>T
        for n = 1:T
            E(k) = E(k) - E(k-n)*P(n);
        end
    else
        for n = 1:k-1
            E(k) = E(k) - E(k-n)*P(n);
        end
        E(k) = E(k) - E_0*P(k);

    end
    fprintf("Computing E(%d) out of total steps %d\n", k, Ts);
end

end


