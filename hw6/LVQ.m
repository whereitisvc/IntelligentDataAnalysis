clear all

clc;

[X headertext] = xlsread('Irisdat.xls', 'sheet1');

trainNUM = 100;
testNUM = 50;

traindata = X(1:trainNUM, 1:5);
testdata =  X(trainNUM+1:trainNUM+testNUM, 1:5);

%traindata = X(testNUM+1:testNUM+trainNUM, 1:5);
%testdata =  X(1:testNUM, 1:5);
class1 = [];
class2 = [];
class3 = [];

for i = 1 : trainNUM
   if  traindata(i,5) == 1
      class1 = [class1 ; traindata(i,1:4)];
   elseif traindata(i,5) == 2
      class2 = [class2 ; traindata(i,1:4)];
   elseif traindata(i,5) == 3
      class3 = [class3 ; traindata(i,1:4)];
   end
end

for times = 1 : 10

ranpr1 = randsample(size(class1,1),5);
ranpr2 = randsample(size(class2,1),5);
ranpr3 = randsample(size(class3,1),5);


prototype(1:5,1:4) = [ class1(ranpr1(1),1:4) ; 
                       class1(ranpr1(2),1:4) ; 
                       class1(ranpr1(3),1:4) ;
                       class1(ranpr1(4),1:4) ;
                       class1(ranpr1(5),1:4)];
prototype(6:10,1:4) = [ class2(ranpr2(1),1:4) ; 
                        class2(ranpr2(2),1:4) ; 
                        class2(ranpr2(3),1:4) ;
                        class2(ranpr2(4),1:4) ;
                        class2(ranpr2(5),1:4)];
prototype(11:15,1:4) = [ class3(ranpr3(1),1:4) ; 
                         class3(ranpr3(2),1:4) ; 
                         class3(ranpr3(3),1:4) ;
                         class3(ranpr3(4),1:4) ;
                         class3(ranpr3(5),1:4)];

% for k = 1 : 2
    sum = zeros(15,4);
    N = zeros(15,1);
    mean = zeros(15,4);
    eata = 0.5;
    for i = 1 : trainNUM
        min = 10000;
        dist = 0;
        dist1 = 0;
        dist2 = 0;
        for j = 1:15
            dist = (traindata(i,1)-prototype(j,1))^2;
            dist1 = dist + (traindata(i,2)-prototype(j,2))^2;
            dist2 = dist1 + (traindata(i,3) - prototype(j,3))^2;
            dist3 = dist2 + (traindata(i,4)-prototype(j,4))^2;
            if(dist3 < min)
                min = dist3;
                cluster(i) = j;
            end
        end
        if cluster(i) < 6
            if traindata(i,5) == 1
                prototype(cluster(i),1) = prototype(cluster(i),1) + eata*(traindata(i,1) - prototype(cluster(i),1));
                prototype(cluster(i),2) = prototype(cluster(i),2) + eata*(traindata(i,2) - prototype(cluster(i),2));
                prototype(cluster(i),3) = prototype(cluster(i),3) + eata*(traindata(i,3) - prototype(cluster(i),3));
                prototype(cluster(i),4) = prototype(cluster(i),4) + eata*(traindata(i,4) - prototype(cluster(i),4));
            else
                prototype(cluster(i),1) = prototype(cluster(i),1) - eata*(traindata(i,1) - prototype(cluster(i),1));
                prototype(cluster(i),2) = prototype(cluster(i),2) - eata*(traindata(i,2) - prototype(cluster(i),2));
                prototype(cluster(i),3) = prototype(cluster(i),3) - eata*(traindata(i,3) - prototype(cluster(i),3));
                prototype(cluster(i),4) = prototype(cluster(i),4) - eata*(traindata(i,4) - prototype(cluster(i),4));
            end
        elseif cluster(i) < 11
            if traindata(i,5) == 2
                prototype(cluster(i),1) = prototype(cluster(i),1) + eata*(traindata(i,1) - prototype(cluster(i),1));
                prototype(cluster(i),2) = prototype(cluster(i),2) + eata*(traindata(i,2) - prototype(cluster(i),2));
                prototype(cluster(i),3) = prototype(cluster(i),3) + eata*(traindata(i,3) - prototype(cluster(i),3));
                prototype(cluster(i),4) = prototype(cluster(i),4) + eata*(traindata(i,4) - prototype(cluster(i),4));
            else 
                prototype(cluster(i),1) = prototype(cluster(i),1) - eata*(traindata(i,1) - prototype(cluster(i),1));
                prototype(cluster(i),2) = prototype(cluster(i),2) - eata*(traindata(i,2) - prototype(cluster(i),2));
                prototype(cluster(i),3) = prototype(cluster(i),3) - eata*(traindata(i,3) - prototype(cluster(i),3));
                prototype(cluster(i),4) = prototype(cluster(i),4) - eata*(traindata(i,4) - prototype(cluster(i),4));
            end
        elseif cluster(i) < 16
            if traindata(i,5) == 3
                prototype(cluster(i),1) = prototype(cluster(i),1) + eata*(traindata(i,1) - prototype(cluster(i),1));
                prototype(cluster(i),2) = prototype(cluster(i),2) + eata*(traindata(i,2) - prototype(cluster(i),2));
                prototype(cluster(i),3) = prototype(cluster(i),3) + eata*(traindata(i,3) - prototype(cluster(i),3));
                prototype(cluster(i),4) = prototype(cluster(i),4) + eata*(traindata(i,4) - prototype(cluster(i),4));
            else
                prototype(cluster(i),1) = prototype(cluster(i),1) - eata*(traindata(i,1) - prototype(cluster(i),1));
                prototype(cluster(i),2) = prototype(cluster(i),2) - eata*(traindata(i,2) - prototype(cluster(i),2));
                prototype(cluster(i),3) = prototype(cluster(i),3) - eata*(traindata(i,3) - prototype(cluster(i),3));
                prototype(cluster(i),4) = prototype(cluster(i),4) - eata*(traindata(i,4) - prototype(cluster(i),4));
            end
        end
        eata = eata - 0.005;
    end
