%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Zengjie Zhang
% Date: 2022.08.21

function p = compute_p(p_bar)
%
% COMPUTE_P calculates the P coefficients 
% 
% Input: 
% p_bar: the recursive coefficients p_bar
%
% Output:
% p: the coefficients P

    p = zeros(size(p_bar));
    p(1) = p_bar(1);
    for i = 1:max(size(p_bar))-1
        p(i+1) = p(i)*p_bar(i+1);
    end

end

