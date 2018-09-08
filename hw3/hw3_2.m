clc;clear all;

load fisheriris;
indices = crossvalind('Kfold',species,5);
Error_Rate = zeros(4,1);
BoxPlot = zeros(5,4);

%% 5-fold Cross-Validation QDA
Conf_MAT = zeros(3,3);
for i = 1:5
    test = (indices == i); 
    train = ~test;
    QDA = ClassificationDiscriminant.fit(meas(train,:),species(train,:),'DiscrimType','quadratic');
    predit = predict(QDA,meas(test,:));
    conf_mat = confusionmat(species(test,:),predit);
    Conf_MAT = Conf_MAT + conf_mat; 
    
    sum = 0;
    for j=1:1:3
        for k=1:1:3
            if(j~=k) 
                sum = sum + conf_mat(j,k);
            end
        end
    end
	error_rate = sum/30;
    BoxPlot(i,4) = error_rate;
end
disp('Confusion Matrix :');disp(Conf_MAT);

Error_Rate(4,1) = mean(BoxPlot(:,4));
disp('Accuracy :');disp(1-Error_Rate(4,1));

%% 5-fold Cross-Validation LDA
Conf_MAT = zeros(3,3);
for i = 1:5
    test = (indices == i); 
    train = ~test;
    LDA = ClassificationDiscriminant.fit(meas(train,:),species(train,:),'DiscrimType','linear');
    predit = predict(LDA,meas(test,:));
    conf_mat = confusionmat(species(test,:),predit);
    Conf_MAT = Conf_MAT + conf_mat;
    
    sum = 0;
    for j=1:1:3
        for k=1:1:3
            if(j~=k) 
                sum = sum + conf_mat(j,k);
            end
        end
    end
	error_rate = sum/30;
    BoxPlot(i,3) = error_rate;
end
disp('Confusion Matrix :');disp(Conf_MAT);

Error_Rate(3,1) = mean(BoxPlot(:,3));
disp('Accuracy :');disp(1-Error_Rate(3,1));

%% 5-fold Cross-Validation Naive Bayesian
Conf_MAT = zeros(3,3);
for i = 1:5
    test = (indices == i); 
    train = ~test;
    NB = ClassificationDiscriminant.fit(meas(train,:),species(train,:),'DiscrimType','diagLinear');
    predit = predict(NB,meas(test,:));
    conf_mat = confusionmat(species(test,:),predit);
    Conf_MAT = Conf_MAT + conf_mat;
    
    sum = 0;
    for j=1:1:3
        for k=1:1:3
            if(j~=k) 
                sum = sum + conf_mat(j,k);
            end
        end
    end
	error_rate = sum/30;
    BoxPlot(i,2) = error_rate;
end
disp('Confusion Matrix :');disp(Conf_MAT);

Error_Rate(2,1) = mean(BoxPlot(:,2));
disp('Accuracy :');disp(1-Error_Rate(2,1));

%% 5-fold Cross-Validation NMC
Conf_MAT = zeros(3,3);
for i = 1:5
    test = (indices == i); 
    train = ~test;
        
    train_meas = meas(train,:);
    train_spec = species(train,:);
    i1=1; i2=1; i3=1;
    for j=1:1:length(train_spec)
        if strcmp( train_spec(j,1),'setosa' )
            class1(i1,:) = train_meas(j,:);
            i1 = i1 + 1;
        elseif strcmp( train_spec(j,1),'versicolor' )
            class2(i2,:) = train_meas(j,:);
            i2 = i2 + 1;
        elseif strcmp( train_spec(j,1),'virginica' )
            class3(i3,:) = train_meas(j,:);
            i3 = i3 + 1; 
        end
    end
    
    test_meas = meas(test,:);
    test_spec = species(test,:);
    conf_mat = zeros(3,3);
    m1 = mean(class1); m2 = mean(class2); m3 = mean(class3);
    for j=1:1:length(test_meas)
        if strcmp( test_spec(j,1),'setosa' )
            ri = 1;
        elseif strcmp( test_spec(j,1),'versicolor' )
            ri = 2;
        elseif strcmp( test_spec(j,1),'virginica' )
            ri = 3;
        end
        
        gi = [ -norm(test_meas(j,:)-m1), -norm(test_meas(j,:)-m2), -norm(test_meas(j,:)-m3)];
        [mv,index] = max(gi);
        if index == 1
            ci = 1;
        elseif index == 2
            ci = 2;
        elseif index == 3
            ci = 3;
        end
        conf_mat(ri,ci) = conf_mat(ri,ci) + 1;
    end
    Conf_MAT = Conf_MAT + conf_mat;
    
    sum = 0;
    for j=1:1:3
        for k=1:1:3
            if(j~=k) 
                sum = sum + conf_mat(j,k);
            end
        end
    end
	error_rate = sum/30;
    BoxPlot(i,1) = error_rate;
