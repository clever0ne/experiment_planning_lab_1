function print_cumulative_distribution_graph(v, n, m, tmean, sigma)
    if (nargin < 5)
        tmean = mean(v);
    end
    
    if (nargin < 6)
        sigma = std(v, 1);
    end

    tmin = round(tmean - 3 * sigma);
    tmax = round(tmean + 3 * sigma);
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
    axis([tmin, tmax, 0, round(105 * max([f1', f2'])) / 100]);
    grid on;
    
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    xlabel('$t, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$F_N(t)$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('$\hat{F}_N(t)$', '$F_N(t)$', 'Interpreter', 'latex', 'FontSize', 10);
    
    saveas(gcf, '..\..\graphs\cumulative_distribution.emf');
end

