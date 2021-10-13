function print_lengths_table(v, n)
    if (nargin < 2)
        n = length(v);
    end

    v = sort(v);
    tmean = mean(v);
    
    tab1 = (1 : n)';
    tab2 = v;
    tab3 = cellstr(num2str(v - tmean, '%.3f'));
    tab4 = cellstr(num2str((v - tmean) .^ 2, '%.3f'));
    
    tab = table(tab1, tab2, tab3, tab4);
    tab{n + 1, 2} = tmean;
    tab{n + 1, 4} = cellstr(num2str(mean((v - tmean) .^ 2)));
    tab.Properties.VariableNames = {'i', 'li', 'li - <l>', '(li - <l>)^2'};
    
    mkdir ../../tables;
    writetable(tab, '../../tables/lengths.csv', 'Delimiter', ';');
end
