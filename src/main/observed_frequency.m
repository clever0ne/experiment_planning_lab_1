function nu = observed_frequency(v, n, m)
    if (nargin < 2)
        n = length(v);
    end
    
    if (nargin < 3)
        m = round(sqrt(n));
        if (mod(m, 2) ~= 1)
            m = m + 1;
        end
    end
    
    v = sort(v);
    tmin = v(1);
    tmax = v(end);
    dt = (tmax - tmin) / m;
    
    nu = zeros(m, 1);
    i = 1;
    for j = 1 : n
        if (v(j) > tmin + dt * i)
            i = i + 1;
        end
        nu(i) = nu(i) + 1;
    end
end

