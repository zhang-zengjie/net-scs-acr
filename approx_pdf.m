%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Zengjie Zhang
% Date: 2022.08.21

function pdf_hat_e = approx_pdf(A, sigma_w, T, eta, N, sigma_hat, is_conv)
%
% COMPUTE_P_BAR approximate the PDF of the state estimation errors e_hat_k 
% and computes the recursive coefficients P_bar
%
% Inputs:
% A = 1:                % System parameter
% sigma_w = 1:          % The standard deviation of the system noise
% T = 5:                % The maximum triggering interval
% eta = 1:              % Triggering threshold
% N = 1e4:              % The number of particles
% sigma_hat = 0.001:    % The standard deviation of the Gaussian Kernel Approximator
% is_conv = 0:          % Whether p_bar is for the conventional method
%                       % 0: Use the proposed method
%                       % 1: Use the conventional method

    if is_conv == 0
        fprintf("Using the proposed method.\n");
    else
        fprintf("Using the conventional method.\n");
    end
    fprintf("Computing recursive coefficients...\n");
    
    z = zeros(N, T);
    z(:, 1) = sigma_w*randn(N, 1);
    pdf_hat_e = cell(1, T);                                                                        % Sample particles z_1
    pdf_hat_e{1} = @(x) sum((1/sqrt(2*pi))*exp(-((x - z(:, 1))/sigma_hat).^2/2), 1)/(N*sigma_hat);      % Approximate pdf_hat_e_1
    fprintf("PDF hat_e_1 out of %d generated\n", T);
    
    for i = 1:T-1
    
        if is_conv == 0
            z_tr = z((z(:, i)>-eta & z(:, i)<eta), i);                                                            % Select particles accroding to the thresholds   
            pdf_hat_e_tr = @(x) sum((1/sqrt(2*pi))*exp(-((x-z_tr)/sigma_hat).^2/2),1)/(max(size(z_tr))*sigma_hat);  % Approximate the truncated pdf
            z_rs = sampling_from_pdf([-5, 5], pdf_hat_e_tr, N, N);                                                                       % Resample particles z_1 from pdf_hat_e_1_tr
        else
            z_rs = z(:, i);
        end
        z(:, i+1) = A*z_rs + sigma_w*randn(N, 1);                                                                 % Propagate the new particles z_{i+1}
        pdf_hat_e{i+1} = @(x) sum((1/sqrt(2*pi))*exp(-((x - z(:, i+1))/sigma_hat).^2/2), 1)/(N*sigma_hat);      % Approximate pdf_hat_e_{i+1}
        fprintf("PDF hat_e_%d out of %d generated\n", i+1, T);
    end

end

function z_out = sampling_from_pdf(sz_x, pdf, N_spl, N_batch)

% Input: 
% sz_x = [xmin, xmax]: the interval of resampling
% xmin: Lower limit of the PDF support (finite support interval for computation)
% xmax: Upper limit of the PDF support (finite support interval for computation)
% pdf: the pdf to sample
% N_spl: the number of the output samples
% N_batch: the batch size of each resampling
% Output:
% z_out: the samples

    new_samples = [];
    while max(size(new_samples)) < N_spl
        rs_1_x = (sz_x(2)-sz_x(1))*rand(1, N_batch) + sz_x(1);             % The x-axis samples of pdf 1
        rs_1_y = pdf(rs_1_x);                      % The y-axis samples of pdf 1
        ymax = max(rs_1_y);
        ymin = 0;
        Y = (ymax-ymin)*rand(1, N_batch)-ymin;
        new_samples = cat(2, new_samples, rs_1_x(Y<=rs_1_y));
    end
    z_out = reshape(randsample(new_samples, N_spl), [N_spl, 1]);     % Ensure the number of samples is N
end



