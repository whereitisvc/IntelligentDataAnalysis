clc;
clear all;

[N,A,rawdata]=xlsread('Irisdat.xls');

sepal_len = N(:,1);
sepal_wid = N(:,2);
petal_len = N(:,3);
petal_wid = N(:,4);
class = A(2:151, 5);

%% Scatter
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

figure;
%% X: Sepal length
subplot(4,4,1);
hist(sepal_len); title('Sepal length');

subplot(4,4,5);
plot(SETOSA_sepal_len, SETOSA_sepal_wid,'ro'); hold on;
plot(VIRGINIC_sepal_len, VIRGINIC_sepal_wid,'b*'); hold on;
plot(VERSICOL_sepal_len, VERSICOL_sepal_wid,'g^');
xlabel('Sepal length'); ylabel('Sepal width'); 

subplot(4,4,9);
plot(SETOSA_sepal_len, SETOSA_petal_len,'ro'); hold on;
plot(VIRGINIC_sepal_len, VIRGINIC_petal_len,'b*'); hold on;
plot(VERSICOL_sepal_len, VERSICOL_petal_len,'g^');
xlabel('Sepal length'); ylabel('Petal length'); 

subplot(4,4,13);
plot(SETOSA_sepal_len, SETOSA_petal_wid,'ro'); hold on;
plot(VIRGINIC_sepal_len, VIRGINIC_petal_wid,'b*'); hold on;
plot(VERSICOL_sepal_len, VERSICOL_petal_wid,'g^');
xlabel('Sepal length'); ylabel('Petal width'); 

%% X: Sepal width
subplot(4,4,2);
plot(SETOSA_sepal_wid, SETOSA_sepal_len,'ro'); hold on;
plot(VIRGINIC_sepal_wid, VIRGINIC_sepal_len,'b*'); hold on;
plot(VERSICOL_sepal_wid, VERSICOL_sepal_len,'g^');
xlabel('Sepal width'); ylabel('Sepal length'); 

subplot(4,4,6);
hist(sepal_wid); title('Sepal width');

subplot(4,4,10);
plot(SETOSA_sepal_wid, SETOSA_petal_len,'ro'); hold on;
plot(VIRGINIC_sepal_wid, VIRGINIC_petal_len,'b*'); hold on;
plot(VERSICOL_sepal_wid, VERSICOL_petal_len,'g^');
xlabel('Sepal width'); ylabel('Petal length');

subplot(4,4,14);
plot(SETOSA_sepal_wid, SETOSA_petal_wid,'ro'); hold on;
plot(VIRGINIC_sepal_wid, VIRGINIC_petal_wid,'b*'); hold on;
plot(VERSICOL_sepal_wid, VERSICOL_petal_wid,'g^');
xlabel('Sepal width'); ylabel('Petal width');

%% X: Petal length
subplot(4,4,3);
plot(SETOSA_petal_len, SETOSA_sepal_len,'ro'); hold on;
plot(VIRGINIC_petal_len, VIRGINIC_sepal_len,'b*'); hold on;
plot(VERSICOL_petal_len, VERSICOL_sepal_len,'g^');
xlabel('Petal length'); ylabel('Sepal length'); 

subplot(4,4,7);
plot(SETOSA_petal_len, SETOSA_sepal_wid,'ro'); hold on;
plot(VIRGINIC_petal_len, VIRGINIC_sepal_wid,'b*'); hold on;
plot(VERSICOL_petal_len, VERSICOL_sepal_wid,'g^');
xlabel('Petal length'); ylabel('Sepal width'); 

subplot(4,4,11);
hist(petal_len); title('Petal length');

subplot(4,4,15);
plot(SETOSA_petal_len, SETOSA_petal_wid,'ro'); hold on;
plot(VIRGINIC_petal_len, VIRGINIC_petal_wid,'b*'); hold on;
plot(VERSICOL_petal_len, VERSICOL_petal_wid,'g^');
xlabel('Petal length'); ylabel('Petal width');

%% X: Petal width
subplot(4,4,4);
plot(SETOSA_petal_wid, SETOSA_sepal_len,'ro'); hold on;
plot(VIRGINIC_petal_wid, VIRGINIC_sepal_len,'b*'); hold on;
plot(VERSICOL_petal_wid, VERSICOL_sepal_len,'g^');
xlabel('Petal width'); ylabel('Sepal length');

subplot(4,4,8);
plot(SETOSA_petal_wid, SETOSA_sepal_wid,'ro'); hold on;
plot(VIRGINIC_petal_wid, VIRGINIC_sepal_wid,'b*'); hold on;
plot(VERSICOL_petal_wid, VERSICOL_sepal_wid,'g^');
xlabel('Petal width'); ylabel('Sepal width');

subplot(4,4,12);
plot(SETOSA_petal_wid, SETOSA_petal_len,'ro'); hold on;
plot(VIRGINIC_petal_wid, VIRGINIC_petal_len,'b*'); hold on;
plot(VERSICOL_petal_wid, VERSICOL_petal_len,'g^');
xlabel('Petal width'); ylabel('Petal length');

subplot(4,4,16);
hist(petal_wid); title('Petal width');

%% Normal Probility Fit plot
figure;
subplot(2,4,1); histfit(sepal_len); title('Sepal length');
subplot(2,4,2); histfit(sepal_wid); title('Sepal width');
subplot(2,4,3); histfit(petal_len); title('Petal length');
subplot(2,4,4); histfit(petal_wid); title('Petal width');

subplot(2,4,5); normplot(sepal_len);
subplot(2,4,6); normplot(sepal_wid);
subplot(2,4,7); normplot(petal_len);
subplot(2,4,8); normplot(petal_len);