%   prototype = mean;
% end

mean = prototype;

classmatrix = zeros(3,3);
for i = 1 : testNUM
    min = 10000;
    dist = 0;
    dist1 = 0;
    dist2 = 0;
    for j = 1:15
        dist = (testdata(i,1) - mean(j,1))^2;
        dist1 = dist + (testdata(i,2) - mean(j,2))^2;
        dist2 = dist1 + (testdata(i,3) - mean(j,3))^2;
        dist3 = dist2 + (testdata(i,4) - mean(j,4))^2;
        if(dist3 < min)
            min = dist3;
            precluster(i) = j;
        end
    end
    if precluster(i) < 6
        if testdata(i,5) == 1
            classmatrix(1,1) = classmatrix(1,1) + 1;
        elseif testdata(i,5) == 2
            classmatrix(1,2) = classmatrix(1,2) + 1;
        elseif testdata(i,5) == 3
            classmatrix(1,3) = classmatrix(1,3) + 1;
        end
    elseif precluster(i) < 11
        if testdata(i,5) == 1
            classmatrix(2,1) = classmatrix(2,1) + 1;
        elseif testdata(i,5) == 2
            classmatrix(2,2) = classmatrix(2,2) + 1;
        elseif testdata(i,5) == 3
            classmatrix(2,3) = classmatrix(2,3) + 1;
        end
    elseif precluster(i) < 16
        if testdata(i,5) == 1
            classmatrix(3,1) = classmatrix(3,1) + 1;
        elseif testdata(i,5) == 2
            classmatrix(3,2) = classmatrix(3,2) + 1;
        elseif testdata(i,5) == 3
            classmatrix(3,3) = classmatrix(3,3) + 1;
        end
    end
end
correct = classmatrix(1,1) + classmatrix(2,2) + classmatrix(3,3);
fprintf('time %d: correct_rate=%d%% \n',times,correct/testNUM*100);

classmatrix = transpose(classmatrix);

%fprintf('correct_rate=%d%% \n',correct/50*100);
%eate = eata - 0.05;
end