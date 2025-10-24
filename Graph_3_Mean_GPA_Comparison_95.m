% Graph 3: Mean GPA Comparison with 95% Confidence Intervals (OCTAVE FIXED)
clear; clc;

% Data from your analysis
methods = {'Digital', 'Paper'};
means = [3.426, 3.218];
ci_lower = [3.229, 2.929];
ci_upper = [3.623, 3.507];

% Calculate error bar values (distance from mean to CI bounds)
error_lower = means - ci_lower;
error_upper = ci_upper - means;

% Create figure
figure(3);
clf;

% Create bar chart first
h = bar(means);
set(h, 'FaceColor', [0.2, 0.4, 0.6]);
hold on;

% Manual error bars (since errorbar is problematic in Octave)
for i = 1:length(means)
    % Draw error bar lines manually
    x_pos = i;
    y_mean = means(i);
    y_lower = ci_lower(i);
    y_upper = ci_upper(i);

    % Vertical line for error bar
    plot([x_pos, x_pos], [y_lower, y_upper], 'k-', 'LineWidth', 2);

    % Top cap
    plot([x_pos-0.05, x_pos+0.05], [y_upper, y_upper], 'k-', 'LineWidth', 2);

    % Bottom cap
    plot([x_pos-0.05, x_pos+0.05], [y_lower, y_lower], 'k-', 'LineWidth', 2);
end

% Set up axes and labels AFTER plotting
set(gca, 'XTick', [1, 2]);
set(gca, 'XTickLabel', methods);

% Add all text elements
title('Mean GPA Comparison with 95% Confidence Intervals');
xlabel('Note-Taking Method');
ylabel('Mean GPA');

% Add mean value labels on bars
text(1, means(1) + 0.05, sprintf('%.3f', means(1)), ...
     'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 11);
text(2, means(2) + 0.05, sprintf('%.3f', means(2)), ...
     'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 11);

% Add sample size labels
text(1, means(1) - 0.1, '(n=21)', 'HorizontalAlignment', 'center', 'FontSize', 10);
text(2, means(2) - 0.1, '(n=14)', 'HorizontalAlignment', 'center', 'FontSize', 10);

% Add CI range labels
text(1, ci_lower(1) - 0.05, sprintf('[%.3f, %.3f]', ci_lower(1), ci_upper(1)), ...
     'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'red');
text(2, ci_lower(2) - 0.05, sprintf('[%.3f, %.3f]', ci_lower(2), ci_upper(2)), ...
     'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'red');

% Set axis properties
ylim([2.5, 4.0]);
set(gca, 'FontSize', 12);
grid on;

% Add legend
legend({'Mean GPA', '95% Confidence Interval'}, 'Location', 'northeast', 'FontSize', 11);

% Final formatting
set(gcf, 'Position', [100, 100, 800, 600]);
set(gcf, 'Color', 'white');

hold off;
drawnow;

% Save the figure
print('mean_comparison_ci.png', '-dpng', '-r300');
fprintf('Graph 3 saved as mean_comparison_ci.png\n');
