%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Zengjie Zhang
% Date: 2022.08.21

function P_bar = compute_p_bar(pdf_hat_e, eta)
%
% COMPUTE_P_BAR approximate the PDF of the state estimation errors e_hat_k 
% and computes the recursive coefficients P_bar
%
% Inputs:
    max_iter = max(size(pdf_hat_e));
    P_bar = [1; zeros(max_iter, 1)];
    for i = 1:max_iter
        P_bar(i+1) = integral(pdf_hat_e{i},-eta,eta);                                                         % Calculate the recursive coefficient overline{P}_{i+2}
    end

end

