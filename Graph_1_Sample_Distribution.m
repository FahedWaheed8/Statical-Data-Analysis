% Graph 1: Sample Distribution by Note-Taking Method
clear; clc;

% Data
methods = {'Digital', 'Paper', 'Excluded'};
counts = [21, 14, 18];  % 53 total - 35 analyzed = 18 excluded

% Create bar chart
figure(1);
bar(counts, 'FaceColor', [0.2 0.4 0.6]);
set(gca, 'XTickLabel', methods);
xlabel('Note-Taking Method');
ylabel('Number of Students');
title('Sample Distribution by Note-Taking Method (n=53)');
grid on;

% Add value labels on bars
for i = 1:length(counts)
    text(i, counts(i) + 0.5, num2str(counts(i)), ...
         'HorizontalAlignment', 'center', 'FontWeight', 'bold');
end

% Add percentage labels
total = sum(counts);
for i = 1:length(counts)
    pct = (counts(i)/total) * 100;
    text(i, counts(i) - 1, sprintf('%.1f%%', pct), ...
         'HorizontalAlignment', 'center', 'Color', 'white', 'FontWeight', 'bold');
end

ylim([0 max(counts) + 3]);
set(gca, 'FontSize', 12);

% Save the figure
print('sample_distribution.png', '-dpng', '-r300');
