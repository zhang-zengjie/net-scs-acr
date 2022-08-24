%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script used to generate the results for the numerical example
% Author: Zengjie Zhang, Qingchen Liu,
% Date: 2022.08.21

clear;
clc;

load('data/data_platooning.mat');

j = find(eta==1);

t_scale = 0:Delta_t:sim_t;
SZ = max(size(t_scale));

figure();
hold on;
plot(t_scale, P_L_dot(t_scale/Delta_t), 'LineStyle',':', 'Color', [255, 26, 26]/255, 'linewidth', 2.5);
plot(t_scale, E_x(j, 1:SZ), 'LineStyle',':', 'Color', [0, 45, 179]/255, 'linewidth', 2.5);
leg = legend('$\dot{p}^L(t)$', '$E(v(t))$', 'Interpreter', 'latex', 'FontSize', 9, 'Orientation', 'horizontal');
leg.ItemTokenSize = [10,20];
set(gca,'GridLineStyle','-.')
grid on;
hold off;
xlim([0, 40]);
xlabel('time');
ylabel('velocity');
set(gcf,'position',[400, 300, 220, 160]);       % [pos_x, pos_y, width, height]

figure();
plot(t_scale, E_p(j, 1:SZ)-P_L(t_scale/Delta_t), 'Color', [77, 77, 77]/255, 'linewidth',2);
leg = legend('$E(p(t))-p^L(t)$', 'Interpreter', 'latex', 'FontSize', 9);
leg.ItemTokenSize = [10,20];
set(gca,'GridLineStyle','-.')
grid on;
xlim([0, 40]);
xlabel('time');
ylabel('distance');
set(gcf,'position',[400, 300, 220, 160]);       % [pos_x, pos_y, width, height]]);


figure();
plot_eta(t_scale, Delta_t, ACR_GT, ACR_n, ACR_n_conv, find(eta==1));

figure();
plot_eta(t_scale, Delta_t, ACR_GT, ACR_n, ACR_n_conv, find(eta==2));

figure();
plot_eta(t_scale, Delta_t, ACR_GT, ACR_n, ACR_n_conv, find(eta==3));

figure();
plot_eta(t_scale, Delta_t, ACR_GT, ACR_n, ACR_n_conv, find(eta==4));


figure();

hold on;
plot(eta, st_ACR, '-o', 'MarkerSize', 2.5, 'linewidth', 1.2, 'Color', [0.9, 0.1, 0.1]);
plot(eta, st_ACR_conv, '-o', 'MarkerSize', 2.5, 'linewidth', 1.2, 'Color', [51, 102, 255]/255);
leg = legend('$E(\delta_{\infty})$','$\breve{E}(\delta_{\infty})$', 'Interpreter', 'latex', 'FontSize', 9);
leg.ItemTokenSize = [10,20];
hold off;
set(gca,'GridLineStyle','-.')
grid on;
xlim([1 5]);
xlabel('$\eta$', 'Interpreter', 'latex');
ylabel('stationary ACR');
set(gcf,'position',[400, 300, 220, 160]);       % [pos_x, pos_y, width, height]]);


figure();

plot(eta, st_ACR./st_ACR_conv, '-o', 'MarkerSize', 2.5, 'linewidth', 1.2, 'Color', [0.2, 0.2, 0.2]);
leg = legend('$\displaystyle \frac{E(\delta_{\infty})}{\breve{E}(\delta_{\infty})}$', 'Interpreter', 'latex', 'FontSize', 9);
leg.ItemTokenSize = [10,20];
set(gca,'GridLineStyle','-.')
grid on;
xlim([1 5]);
xlabel('$\eta$', 'Interpreter', 'latex');
ylabel('ACR ratio');
set(gcf,'position',[400, 300, 220, 160]);       % [pos_x, pos_y, width, height]]);


function plot_eta(t_scale, Delta_t, ACR_GT, ACR_n, ACR_n_conv, j)
    
    k_scale = round(t_scale/Delta_t);
%    SZ = max(size(k_scale));

    hold on;
    plot(t_scale, [ACR_n_conv(j, 1), ACR_n_conv(j, k_scale(2:end))], '-o', 'MarkerSize', 1.8, 'linewidth', 1.2, 'Color', [51, 102, 255]/255);
    plot(t_scale, [ACR_GT(j, 1), ACR_GT(j, k_scale(2:end))], '-o', 'MarkerSize', 3, 'linewidth', 2.5, 'Color', [0.2, 0.2, 0.2]);
    plot(t_scale, [ACR_n(j, 1), ACR_n(j, k_scale(2:end))], '-o', 'MarkerSize', 1.8, 'linewidth', 1.2, 'Color', [0.9, 0.1, 0.1]);
%     plot(t_scale, st_ACR(j)*ones(1,SZ), 'LineStyle','-', 'Color', [255, 214, 51]/255, 'linewidth',1.2);
%     plot(t_scale, st_ACR_conv(j)*ones(1,SZ), 'linewidth', 1.2, 'Color', [51, 102, 255]/255); 
    hold off;
    xlim([0 40]);
    ylim([0 0.45]);
    leg = legend('$\breve{E}(\delta_k)$', 'GT-ACR', '$E(\delta_k)$', 'Interpreter', 'latex', 'FontSize', 9);
    leg.ItemTokenSize = [10,20];
    set(gca,'GridLineStyle','-.')
    grid on;
    xlabel('time');
    ylabel('ACR');
    set(gcf,'position',[400, 300, 220, 160]);       % [pos_x, pos_y, width, height]]);

end