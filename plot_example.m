%% PDFs of hat_e and e
k = 2;

x_plot = -5:0.001:4.99;

pdf_e = pdf_e_a_cell{k};
if (k==2)
    pdf_hat_e = pdf_hat_e_a_cell{2};
else
    pdf_hat_e = pdf_hat_e_n_cell{k};
end

E_hat_e = integral(@(x) pdf_hat_e(x).*x, -10, 10);
E_e = integral(@(x) pdf_e(x).*x, -10, 10);
Var_hat_e = integral(@(x) pdf_hat_e(x).*(x-E_hat_e).*(x-E_hat_e), -10, 10);
Var_e = integral(@(x) pdf_e(x).*(x-E_e).*(x-E_e), -10, 10);

fprintf(strcat("The expectation values: E_hat_e_", num2str(k), " = %f, E_e_", num2str(k), " = %f\n"), E_hat_e, E_e);
fprintf(strcat("The variances: Var_hat_e_", num2str(k), " = %f, Var_e_", num2str(k), " = %f\n"), Var_hat_e, Var_e);

set(gca,'GridLineStyle','-.')
z = err(:, k);
hold on
h1 = histogram(z(z~=0), 100, 'Normalization', 'pdf',  'FaceColor', [128, 128, 128]/255, 'EdgeColor', 'none', 'LineWidth', 1.5);
plot(x_plot,pdf_hat_e(x_plot), 'color', 'red', 'LineWidth', 1.5);
plot(x_plot,pdf_e(x_plot), 'color', 'blue', 'LineWidth', 1.5);
grid on
hold off
leg = legend('GT', strcat('$p_{\hat{e}_', num2str(k), '}(\cdot)$'), strcat('$p_{e_', num2str(k), '}(\cdot)$'), 'interpreter', 'latex');
leg.ItemTokenSize = [10,20];
xlabel('$x_k - \hat{x}_k$', 'interpreter', 'latex');
ylabel('PDF');

set(gcf,'position',[400, 300, 220, 160]);       % [pos_x, pos_y, width, height]
