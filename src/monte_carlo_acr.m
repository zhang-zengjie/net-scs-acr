function [ACR, err, E_x, E_p] = monte_carlo_acr(n_trials, Ts, A, B, sigma_w, x_0, p_0, ctr, eta, T)
%
% MONTE_CARLO_ACR uses the Monte Carlo method to approximate the ACR ground
% truth
% 
% Inputs:
% n_trials: the number of Monte Carlo samping trials
% Ts: the length of each trial
% A, B: the system parameters
% sigma_w: the standard deviation of the system noise
% x_0: the initial state of the system
% ctr(x, k): the state- and time-dependent controller
% eta: the triggering threshold
% T: the maximum triggering interval
%
% Output:
% ACR(1, Ts): the simulated ACR ground truth

fprintf("Performing Monte-Carlo simulation...\n");

w = sigma_w*randn(n_trials, Ts+1);
u_0 = ctr(x_0, p_0, 0);

p = zeros(n_trials, Ts+1);
x = zeros(n_trials, Ts+1);
x_hat = zeros(n_trials, Ts+1);
u = zeros(n_trials, Ts);
iota = zeros(n_trials, Ts);
delta = zeros(n_trials, Ts);

% Propagation step 1
p(:, 1) = A*p_0 + B*x_0;
x(:, 1) = A*x_0 + B*u_0 + w(:, 1);
x_hat(:, 1) = A*x_0 + B*u_0;
err = x(:, 1:end-1) - x_hat(:, 1:end-1);
u(:, 1) = ctr(x_hat(:, 1), p(:, 1), 1);
p(:, 2) = A*p(:, 1) + B*x_hat(:, 1);
x(:, 2) = A*x(:, 1) + B*u(:, 1) + w(:, 2);
fprintf("Simulating E(1) out of total steps %d\n", Ts);

% Propagation steps 2 to Ts
for k=2:Ts
    
    for i = 1:n_trials
        if (abs(err(i, k-1)) >= eta) || ((k-iota(i, k-1)) > T)      % Triggering Condition
            delta(i, k) = 1;
            iota(i, k) = k;
            x_hat(i, k) = x(i, k);                                  % Refresh the state
        else
            delta(i, k) = 0;
            iota(i, k) = iota(i, k-1);
            x_hat(i, k) = A*x_hat(i,k-1) + B*u(i, k-1);             % Perform state estimation
        end
    end

    err(:, k) = x(:, k) - x_hat(:, k);
    u(:, k) = ctr(x_hat(:, k), p(:, k), k);                                   % Control input
    x(:, k+1) = A*x(:, k) + B*u(:, k) + w(:, k+1);                  % System state transition
    p(:, k+1) = A*p(:, k) + B*x_hat(:, k);
    fprintf("Simulating E(%d) out of total steps %d\n", k, Ts);
end

ACR = mean(delta, 1);                                               % Approximate the ACR
E_x = mean(x, 1);
E_p = mean(p, 1);

end

