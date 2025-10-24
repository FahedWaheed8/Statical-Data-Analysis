% Graph 5: Hypothesis Test Results Visualization
clear; clc;

% Load statistics package (required for tpdf function)
try
    pkg load statistics;
    fprintf('Statistics package loaded successfully.\n');
catch
    fprintf('Warning: Statistics package not available. Using approximation.\n');
end

% Data from your t-test results
t_statistic = 1.311;
t_critical = 1.692;
p_value = 0.099;
alpha = 0.05;

% Create t-distribution curve
df = 33;
x = linspace(-3, 3, 1000);

% Try to use tpdf, fallback to normal approximation if not available
try
    y = tpdf(x, df);
catch
    % Fallback: approximate t-distribution with normal for large df
    fprintf('Using normal approximation for t-distribution.\n');
    y = normpdf(x, 0, 1);
end

figure(5);
clf;
plot(x, y, 'b-', 'LineWidth', 2);
hold on;

% Shade critical region (one-tailed)
x_crit = linspace(t_critical, 3, 100);

% Calculate y values for critical region
try
    y_crit = tpdf(x_crit, df);
    y_stat = tpdf(t_statistic, df);
    y_critical = tpdf(t_critical, df);
catch
    y_crit = normpdf(x_crit, 0, 1);
    y_stat = normpdf(t_statistic, 0, 1);
    y_critical = normpdf(t_critical, 0, 1);
end

% Use patch instead of fill for better Octave compatibility
% Make sure the critical region is properly closed
x_fill = [x_crit, 3, t_critical];
y_fill = [y_crit, 0, 0];
patch(x_fill, y_fill, 'red', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Add vertical lines (using plot instead of line) - make them thinner
plot([t_statistic, t_statistic], [0, y_stat], ...
     'g--', 'LineWidth', 2);
plot([t_critical, t_critical], [0, y_critical], ...
     'r-', 'LineWidth', 2);

% Labels and annotations
xlabel('t-value', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Probability Density', 'FontSize', 12, 'FontWeight', 'bold');
title('t-Test Results: Digital vs Paper Note-Taking (One-Tailed Test)', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

% Add text annotations
text(t_statistic, y_stat + 0.02, ...
     sprintf('t = %.3f', t_statistic), 'HorizontalAlignment', 'center', ...
     'Color', 'green', 'FontWeight', 'bold', 'FontSize', 10);
text(t_critical, y_critical + 0.02, ...
     sprintf('t_c_r_i_t = %.3f', t_critical), 'HorizontalAlignment', 'center', ...
     'Color', 'red', 'FontWeight', 'bold', 'FontSize', 10);

% Add results text box (moved to left side to avoid legend overlap)
text_x = -2.8;
text_y = 0.32;
text_spacing = 0.025;

% Create a background box first
rectangle('Position', [text_x-0.1, text_y-4.5*text_spacing-0.01, 1.4, 5*text_spacing+0.02], ...
          'FaceColor', 'white', 'EdgeColor', 'black', 'LineWidth', 1);

% Individual text lines for better control
text(text_x, text_y, sprintf('t-statistic: %.3f', t_statistic), ...
     'FontSize', 9, 'FontWeight', 'bold');
text(text_x, text_y - text_spacing, sprintf('p-value: %.3f', p_value), ...
     'FontSize', 9, 'FontWeight', 'bold');
text(text_x, text_y - 2*text_spacing, sprintf('alpha = %.2f', alpha), ...
     'FontSize', 9, 'FontWeight', 'bold');
text(text_x, text_y - 3*text_spacing, 'Decision: Fail to reject H0', ...
     'FontSize', 9, 'FontWeight', 'bold');
text(text_x, text_y - 4*text_spacing, 'Not statistically significant', ...
     'FontSize', 9, 'FontWeight', 'bold');

% Create legend with simpler approach (make it more compact)
h1 = plot(NaN, NaN, 'b-', 'LineWidth', 2);
h2 = patch(NaN, NaN, 'red', 'FaceAlpha', 0.3);
h3 = plot(NaN, NaN, 'g--', 'LineWidth', 2);
h4 = plot(NaN, NaN, 'r-', 'LineWidth', 2);

legend([h1, h2, h3, h4], {'t-distribution (df=33)', 'Critical Region', 'Test Statistic', 'Critical Value'}, ...
       'Location', 'northeast', 'FontSize', 9);

% Set axis limits and formatting
xlim([-3 3]);
ylim([0 0.4]);
set(gca, 'FontSize', 12);

% Final formatting
set(gcf, 'Position', [100, 100, 900, 600]);
set(gcf, 'Color', 'white');

hold off;

% Save the figure
print('hypothesis_test_results.png', '-dpng', '-r300');
fprintf('Graph 5 saved as hypothesis_test_results.png\n');
