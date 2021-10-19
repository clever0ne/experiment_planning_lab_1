function print_quantile_quantile_plot(v, n, m, tmean, sigma)
    if (nargin < 5)
        tmean = mean(v);
    end
    
    if (nargin < 6)
        sigma = std(v, 1);
    end

    v = sort(v);
    tmin = v(1);
    tmax = v(end);
    
    q1 = v;
    q2 = (sqrt(2) * sigma) * erfinv(2 * (1 : n)'/ n - 1) + tmean;
    p = polyfit(q1(1 : end - 1), q2(1 : end - 1), 1);
    q0 = polyval(p, q1);
    
    figure('Name', 'Quantile – Quantile Plot');
    plot(q2, q1, 'ro', q0, q1, 'r-.', q1, q1, 'b--'); 
    axis([tmin, tmax, tmin, tmax]);
    grid on;
    
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    xlabel('$Q_n, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$\hat{Q}_n, \rm mm$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('$Q_n \textrm{ -- } \hat{Q}_n$', '$\hat{Q}_n$', '$Q_n$', 'Interpreter', 'latex', 'FontSize', 10);
    
    warning('off', 'MATLAB:MKDIR:DirectoryExists');
    mkdir ../../graphs;
    saveas(gcf, '../../graphs/quantile_quantile_plot.emf');
end

