function check_kolmogorov_criterion(alpha, v, n, m, tmean, sigma)
    v = sort(v);
    tmin = v(1);
    tmax = v(end);
    dt = 0.001;
    
    t = (tmin : dt : tmax)';
    if (nargin < 3)        
        [f1, f2] = cumulative_distribution(t, v);
    elseif (nargin < 4)
        [f1, f2] = cumulative_distribution(t, v, n);
    elseif (nargin < 5)
        [f1, f2] = cumulative_distribution(t, v, n, m);
    elseif (nargin < 6)
        [f1, f2] = cumulative_distribution(t, v, n, m, tmean);
    else
        [f1, f2] = cumulative_distribution(t, v, n, m, tmean, sigma);
    end

    dn = max(abs(f1 - f2));
    lambda_1 = (6 * n * dn + 1) / (sqrt(n) * 6);
    lambda_2 = sqrt(-log(alpha / 2) / 2);
    
    id = fopen('../../output.txt', 'a');
    
    fprintf(id, 'Kolmogorov – Smirnov Test Result:\n\n');
    fprintf(id, 'Significance level ''alpha'':             %8.3f\n', alpha);
    fprintf(id, 'Empirical value ''lambda'':               %8.3f\n', lambda_1);
    fprintf(id, 'Critical value ''lambda_critical'':       %8.3f\n', lambda_2);
    
    if (lambda_1 < lambda_2)
        fprintf(id, '\n''lambda'' = %.3f < ''lambda_critical'' = %.3f\n', lambda_1, lambda_2);
        fprintf(id, 'The hypothesis of the normal distribution was accepted.\n\n\n\n');
    else
        fprintf(id, '\n''lambda'' = %.3f > ''lambda_critical'' = %.3f\n', lambda_1, lambda_2);
        fprintf(id, 'The hypothesis of the normal distribution was denied.\n\n\n\n');
    end
    
    fclose(id);
end