end
disp('Confusion Matrix :');disp(Conf_MAT);

Error_Rate(1,1) = mean(BoxPlot(:,1));
disp('Accuracy :');disp(1-Error_Rate(1,1));

%%
figure;
complex = [1,2,3,4];
plot(complex,Error_Rate,'v-'); 

figure;
boxplot(BoxPlot);

















%{
disp('---------------------------------------------------------------');
%%
QDA = ClassificationDiscriminant.fit(meas,species,'DiscrimType','quadratic');
predit = predict(QDA,meas);
conf_mat = confusionmat(species,predit);
disp('Confusion Matrix :');disp(conf_mat);
sum = 0;
for j=1:1:3
    for k=1:1:3
         if(j~=k) 
            sum = sum + conf_mat(j,k);
         end
     end
end
error_rate = sum/150; Error_Rate(4,1) = error_rate;
disp('Error rate :');disp(error_rate);

LDA = ClassificationDiscriminant.fit(meas,species,'DiscrimType','linear');
predit = predict(LDA,meas);
conf_mat = confusionmat(species,predit);
disp('Confusion Matrix :');disp(conf_mat);
sum = 0;
for j=1:1:3
    for k=1:1:3
         if(j~=k) 
            sum = sum + conf_mat(j,k);
         end
     end
end
error_rate = sum/150; Error_Rate(3,1) = error_rate;
disp('Error rate :');disp(error_rate);

NB = ClassificationDiscriminant.fit(meas,species,'DiscrimType','diagLinear');
predit = predict(NB,meas);
conf_mat = confusionmat(species,predit);
disp('Confusion Matrix :');disp(conf_mat);
sum = 0;
for j=1:1:3
    for k=1:1:3
         if(j~=k) 
            sum = sum + conf_mat(j,k);
         end
     end
end
error_rate = sum/150; Error_Rate(2,1) = error_rate;
disp('Error rate :');disp(error_rate);

i1=1; i2=1; i3=1;
for j=1:1:length(species)
    if strcmp( species(j,1),'setosa' )
            nclass1(i1,:) = meas(j,:);
            i1 = i1 + 1;
    elseif strcmp( species(j,1),'versicolor' )
            nclass2(i2,:) = meas(j,:);
            i2 = i2 + 1;
    elseif strcmp( species(j,1),'virginica' )
            nclass3(i3,:) = meas(j,:);
            i3 = i3 + 1; 
    end
end
conf_mat = zeros(3,3);
m1 = mean(nclass1); m2 = mean(nclass2); m3 = mean(nclass3);
for j=1:1:length(meas)
        if strcmp( species(j,1),'setosa' )
            ri = 1;
        elseif strcmp( species(j,1),'versicolor' )
            ri = 2;
        elseif strcmp( species(j,1),'virginica' )
            ri = 3;
        end
    
        m1 = mean(class1); m2 = mean(class2); m3 = mean(class3);
        gi = [ -norm(meas(j,:)-m1), -norm(meas(j,:)-m2), -norm(meas(j,:)-m3)];
        [mv,index] = max(gi);
        if index == 1
            ci = 1;
        elseif index == 2
            ci = 2;
        elseif index == 3
            ci = 3;
        end
        conf_mat(ri,ci) = conf_mat(ri,ci) + 1;
        %disp(ri); disp(ci); disp('--');
end
disp('Confusion Matrix :');disp(conf_mat);
sum = 0;
for j=1:1:3
    for k=1:1:3
         if(j~=k) 
            sum = sum + conf_mat(j,k);
         end
     end
end
error_rate = sum/150; Error_Rate(1,1) = error_rate;
disp('Error rate :');disp(error_rate);
plot(complex,Error_Rate,'rv-');
%}