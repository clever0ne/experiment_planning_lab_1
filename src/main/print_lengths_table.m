function print_lengths_table(v, n)
    if (nargin < 2)
        n = length(v);
    end

    v = sort(v);
    tmean = mean(v);
    sigma = std(v, 1);
    
    tab1 = num2cell((1 : n)');
    tab1{end + 1} = '<t> = ';
    
    tab2 = num2cell(v);
    tab2{end + 1} = cellstr(strrep(string(num2str(tmean, '%.3f')), '.', ','));
    
    tab3 = cellstr(strrep(string(num2str(v - tmean, '%.3f')), '.', ','));
    tab3{end + 1} = 'sigma^2 = ';
    
    tab4 = cellstr(strrep(string(num2str((v - tmean) .^ 2, '%.3f')), '.', ','));
    tab4{end + 1} = cellstr(strrep(string(num2str(sigma ^ 2, '%.3f')), '.', ','));
    
    tab = table(tab1, tab2, tab3, tab4);
    tab.Properties.VariableNames = {'i', 'ti', 'ti - <t>', '(ti - <t>)^2'};
    
    warning('off', 'MATLAB:MKDIR:DirectoryExists');
    mkdir ../../tables;
    writetable(tab, '../../tables/lengths.csv', 'Delimiter', ';');
end
