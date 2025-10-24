% Graph 6: Descriptive Statistics Table Visualization - FIXED
clear; clc;

% Create a professional-looking table visualization
figure(6);
clf;
set(gcf, 'Position', [100 100 900 600]);
set(gcf, 'Color', 'white');

% Data for the table (using your exact values)
stats_names = {'Sample Size (n)', 'Mean', 'Median', 'Standard Deviation', ...
              'Variance', 'Standard Error', '95% CI Lower', '95% CI Upper'};
digital_values = {'21', '3.426', '3.50', '0.433', '0.187', '0.094', '3.229', '3.623'};
paper_values = {'14', '3.218', '3.25', '0.500', '0.250', '0.134', '2.929', '3.507'};

% Create axes for table
ax = axes('Position', [0.05 0.3 0.9 0.55]); % moved table down more
axis off;
xlim([0 1]);
ylim([0 1]);

% Table dimensions
n_rows = length(stats_names);
n_cols = 3;
row_height = 0.75 / (n_rows + 1); % space for header + data rows
col_width = 0.9 / n_cols;

% Colors
header_color = [0.2 0.4 0.6];
alt_row_color = [0.95 0.95 0.95];

% Starting positions
start_x = 0.05;
start_y = 0.85; % start from top of axes with more space

% Draw table headers
headers = {'Statistic', 'Digital Notes', 'Paper Notes'};
for j = 1:n_cols
    x = start_x + (j-1) * col_width;
    y = start_y - row_height;

    % Draw header rectangle
    rectangle('Position', [x, y, col_width, row_height], ...
             'FaceColor', header_color, 'EdgeColor', 'black', 'LineWidth', 1.5);

    % Add header text
    text(x + col_width/2, y + row_height/2, headers{j}, ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
         'FontWeight', 'bold', 'Color', 'white', 'FontSize', 11);
end

% Draw table rows
for i = 1:n_rows
    y = start_y - (i+1) * row_height;

    % Alternate row colors
    if mod(i, 2) == 0
        face_color = alt_row_color;
    else
        face_color = 'white';
    end

    % Row data
    row_data = {stats_names{i}, digital_values{i}, paper_values{i}};

    for j = 1:n_cols
        x = start_x + (j-1) * col_width;

        % Draw cell rectangle
        rectangle('Position', [x, y, col_width, row_height], ...
                 'FaceColor', face_color, 'EdgeColor', 'black', 'LineWidth', 0.5);

        % Text alignment and positioning
        if j == 1  % First column left aligned
            alignment = 'left';
            x_text = x + 0.02;
        else       % Data columns center aligned
            alignment = 'center';
            x_text = x + col_width/2;
        end

        % Add cell text
        text(x_text, y + row_height/2, row_data{j}, ...
             'HorizontalAlignment', alignment, 'VerticalAlignment', 'middle', ...
             'FontSize', 10, 'FontWeight', 'normal');
    end
end

%% === Titles & Subtitles ===
% Position titles above the axes
% Main title
text(0.5, 0.98, 'Descriptive Statistics Comparison: Digital vs Paper Note-Taking', ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
     'FontSize', 16, 'FontWeight', 'bold', 'Units', 'normalized');

% Subtitle
text(0.5, 0.94, 'Engineering Students - Academic Performance Analysis', ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
     'FontSize', 12, 'Color', [0.4 0.4 0.4], 'Units', 'normalized');

%% === Key Findings Section ===
% Position findings below the table
mean_diff = 3.426 - 3.218; % 0.208 GPA points

% Create text box for findings - moved up and centered
annotation('textbox', [0.15 0.1 0.7 0.15], ...
          'String', {['Key Findings:'], ...
                    sprintf('Mean Difference: %.3f GPA points (Digital higher)', mean_diff), ...
                    'Digital note-takers show higher mean GPA but also lower variability'}, ...
          'HorizontalAlignment', 'center', ...
          'VerticalAlignment', 'middle', ...
          'FontSize', 11, ...
          'FontWeight', 'bold', ...
          'EdgeColor', 'none', ...
          'BackgroundColor', 'none');

% Data source note - moved up and centered
annotation('textbox', [0.25 0.02 0.5 0.05], ...
          'String', 'Data: n=35 engineering students, Digital n=21, Paper n=14', ...
          'HorizontalAlignment', 'center', ...
          'VerticalAlignment', 'bottom', ...
          'FontSize', 9, ...
          'Color', [0.6 0.6 0.6], ...
          'EdgeColor', 'none', ...
          'BackgroundColor', 'none');

% Save high-resolution image
print('descriptive_statistics_table.png', '-dpng', '-r300');
fprintf('Graph 6 saved as descriptive_statistics_table.png\n');
