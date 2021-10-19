clc; close all; clear;

% Эмпирическая выборка
load('../../input.txt');
l = sort(input);

% Определение мощности выборки, выборочного среднего
% и оценки среднеквадратичного отклонения
n = length(l);
lmean = mean(l);
sigma = std(l, 1);

m = round(sqrt(n));
if (mod(m, 2) ~= 1)
    m = m + 1;
end

print_lengths_table(l, n);
print_probability_density_plot(l, n, m, lmean, sigma);
print_cumulative_distribution_plot(l, n, m, lmean, sigma);
print_quantile_quantile_plot(l, n, m, lmean, sigma);

load('../../alpha.txt');

id = fopen('../../output.txt', 'w');
fclose(id);

check_pearson_criterion(alpha, l, n, m, lmean, sigma);
check_kolmogorov_criterion(alpha, l, n, m, lmean, sigma);
