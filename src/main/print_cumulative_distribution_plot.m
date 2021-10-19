function print_cumulative_distribution_plot(v, n, m, tmean, sigma)
    if (nargin < 5)
        tmean = mean(v);
    end
    
    if (nargin < 6)
        sigma = std(v, 1);
    end

    v = sort(v);
    tmin = round(min(tmean - 3 * sigma, tmean - 1.1 * abs(tmean - v(1))));
    tmax = round(max(tmean + 3 * sigma, tmean + 1.1 * abs(tmean - v(end))));
    dt = 0.001;
    
    t = (tmin : dt : tmax)';
    if (nargin < 2)
        [f1, f2] = cumulative_distribution(t, v);
    elseif (nargin < 3)
        [f1, f2] = cumulative_distribution(t, v, n);
    elseif (nargin < 4)
        [f1, f2] = cumulative_distribution(t, v, n, m);
    elseif (nargin < 5)
        [f1, f2] = cumulative_distribution(t, v, n, m, tmean);
    else
        [f1, f2] = cumulative_distribution(t, v, n, m, tmean, sigma);
    end
    
    figure('Name', 'Empirical Cumulative Distribution Function');
    plot(t, f1, 'r-', t, f2, 'b--');
    try
        axis([tmin, tmax, 0, round(1100 * max([f1', f2'])) / 1000]);
    catch
        axis([tmin, tmax, 0, 1.1 * max([f1', f2'])]);
    end
    grid on;
    
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    xlabel('$t, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$F_n(t)$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('$\hat{F}_n(t)$', '$F_n(t)$', 'Interpreter', 'latex', 'FontSize', 10);
    
    warning('off', 'MATLAB:MKDIR:DirectoryExists');
    mkdir ../../graphs;
    saveas(gcf, '../../graphs/cumulative_distribution_plot.emf');
end
