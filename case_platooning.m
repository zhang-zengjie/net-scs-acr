%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script used to generate the results for the numerical example
% Author: Zengjie Zhang, Qingchen Liu,
% Date: 2022.08.21

clc;
clear;

sim_t = 50;                         % Simulation time
Delta_t = 0.1;                      % Discrete-time sampling period
Ts = round(sim_t/Delta_t);                           

A = 1;
B = Delta_t;
sigma_w = 1;    %standard 
sigma_hat = 0.1;
eta = 0.05;
N_trials = 1e4;
N_ptc = 1e4;
x_0 = -2*ones(N_trials, 1);         % Initial state known
rng(0);
% P_L = 2*sin(k_scale*Delta_t);         % Trajectory of the leader
T = 20;


% Calculate ACR using the proposed method
fprintf("Computing ACR numerically using the proposed method\n");
pdf_hat_e_n_cell = approx_pdf(A, sigma_w, T, eta, N_ptc, sigma_hat, 0);
P_bar_n = compute_p_bar(pdf_hat_e_n_cell(1:T-1), eta);
P = compute_p(P_bar_n);
ACR_n = compute_acr(Ts, T, P);
st_ACR = 1/(1+sum(P));

% Calculate ACR using the conventional method
fprintf("Computing ACR numerically using the conventional method\n");
pdf_e_n_cell = approx_pdf(A, sigma_w, T, eta, N_ptc, sigma_hat, 0);
P_bar_n_conv = compute_p_bar(pdf_e_n_cell(1:T-1), eta);
P_conv = compute_p(P_bar_n_conv);
ACR_n_conv = compute_acr(Ts, T, P_conv);
st_ACR_conv = 1/(1+sum(P_conv));


% Get the ACR ground truth (GT) using Monte-Carlo simulation
ctr = @(x, k) -10*(x-2*sin(k*0.1));
[ACR_GT, err] = monte_carlo_acr(N_trials, Ts, A, B, sigma_w, x_0, ctr, eta, T);

k_scale = 0:1:400;
hold on;
plot(k_scale, [1, ACR_GT(k_scale(2:end))], '-o', 'MarkerSize', 3, 'linewidth', 1.5, 'Color', [0.2, 0.2, 1]);
plot(k_scale, [1, ACR_n(k_scale(2:end))'], '-o', 'MarkerSize', 3, 'linewidth', 1.5, 'Color', [0.2, 0.2, 0.1]);
hold off;