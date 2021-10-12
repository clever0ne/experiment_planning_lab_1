function print_hystogram(v, n, m, tmean, sigma)
    if (nargin < 4)
        tmean = tmean(v);
    end
    
    if (nargin < 5)
        sigma = std(v, 1);
    end

    tmin = round(tmean - 3 * sigma);
    tmax = round(tmean + 3 * sigma);
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
    
    figure('Name', 'Hystogram');
    plot(t, p1, 'r-', t, p2, 'b--');
    axis([tmin, tmax, 0, round(105 * max([p1', p2'])) / 100]);
    grid on;
    
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    xlabel('$t, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$f_N(t), \rm mm^{-1}$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('$\hat{f}_N(t)$', '$f_N(t)$', 'Interpreter', 'latex', 'FontSize', 10);
    
    saveas(gcf, '..\..\graphs\hystogram.emf');
end

