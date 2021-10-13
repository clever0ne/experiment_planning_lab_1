function check_pearson_criterion(alpha, v, n, m, tmean, sigma)
    if (nargin < 3)
        n = length(v);
        m = round(sqrt(n));
        if (mod(m, 2) ~= 1)
            m = m + 1;
        end
        
        nu = observed_frequency(v);
        np = expected_frequency(v);
    elseif (nargin < 4)
        nu = observed_frequency(v, n);
        np = expected_frequency(v, n);
    else
        nu = observed_frequency(v, n, m);
        
        if (nargin < 5)
            np = expected_frequency(v, n, m);
        elseif (nargin < 6)
            np = expected_frequency(v, n, m, tmean);
        else
            np = expected_frequency(v, n, m, tmean, sigma);
        end
    end
    
    chi_square_1 = sum(((nu - np) .^ 2) ./ np);
    
    r = m - 2 - 1;
    chi_square_2 = chi2inv(1 - alpha, r);
    
    id = fopen('../../output.txt', 'a');
    
    fprintf(id, 'Pearson''s Chi-Squared Test Result:\n\n');
    fprintf(id, 'Degrees of freedom ''r'':                 %.3f\n', r);
    fprintf(id, 'Significance level ''alpha'':             %.3f\n', alpha);
    fprintf(id, 'Empirical Chi-Square value ''X^2(n)'':    %.3f\n', chi_square_1);
    fprintf(id, 'Chi-Square value ''X^2(r, alpha)'':       %.3f\n', chi_square_2);
    
    if (chi_square_1 < chi_square_2)
        fprintf(id, '\n''X^2(n)'' = %.3f < ''X^2(alpha, r)'' = %.3f\n', chi_square_1, chi_square_2);
        fprintf(id, 'The hypothesis of the normal distribution was accepted.\n\n\n\n');
    else
        fprintf(id, '\n''X^2(n)'' = %.3f > ''X^2(alpha, r)'' = %.3f\n', chi_square_1, chi_square_2);
        fprintf(id, 'The hypothesis of the normal distribution was denied.\n\n\n\n');
    end
    
    fclose(id);
end
