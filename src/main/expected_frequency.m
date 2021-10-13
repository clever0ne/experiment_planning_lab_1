function np = expected_frequency(v, n, m, tmean, sigma)
    if (nargin < 2)
        n = length(v);
    end
    
    if (nargin < 3)
        m = round(sqrt(n));
        if (mod(m, 2) ~= 1)
            m = m + 1;
        end
    end
    
    if (nargin < 4)
        tmean = mean(v);
    end
    
    if (nargin < 5)
        sigma = std(v, 1);
    end
    
    v = sort(v);
    tmin = v(1);
    tmax = v(end);
    dt = (tmax - tmin) / m;
    
    t = (tmin : dt : tmax)';
    x = (t - tmean) / (sqrt(2) * sigma);
    np = n * (erf(x(2 : end)) - erf(x(1 : end - 1))) / 2;
end

