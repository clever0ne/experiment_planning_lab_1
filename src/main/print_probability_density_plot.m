function print_probability_density_plot(v, n, m, tmean, sigma)
    if (nargin < 4)
        tmean = tmean(v);
    end
    
    if (nargin < 5)
        sigma = std(v, 1);
    end

    v = sort(v);
    tmin = round(min(tmean - 3 * sigma, tmean - 1.1 * abs(tmean - v(1))));
    tmax = round(max(tmean + 3 * sigma, tmean + 1.1 * abs(tmean - v(end))));
    dt = 0.001;
    
    t = (tmin : dt : tmax)';
    if (nargin < 2)
        [p1, p2] = probability_density(t, v);
    elseif (nargin < 3)
        [p1, p2] = probability_density(t, v, n);
    elseif (nargin < 4)
        [p1, p2] = probability_density(t, v, n, m);
    elseif (nargin < 5)
        [p1, p2] = probability_density(t, v, n, m, tmean);
    else
        [p1, p2] = probability_density(t, v, n, m, tmean, sigma);
    end
    
    figure('Name', 'Probability Density');
    plot(t, p1, 'r-', t, p2, 'b--');
    try
        axis([tmin, tmax, 0, round(1100 * max([p1', p2'])) / 1000]);
    catch
        axis([tmin, tmax, 0, 1.1 * max([p1', p2'])]);
    end
    grid on;
    
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    xlabel('$t, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$f_n(t), \rm mm^{-1}$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('$\hat{f}_n(t)$', '$f_n(t)$', 'Interpreter', 'latex', 'FontSize', 10);
    
    warning('off', 'MATLAB:MKDIR:DirectoryExists');
    mkdir ../../graphs;
    saveas(gcf, '../../graphs/probability_density_plot.emf');
end

