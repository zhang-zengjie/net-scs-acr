%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script used to generate the results for the numerical example
% Author: Zengjie Zhang, Qingchen Liu,
% Date: 2022.08.21

clc;
clear;

sim_t = 5;                          % Simulation time
Delta_t = 1;                        % Discrete-time sampling period
Ts = round(sim_t/Delta_t);                          

A = 1.25;
B = Delta_t;
sigma_w = 1;    %standard 
sigma_hat = 0.1;
eta = 1;
N_trials = 1e4;
N_ptc = 1e4;
x_0 = -2*ones(N_trials, 1);         % Initial state known
rng(0);
T = 5;

%% The analytical form of PDFs
sigma1 = sigma_w;
sigma2 = sigma_w;
sigma3 = sigma_w;
sigma4 = sigma_w;
sigma5 = sigma_w;

% Calculate ACR using the proposed method
fprintf("Computing ACR numerically using the proposed method\n");
pdf_hat_e_n_cell = approx_pdf(A, sigma_w, T, eta, N_ptc, sigma_hat, 0);
P_bar_n = compute_p_bar(pdf_hat_e_n_cell(1:T-1), eta);
ACR_n = compute_acr(Ts, T, compute_p(P_bar_n));

pdf_hat_e_a_cell = {
    @(x) exp(-(x.^2/(2*(sigma1^2))))./sqrt(2*pi*(sigma1^2)), 
    @(x) 0.5*(erf((eta-sigma1^2*A*x/(A^2*sigma1^2+sigma2^2))/(sqrt(2)*sigma1*sigma2/sqrt(A^2*sigma1^2+sigma2^2)))+erf((eta+sigma1^2*A*x/(A^2*sigma1^2+sigma2^2))/(sqrt(2)*sigma1*sigma2/sqrt(A^2*sigma1^2+sigma2^2))))./(sqrt(2*pi*(A^2*sigma1^2+sigma2^2))*erf(eta/(sqrt(2)*sigma1))).*exp(-(x.^2/(2*(A^2*sigma1^2+sigma2^2))));    
};
P_bar_a = compute_p_bar(pdf_hat_e_a_cell, eta);
fprintf("Computing ACR analytically using the proposed method\n");
ACR_a = compute_acr(max(size(P_bar_a)), T, compute_p(P_bar_a));



% Calculate ACR using the conventional method
pdf_e_n_cell = approx_pdf(A, sigma_w, T, eta, N_ptc, sigma_hat, 1);
P_bar_n_conv = compute_p_bar(pdf_e_n_cell(1:T-1), eta);
fprintf("Computing ACR numerically using the conventional method\n");
ACR_n_conv = compute_acr(Ts, T, compute_p(P_bar_n_conv));

pdf_e_a_cell = {
    @(x) exp(-(x.^2/(2*(sigma1^2))))./sqrt(2*pi*(sigma1^2)), 
    @(x) exp(-(x.^2/(2*(A^2*sigma1^2+sigma2^2))))./sqrt(2*pi*(A^2*sigma1^2+sigma2^2)), 
    @(x) exp(-(x.^2/(2*(A^4*sigma1^1 + A^2*sigma2^2 + sigma3^2))))./sqrt(2*pi*(A^4*sigma1^1 + A^2*sigma2^2 + sigma3^2)),
    @(x) exp(-(x.^2/(2*(A^6*sigma1^1 + A^4*sigma2^2 + A^2*sigma3^2 + sigma4))))./sqrt(2*pi*(A^6*sigma1^1 + A^4*sigma2^2 + A^2*sigma3^2 + sigma4)),
    @(x) exp(-(x.^2/(2*(A^8*sigma1^2 + A^6*sigma2^2 + A^4*sigma3^2 + A^2*sigma4^2 + sigma5^2))))./sqrt(2*pi*(A^8*sigma1^2 + A^6*sigma2^2 + A^4*sigma3^2 + A^2*sigma4^2 + sigma5^2))
};
P_bar_a_conv = compute_p_bar(pdf_e_a_cell(1:end-1), eta);
fprintf("Computing ACR analytically using the conventional method\n");
ACR_a_conv = compute_acr(Ts, T, compute_p(P_bar_a_conv));

% Get the ACR ground truth (GT) using Monte-Carlo simulation
ctr = @(x, y, k) -x;
[ACR_GT, err, ~, ~] = monte_carlo_acr(N_trials, Ts, A, B, sigma_w, x_0, 0, ctr, eta, T);

