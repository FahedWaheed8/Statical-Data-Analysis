% Graph 4: Box Plot Comparison (OCTAVE COMPATIBLE)
clear; clc;

% Raw data from your dataset
digital_gpa = [3.85, 3.85, 3.85, 3.85, 3.85, 3.85, 3.85, ...
               3.50, 3.50, 3.50, 3.50, 3.50, 3.50, 3.50, 3.50, ...
               3.00, 3.00, 3.00, 3.00, ...
               2.50, 2.50];

paper_gpa = [3.85, 3.85, 3.85, ...
             3.50, 3.50, 3.50, 3.50, ...
             3.00, 3.00, 3.00, 3.00, ...
             2.50, 2.50, 2.50];

% Create figure
figure(4);
clf;

% Try standard boxplot if available
try
    % Combine data for boxplot
    data = [digital_gpa, paper_gpa];
    groups = [ones(1,length(digital_gpa)), 2*ones(1,length(paper_gpa))];
    boxplot(data, groups);
    set(gca, 'XTickLabel', {'Digital', 'Paper'});

catch
    % Manual box plot implementation
    fprintf('Creating manual box plots...\n');

    % Debug: Print statistics for both groups
    fprintf('Digital GPA stats:\n');
    fprintf('  Q1: %.2f, Median: %.2f, Q3: %.2f\n', prctile(digital_gpa, 25), median(digital_gpa), prctile(digital_gpa, 75));
    fprintf('Paper GPA stats:\n');
    fprintf('  Q1: %.2f, Median: %.2f, Q3: %.2f\n', prctile(paper_gpa, 25), median(paper_gpa), prctile(paper_gpa, 75));

    positions = [1, 2];
    datasets = {digital_gpa, paper_gpa};
    colors = {[0.3, 0.6, 0.9], [0.9, 0.6, 0.3]};

    % Initialize the plot
    hold on;

    for i = 1:2
        data_set = datasets{i};
        pos = positions(i);

        % Calculate quartiles
        q1 = prctile(data_set, 25);
        q2 = median(data_set);  % median
        q3 = prctile(data_set, 75);
        iqr = q3 - q1;

        % Calculate whiskers
        lower_whisker = max(min(data_set), q1 - 1.5*iqr);
        upper_whisker = min(max(data_set), q3 + 1.5*iqr);

        % Draw box (ensure minimum height for visibility)
        box_width = 0.3;
        box_height = max(q3-q1, 0.05); % Minimum height of 0.05

        % Create rectangle for the box
        x_coords = [pos-box_width/2, pos+box_width/2, pos+box_width/2, pos-box_width/2, pos-box_width/2];
        y_coords = [q1, q1, q3, q3, q1];

        % Fill the box
        fill(x_coords, y_coords, colors{i}, 'EdgeColor', 'black', 'LineWidth', 1.5);

        % Draw median line
        plot([pos-box_width/2, pos+box_width/2], [q2, q2], 'k-', 'LineWidth', 2);

        % Draw whiskers
        plot([pos, pos], [q3, upper_whisker], 'k-', 'LineWidth', 1.5);
        plot([pos, pos], [q1, lower_whisker], 'k-', 'LineWidth', 1.5);

        % Draw whisker caps
        cap_width = box_width * 0.5;
        plot([pos-cap_width/2, pos+cap_width/2], [upper_whisker, upper_whisker], 'k-', 'LineWidth', 1.5);
        plot([pos-cap_width/2, pos+cap_width/2], [lower_whisker, lower_whisker], 'k-', 'LineWidth', 1.5);

        % Find and plot outliers
        outliers = data_set(data_set < lower_whisker | data_set > upper_whisker);
        if ~isempty(outliers)
            for j = 1:length(outliers)
                plot(pos, outliers(j), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'red');
            end
        end
    end

    % Set axis properties for manual plot
    set(gca, 'XTick', [1, 2]);
    set(gca, 'XTickLabel', {'Digital', 'Paper'});
    xlim([0.5, 2.5]);
end

% Labels and formatting
xlabel('Note-Taking Method', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('GPA', 'FontSize', 12, 'FontWeight', 'bold');
title('GPA Distribution Box Plot: Digital vs Paper Note-Taking', 'FontSize', 14, 'FontWeight', 'bold');

% Add grid
grid on;
set(gca, 'GridAlpha', 0.3);

% Add sample size labels
text(1, 2.3, '(n=21)', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');
text(2, 2.3, '(n=14)', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');

% Add median value labels
median_digital = median(digital_gpa);
median_paper = median(paper_gpa);
text(1, median_digital + 0.05, sprintf('Median: %.2f', median_digital), ...
     'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'red', 'FontWeight', 'bold');
text(2, median_paper + 0.05, sprintf('Median: %.2f', median_paper), ...
     'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'red', 'FontWeight', 'bold');

% Set axis limits and formatting
ylim([2.2, 4.1]);
set(gca, 'FontSize', 12);

% Final formatting
set(gcf, 'Position', [100, 100, 800, 600]);
set(gcf, 'Color', 'white');

% Keep the plot displayed
hold off;
drawnow;

% Save the figure
print('boxplot_comparison.png', '-dpng', '-r300');
fprintf('Graph 4 saved as boxplot_comparison.png\n');
