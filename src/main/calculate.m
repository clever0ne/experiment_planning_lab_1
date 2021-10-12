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

nu = observed_frequency(l, n, m);
print_hystogram(l, n, m, lmean, sigma);
print_cumulative_distribution_graph(l, n, m, lmean, sigma);
