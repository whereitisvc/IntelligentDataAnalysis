clear all;clc;

filename = 'Irisdat.xls';
[data,txt,raw] = xlsread('Irisdat.xls');

s_length = data(:, 1);
s_width = data(:, 2);
p_length = data(:, 3);
p_width = data(:, 4);

type = txt(2:151, 5);
name = {'SEPALLEN Length', 'SEPALWID Width', 'PETALLEN Length', 'PETALWID Width'};

traning_data = data(1:100, 1:4);
traning_sub_type = type(1:100);
testing_data = data(101:150, 1:4);
testing_sub_type = type(101:150, 1);

setosa_traning_data = traning_data(find(strcmp(traning_sub_type, 'SETOSA')),:);
virginic_traning_data = traning_data(find(strcmp(traning_sub_type, 'VIRGINIC')),:);
versicol_traning_data = traning_data(find(strcmp(traning_sub_type, 'VERSICOL')),:);

testing_type(find(strcmp(testing_sub_type, 'SETOSA'))) = 1;
testing_type(find(strcmp(testing_sub_type, 'VIRGINIC'))) = 2;
testing_type(find(strcmp(testing_sub_type, 'VERSICOL'))) = 3;

traning_type(find(strcmp(traning_sub_type, 'SETOSA'))) = 1;
traning_type(find(strcmp(traning_sub_type, 'VIRGINIC'))) = 2;
traning_type(find(strcmp(traning_sub_type, 'VERSICOL'))) = 3;

epoch_num = 100;
entropy_by_step = zeros(epoch_num, 1);
test_entropy_by_step = zeros(epoch_num, 1);
models = zeros(5, 3);       % 3 classes with 5 variavles (w) each %

learning_rate = 0.002;

%% Training Model
for epoch_idx = 1:epoch_num
    for train_idx = 1:100
        y = zeros(3, 1);    % 3 classes %
        x = ones(5, 1);      % add 1s for w0 %
        x(2:5, 1) = traning_data(train_idx, :);
        r = zeros(3, 1);    % 3 classes %
        r(traning_type(train_idx)) = 1;

        for idx = 1:3
            y(idx) = (exp((models(:, idx))'*x))/(sum(exp((models)'*x)));
        end
        y = r-y;
        delta_w = zeros(5, 3);
        delta_w(:,1) = learning_rate*(y(1))*x;
        delta_w(:,2) = learning_rate*(y(2))*x;
        delta_w(:,3) = learning_rate*(y(3))*x;
        models = models+delta_w;

    end
    
    for entro_idx = 1:100
        y = zeros(3, 1);    % 3 classes %
        x = ones(5, 1);      % add 1s for w0 %
        x(2:5, 1) = traning_data(entro_idx, :);
        r = zeros(3, 1);    % 3 classes %
        r(traning_type(entro_idx)) = 1;
        for idx = 1:3
            y(idx) = (exp((models(:, idx))'*x))/(sum(exp((models)'*x)));
        end
        entropy_by_step(epoch_idx) = entropy_by_step(epoch_idx) - sum(r.*log(y));
    end


%% Testing results
    test_results = zeros(50, 1);
    for test_idx = 1:50
        y = zeros(3, 1);    % 3 classes %
        x = ones(5, 1);      % add 1s for w0 %
        x(2:5, 1) = testing_data(test_idx, :);

        for idx = 1:3

            y(idx) = (exp((models(:, idx))'*x))/(sum(exp((models)'*x)));
        end

        results = find(y == max(y));

        if (numel(results) > 1)     % prevent multiple results %
            results = results(1);
        end

        test_results(test_idx) = results;
    end

    for entro_idx = 1:50
        y = zeros(3, 1);    % 3 classes %
        x = ones(5, 1);      % add 1s for w0 %
        x(2:5, 1) = testing_data(test_idx, :);
        r = zeros(3, 1);    % 3 classes %
        r(testing_type(entro_idx)) = 1;
        for idx = 1:3
            y(idx) = (exp((models(:, idx))'*x))/(sum(exp((models)'*x)));
        end
        test_entropy_by_step(epoch_idx) = test_entropy_by_step(epoch_idx) - sum(r.*log(y));
    end
    
end

%% Examine the results
error_label = zeros(4, 4);
accuracy = 0;
for test_idx = 1:50
    if (test_results(test_idx) == testing_type(test_idx))
        accuracy = accuracy+1;
    end
    error_label(test_results(test_idx), testing_type(test_idx)) = error_label(test_results(test_idx), testing_type(test_idx)) + 1;
    error_label(4, testing_type(test_idx)) = error_label(4, testing_type(test_idx)) + 1;
    error_label(test_results(test_idx), 4) = error_label(test_results(test_idx), 4) + 1;
    error_label(4, 4) = error_label(4, 4) + 1;
end

accuracy= accuracy*100/50;


%% plotting Entropy
figure

plot(entropy_by_step);
hold on;
plot(test_entropy_by_step, '--');

legend('Traning data', 'Testing data');
xlabel ('epoch');
ylabel ('cross entropy');

hold off;