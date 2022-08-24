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
%eta = 0.1:0.1:5;
eta = 1;
N_trials = 1e4;
N_ptc = 1e4;
x_0 = zeros(N_trials, 1);         % Initial state known
rng(0);
P_L = @(k) -cos(k*Delta_t)+1.2*k*Delta_t;
P_L_dot = @(k) sin(k*Delta_t)+1.2;         % Trajectory of the leader
P_L_ddot = @(k) cos(k*Delta_t);
T = 20;
p_0 = 0;
SZ = max(size(eta));

gamma = 1;
Q_inv = 1;
P = 1;
d = 3;
% ctr = @(x, k) -10*(x-P_L_dot(k));
ctr = @(x, y, k) - gamma*Q_inv*x - Q_inv*P*y + gamma*Q_inv*P_L_dot(k) + Q_inv*P*P_L(k) + P_L_ddot(k) + Q_inv*P*d;


P_bar_n = zeros(SZ, T);
P_bar_n_conv = zeros(SZ, T);
st_ACR = zeros(SZ, 1);
st_ACR_conv = zeros(SZ, 1);

ACR_n = zeros(SZ, Ts);
ACR_n_conv = zeros(SZ, Ts);
ACR_GT = zeros(SZ, Ts);

E_x = zeros(SZ, Ts+1);
E_p = zeros(SZ, Ts+1);

for i = 1:SZ

    fprintf("Generating results for eta=%f\n", eta(i));

    % Calculate ACR using the proposed method
    fprintf("Computing ACR numerically using the proposed method\n");
    pdf_hat_e_n_cell = approx_pdf(A, sigma_w, T, eta(i), N_ptc, sigma_hat, 0);
    P_bar_n(i, :) = compute_p_bar(pdf_hat_e_n_cell(1:T-1), eta(i));
    P_n = compute_p(P_bar_n(i, :));
    ACR_n(i, :) = compute_acr(Ts, T, P_n);
    st_ACR(i) = 1/(1+sum(P_n));
    
    % Calculate ACR using the conventional method
    fprintf("Computing ACR numerically using the conventional method\n");
    pdf_e_n_cell = approx_pdf(A, sigma_w, T, eta(i), N_ptc, sigma_hat, 1);
    P_bar_n_conv(i, :) = compute_p_bar(pdf_e_n_cell(1:T-1), eta(i));
    P_n_conv = compute_p(P_bar_n_conv(i, :));
    ACR_n_conv(i, :) = compute_acr(Ts, T, P_n_conv);
    st_ACR_conv(i) = 1/(1+sum(P_n_conv));

    % Get the ACR ground truth (GT) using Monte-Carlo simulation
    [ACR_GT(i, :), ~, E_x(i, :), E_p(i, :)] = monte_carlo_acr(N_trials, Ts, A, B, sigma_w, x_0, p_0, ctr, eta(i), T);
end
