%%
% * * * *BOLD TEXT* * * * 
clc;clear all;

[N,A,rawdata]=xlsread('Irisdat.xls');

sepal_len = N(:,1);
sepal_wid = N(:,2);
petal_len = N(:,3);
petal_wid = N(:,4);
class = A(2:151, 5);

%% QDA
sepal_len_QDA = ClassificationDiscriminant.fit(sepal_len,class,'DiscrimType','quadratic');
predicted_species = predict(sepal_len_QDA,sepal_len);
[conf_mat,order] = confusionmat(class,predicted_species);    disp('Confusion Matrix order :'); disp(order); disp('Parameter order :'); disp('SETOSA, VERSICOL, VIRGINIC'); disp('===============================================================================================');
disp('sepal_len_QDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(sepal_len_QDA.Mu);
disp('Variance :'); disp(sepal_len_QDA.Sigma);
disp('---------------------------------------');

sepal_wid_QDA = ClassificationDiscriminant.fit(sepal_wid,class,'DiscrimType','quadratic');
predicted_species = predict(sepal_wid_QDA,sepal_wid);
conf_mat = confusionmat(class,predicted_species);
disp('sepal_wid_QDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(sepal_wid_QDA.Mu);
disp('Variance :'); disp(sepal_wid_QDA.Sigma);
disp('---------------------------------------');

petal_len_QDA = ClassificationDiscriminant.fit(petal_len,class,'DiscrimType','quadratic');
predicted_species = predict(petal_len_QDA,petal_len);
conf_mat = confusionmat(class,predicted_species);
disp('petal_len_QDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(petal_len_QDA.Mu);
disp('Variance :'); disp(petal_len_QDA.Sigma);
disp('---------------------------------------');

petal_wid_QDA = ClassificationDiscriminant.fit(petal_wid,class,'DiscrimType','quadratic');
predicted_species = predict(petal_wid_QDA,petal_wid);
conf_mat = confusionmat(class,predicted_species);
disp('petal_wid_QDA :'); disp(conf_mat);
disp('Mean :'); disp(petal_wid_QDA.Mu);
disp('Variance :'); disp(petal_wid_QDA.Sigma);
disp('===============================================================================================');

%% LDA
sepal_len_LDA = ClassificationDiscriminant.fit(sepal_len,class,'DiscrimType','linear');
predicted_species = predict(sepal_len_LDA,sepal_len);
[conf_mat,order] = confusionmat(class,predicted_species);    
disp('sepal_len_LDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(sepal_len_LDA.Mu);
disp('Variance :'); disp(sepal_len_LDA.Sigma);
disp('---------------------------------------');

sepal_wid_LDA = ClassificationDiscriminant.fit(sepal_wid,class,'DiscrimType','linear');
predicted_species = predict(sepal_wid_LDA,sepal_wid);
conf_mat = confusionmat(class,predicted_species);
disp('sepal_wid_LDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(sepal_wid_LDA.Mu);
disp('Variance :'); disp(sepal_wid_LDA.Sigma);
disp('---------------------------------------');

petal_len_LDA = ClassificationDiscriminant.fit(petal_len,class,'DiscrimType','linear');
predicted_species = predict(petal_len_LDA,petal_len);
conf_mat = confusionmat(class,predicted_species);
disp('petal_len_LDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(petal_len_LDA.Mu);
disp('Variance :'); disp(petal_len_LDA.Sigma);
disp('---------------------------------------');

petal_wid_LDA = ClassificationDiscriminant.fit(petal_wid,class,'DiscrimType','linear');
predicted_species = predict(petal_wid_LDA,petal_wid);
conf_mat = confusionmat(class,predicted_species);
disp('petal_wid_LDA :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(petal_wid_LDA.Mu);
disp('Variance :'); disp(petal_wid_LDA.Sigma);
disp('===============================================================================================');

%% NMC
%{
SETi = 1;
VIRi = 1;
VERi = 1;
for i=1:1:length(class)
    if strcmp( class(i,1),'SETOSA' )
        SETOSA_sepal_len(SETi,1) = sepal_len(i,1);
        SETOSA_sepal_wid(SETi,1) = sepal_wid(i,1);
        SETOSA_petal_len(SETi,1) = petal_len(i,1);
        SETOSA_petal_wid(SETi,1) = petal_wid(i,1);
        SETi = SETi + 1;
    elseif  strcmp( class(i,1),'VIRGINIC' )
        VIRGINIC_sepal_len(VIRi,1) = sepal_len(i,1);
        VIRGINIC_sepal_wid(VIRi,1) = sepal_wid(i,1);
        VIRGINIC_petal_len(VIRi,1) = petal_len(i,1);
        VIRGINIC_petal_wid(VIRi,1) = petal_wid(i,1);
        VIRi = VIRi + 1;
    elseif  strcmp( class(i,1),'VERSICOL' )
        VERSICOL_sepal_len(VERi,1) = sepal_len(i,1);
        VERSICOL_sepal_wid(VERi,1) = sepal_wid(i,1);
        VERSICOL_petal_len(VERi,1) = petal_len(i,1);
        VERSICOL_petal_wid(VERi,1) = petal_wid(i,1);
        VERi = VERi + 1;   
    end
end

% petal_wid NMC
petal_wid_mean = zeros(3,1);
petal_wid_mean(1,1) = sum(SETOSA_petal_wid)/length(SETOSA_petal_wid);
petal_wid_mean(2,1) = sum(VERSICOL_petal_wid)/length(VERSICOL_petal_wid);
petal_wid_mean(3,1) = sum(VIRGINIC_petal_wid)/length(VIRGINIC_petal_wid);
%}
conf_mat = zeros(3,3);
gi = zeros(3,1); %SET, VIR, VER
mu = sepal_len_LDA.Mu;
for i=1:1:length(sepal_len)     
                                        %Input
    if strcmp( class(i,1),'SETOSA' )
        yi = 1;
    elseif strcmp( class(i,1),'VIRGINIC' )
        yi = 2;
    elseif strcmp( class(i,1),'VERSICOL' )
        yi = 3;
    end
                                        %predict
    gi = [ (2*sepal_len(i,1)*mu(1,1)-mu(1,1)^2), (2*sepal_len(i,1)*mu(3,1)-mu(3,1)^2), (2*sepal_len(i,1)*mu(2,1)-mu(2,1)^2) ];
    [mv,index] = max(gi);
    if index == 1
        xi = 1;
    elseif index == 2
        xi = 2;
    elseif index == 3
        xi = 3;
    end
                                       %fill into confusion matrix
    conf_mat(xi,yi) = conf_mat(xi,yi) + 1;
end
disp('sepal_len_NMC :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(mu);
disp('---------------------------------------');

%%
conf_mat = zeros(3,3);
gi = zeros(3,1); %SET, VIR, VER
mu = sepal_wid_LDA.Mu;
for i=1:1:length(sepal_wid)     
                                        %Input
    if strcmp( class(i,1),'SETOSA' )
        yi = 1;
    elseif strcmp( class(i,1),'VIRGINIC' )
        yi = 2;
    elseif strcmp( class(i,1),'VERSICOL' )
        yi = 3;
    end
                                        %predict
    gi = [ (2*sepal_wid(i,1)*mu(1,1)-mu(1,1)^2), (2*sepal_wid(i,1)*mu(3,1)-mu(3,1)^2), (2*sepal_wid(i,1)*mu(2,1)-mu(2,1)^2) ];
    [mv,index] = max(gi);
    if index == 1
        xi = 1;
    elseif index == 2
        xi = 2;
    elseif index == 3
        xi = 3;
    end
                                       %fill into confusion matrix
    conf_mat(xi,yi) = conf_mat(xi,yi) + 1;
end
disp('sepal_wid_NMC :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(mu);
disp('---------------------------------------');

%%
conf_mat = zeros(3,3);
gi = zeros(3,1); %SET, VIR, VER
mu = petal_len_LDA.Mu;
for i=1:1:length(petal_len)     
                                        %Input
    if strcmp( class(i,1),'SETOSA' )
        yi = 1;
    elseif strcmp( class(i,1),'VIRGINIC' )
        yi = 2;
    elseif strcmp( class(i,1),'VERSICOL' )
        yi = 3;
    end
                                        %predict
    gi = [ (2*petal_len(i,1)*mu(1,1)-mu(1,1)^2), (2*petal_len(i,1)*mu(3,1)-mu(3,1)^2), (2*petal_len(i,1)*mu(2,1)-mu(2,1)^2) ];
    [mv,index] = max(gi);
    if index == 1
        xi = 1;
    elseif index == 2
        xi = 2;
    elseif index == 3
        xi = 3;
    end
                                       %fill into confusion matrix
    conf_mat(xi,yi) = conf_mat(xi,yi) + 1;
end
disp('petal_len_NMC :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(mu);
disp('---------------------------------------');

%%
conf_mat = zeros(3,3);
gi = zeros(3,1); %SET, VIR, VER
mu = petal_wid_LDA.Mu;
for i=1:1:length(petal_wid)     
                                        %Input
    if strcmp( class(i,1),'SETOSA' )
        yi = 1;
    elseif strcmp( class(i,1),'VIRGINIC' )
        yi = 2;
    elseif strcmp( class(i,1),'VERSICOL' )
        yi = 3;
    end
                                        %predict
    gi = [ (2*petal_wid(i,1)*mu(1,1)-mu(1,1)^2), (2*petal_wid(i,1)*mu(3,1)-mu(3,1)^2), (2*petal_wid(i,1)*mu(2,1)-mu(2,1)^2) ];
    [mv,index] = max(gi);
    if index == 1
        xi = 1;
    elseif index == 2
        xi = 2;
    elseif index == 3
        xi = 3;
    end
                                       %fill into confusion matrix
    conf_mat(xi,yi) = conf_mat(xi,yi) + 1;
end
disp('petal_wid_NMC :'); disp(conf_mat);
disp('Mean(SET,VER,VIR) :'); disp(mu);


