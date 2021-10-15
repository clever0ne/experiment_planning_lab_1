function [f1, f2] = cumulative_distribution(t, v, n, m, tmean, sigma)
    if (nargin < 3)
        n = length(v);
    end

    if (nargin < 4)
        m = round(sqrt(n));
        if (mod(m, 2) ~= 1)
            m = m + 1;
        end
    end
    
    if (nargin < 5)
        tmean = mean(v);
    end
    
    if (nargin < 6)
        sigma = std(v, 1);
    end

    v = sort(v);
    tmin = v(1);
    tmax = v(end);
    
    f1 = zeros(length(t), 1);
    for i = 1 : length(t)
        if (t(i) < tmin)
            continue;
        end
        
        if (t(i) > tmax)
            f1(i) = 1;
            continue;
        end
        
        j = 1;
        while (t(i) > v(j) && j <= n)
            j = j + 1;
        end
        
        f1(i) = (j - 1) / n;
    end
    
    f2 = (1 + erf((t - tmean) / (sqrt(2) * sigma))) / 2;
end
