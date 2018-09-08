filename = 'Prostate 2016.xls';
[num,txt,raw] = xlsread(filename);

data = num(:, 2:10);
bin = 7;

%% Entropy 
max_ori = (1/97)*(log2(factorial(97))-bin*(log2(gamma(97/bin))));
max_theo = log2(bin);

S_ori = zeros(9,1);
S_theo = zeros(9,1);
edges = zeros(9,bin+1);
for i = 1:9
    [N,A] = hist(data(:,i),bin);
    edges(i, :)=[1.5*A(1)-0.5*A(2) mean(A(1:2)) mean(A(2:3)) mean(A(3:4)) mean(A(4:5)) mean(A(5:6)) mean(A(6:7)) 1.5*A(7)-0.5*A(6)];
    S_ori(i) = (1/97)*(log2(factorial(97))-sum(log2(factorial(N))));

    p = N./97;
    for j = 1:numel(p)
        if (p(j) ~= 0)
            S_theo(i) = S_theo(i) - (p(j).*log2(p(j)));
        end
    end
end

mean_ori = mean(S_ori);
mean_theo = mean(S_theo);
norm_S = S_theo./max_theo;
norm_S_w = mean_theo/max_theo;

%% Conditional Entropy 
bin_label = zeros(97, 9);
for i = 1:97
    for j = 1:9
        for k = 1:bin+1
            if (data(i,j) < edges(j, k))
                bin_label(i, j) = k-1;
                break;
            end
        end
       if (bin_label(i, j) == 0)
           bin_label(i, j) = bin;
       end
    end
end

H_condition = zeros(8, 1);
for i = 1:8
    x_y_distri = zeros(bin,bin);
    for j = 1:97
        x_y_distri(bin_label(j, i), bin_label(j, 9)) = x_y_distri(bin_label(j, i), bin_label(j, 9)) + 1;
    end
    x_y_distri= x_y_distri./97;
    
    for j = 1:bin*bin
        if (x_y_distri(j) ~= 0)
            H_condition(i) = H_condition(i)-(x_y_distri(j) * log2(x_y_distri(j)));
        end
    end
end

H_condition = H_condition - S_theo(1:8);
norm_h_con = H_condition / S_theo(9);

%% Information
I_info = S_theo(9) - H_condition;
norm_I_info = I_info ./ S_theo(9);