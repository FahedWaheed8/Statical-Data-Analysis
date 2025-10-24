% Graph 2: GPA Distribution by Note-Taking Method (OCTAVE COMPATIBLE)
clear; clc;

% GPA distribution data from your analysis
gpa_ranges = {'2.50', '3.00', '3.50', '3.85'};
digital_counts = [2, 4, 8, 7];
paper_counts = [3, 4, 4, 3];

% Create grouped bar chart
figure(2);
clf; % Clear the figure to avoid overlapping plots
data = [digital_counts; paper_counts]';
h = bar(data, 'grouped');

% Customize colors (Octave compatible method)
colormap([0.12, 0.31, 0.49; 0.83, 0.33, 0.00]); % Dark blue and orange

% Set up the axes
ax = gca;
set(ax, 'XTick', 1:length(gpa_ranges));
set(ax, 'XTickLabel', gpa_ranges);

% Labels and formatting
xlabel('GPA Values', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Number of Students', 'FontSize', 12, 'FontWeight', 'bold');
title('GPA Distribution: Digital vs Paper Note-Taking', 'FontSize', 14, 'FontWeight', 'bold');

% Set y-axis limits and ticks
max_count = max([digital_counts, paper_counts]);
ylim([0, max_count + 1]);
set(ax, 'YTick', 0:1:max_count + 1);

% Add legend
legend({'Digital (n=21)', 'Paper (n=14)'}, 'Location', 'northwest', 'FontSize', 11);

% Add grid
grid on;
set(ax, 'GridAlpha', 0.3);

% Set font size for all elements
set(ax, 'FontSize', 12);

% Add value labels on bars
bar_width = 0.8; % Default bar width
group_width = bar_width / 2; % Width for each bar in group
positions = 1:length(gpa_ranges);

for i = 1:length(gpa_ranges)
    % Digital bars (left side of each group)
    x_pos_digital = positions(i) - group_width/2;
    text(x_pos_digital, digital_counts(i) + 0.15, num2str(digital_counts(i)), ...
         'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10);

    % Paper bars (right side of each group)
    x_pos_paper = positions(i) + group_width/2;
    text(x_pos_paper, paper_counts(i) + 0.15, num2str(paper_counts(i)), ...
         'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10);
end

% Ensure all elements are visible
set(gcf, 'Position', [100, 100, 800, 600]); % Set figure size
set(gcf, 'Color', 'white'); % White background

% Force the plot to refresh
drawnow;

% Save the figure
print('gpa_distribution.png', '-dpng', '-r300');
fprintf('Graph 2 saved as gpa_distribution.png\n');
