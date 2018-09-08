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
                     
check = 1;
time = 0;
while check
% for k = 1 : 2
    sum = zeros(15,4);
    N = zeros(15,1);
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
        if(cluster(i) == 1)
            sum(1,1) = sum(1,1) +traindata(i,1); 
            sum(1,2) = sum(1,2) +traindata(i,2);
            sum(1,3) = sum(1,3) +traindata(i,3);
            sum(1,4) = sum(1,4) +traindata(i,4);
            N(1) = N(1) + 1;
        elseif(cluster(i) == 2)
            sum(2,1) = sum(2,1) +traindata(i,1); 
            sum(2,2) = sum(2,2) +traindata(i,2);
            sum(2,3) = sum(2,3) +traindata(i,3);
            sum(2,4) = sum(2,4) +traindata(i,4);
            N(2) = N(2) + 1;
        elseif(cluster(i) == 3)
            sum(3,1) = sum(3,1) +traindata(i,1); 
            sum(3,2) = sum(3,2) +traindata(i,2);
            sum(3,3) = sum(3,3) +traindata(i,3);
            sum(3,4) = sum(3,4) +traindata(i,4);
            N(3) = N(3) + 1;
        elseif(cluster(i) == 4)
            sum(4,1) = sum(4,1) +traindata(i,1); 
            sum(4,2) = sum(4,2) +traindata(i,2);
            sum(4,3) = sum(4,3) +traindata(i,3);
            sum(4,4) = sum(4,4) +traindata(i,4);
            N(4) = N(4) + 1;
        elseif(cluster(i) == 5)
            sum(5,1) = sum(5,1) +traindata(i,1); 
            sum(5,2) = sum(5,2) +traindata(i,2);
            sum(5,3) = sum(5,3) +traindata(i,3);
            sum(5,4) = sum(5,4) +traindata(i,4);
            N(5) = N(5) + 1;
        elseif(cluster(i) == 6)
            sum(6,1) = sum(6,1) +traindata(i,1); 
            sum(6,2) = sum(6,2) +traindata(i,2);
            sum(6,3) = sum(6,3) +traindata(i,3);
            sum(6,4) = sum(6,4) +traindata(i,4);
            N(6) = N(6) + 1;
        elseif(cluster(i) == 7)
            sum(7,1) = sum(7,1) +traindata(i,1); 
            sum(7,2) = sum(7,2) +traindata(i,2);
            sum(7,3) = sum(7,3) +traindata(i,3);
            sum(7,4) = sum(7,4) +traindata(i,4);
            N(7) = N(7) + 1;
        elseif(cluster(i) == 8)
            sum(8,1) = sum(8,1) +traindata(i,1); 
            sum(8,2) = sum(8,2) +traindata(i,2);
            sum(8,3) = sum(8,3) +traindata(i,3);
            sum(8,4) = sum(8,4) +traindata(i,4);
            N(8) = N(8) + 1;
        elseif(cluster(i) == 9)
            sum(9,1) = sum(9,1) +traindata(i,1); 
            sum(9,2) = sum(9,2) +traindata(i,2);
            sum(9,3) = sum(9,3) +traindata(i,3);
            sum(9,4) = sum(9,4) +traindata(i,4);
            N(9) = N(9) + 1;
        elseif(cluster(i) == 10)
            sum(10,1) = sum(10,1) +traindata(i,1); 
            sum(10,2) = sum(10,2) +traindata(i,2);
            sum(10,3) = sum(10,3) +traindata(i,3);
            sum(10,4) = sum(10,4) +traindata(i,4);
            N(10) = N(10) + 1;
        elseif(cluster(i) == 11)
            sum(11,1) = sum(11,1) +traindata(i,1); 
            sum(11,2) = sum(11,2) +traindata(i,2);
            sum(11,3) = sum(11,3) +traindata(i,3);
            sum(11,4) = sum(11,4) +traindata(i,4);
            N(11) = N(11) + 1;
        elseif(cluster(i) == 12)
            sum(12,1) = sum(12,1) +traindata(i,1); 
            sum(12,2) = sum(12,2) +traindata(i,2);
            sum(12,3) = sum(12,3) +traindata(i,3);
            sum(12,4) = sum(12,4) +traindata(i,4);
            N(12) = N(12) + 1;
        elseif(cluster(i) == 13)
            sum(13,1) = sum(13,1) +traindata(i,1); 
            sum(13,2) = sum(13,2) +traindata(i,2);
            sum(13,3) = sum(13,3) +traindata(i,3);
            sum(13,4) = sum(13,4) +traindata(i,4);
            N(13) = N(13) + 1;
        elseif(cluster(i) == 14)
            sum(14,1) = sum(14,1) +traindata(i,1); 
            sum(14,2) = sum(14,2) +traindata(i,2);
            sum(14,3) = sum(14,3) +traindata(i,3);
            sum(14,4) = sum(14,4) +traindata(i,4);
            N(14) = N(14) + 1;
        elseif(cluster(i) == 15)
            sum(15,1) = sum(15,1) +traindata(i,1); 
            sum(15,2) = sum(15,2) +traindata(i,2);
            sum(15,3) = sum(15,3) +traindata(i,3);
            sum(15,4) = sum(15,4) +traindata(i,4);
            N(15) = N(15) + 1;
        end
    end
    for i = 1 : 15
        for j = 1:4
            mean(i,j) = sum(i,j)/N(i);
        end
    end
%     prototype = mean;
% end

classmatrix = zeros(3,3);
for i = 1 : testNUM
    min = 1000000000;
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

if prototype == mean
    check = 0;
end
prototype = mean;

time = time + 1 ;
end

correct = classmatrix(1,1) + classmatrix(2,2) + classmatrix(3,3);
fprintf('correct_rate=%d%%, %d times \n',correct/testNUM*100,time);


classmatrix = transpose(classmatrix);  


% [IDX,C] = kmeans(X(1:100,1:4),15);
% 
% toolclassmatrix = zeros(4,4);
% for i = 1 : 50
%     min = 10000;
%     dist = 0;
%     dist1 = 0;
%     dist2 = 0;
%     for j = 1:15
%         dist = (testdata(i,1) - C(j,1))^2;
%         dist1 = dist + (testdata(i,2) - C(j,2))^2;
%         dist2 = dist1 + (testdata(i,3) - C(j,3))^2;
%         dist3 = dist2 + (testdata(i,4) - C(j,4))^2;
%         if(dist3 < min)
%             min = dist3;
%             toolprecluster(i) = j;
%         end
%     end
%     if toolprecluster(i) < 6
%         if testdata(i,5) == 1
%             toolclassmatrix(1,1) = toolclassmatrix(1,1) + 1;
%         elseif testdata(i,5) == 2
%             toolclassmatrix(1,2) = toolclassmatrix(1,2) + 1;
%         elseif testdata(i,5) == 3
%             toolclassmatrix(1,3) = toolclassmatrix(1,3) + 1;
%         end
%     elseif toolprecluster(i) < 11
%         if testdata(i,5) == 1
%             toolclassmatrix(2,1) = toolclassmatrix(2,1) + 1;
%         elseif testdata(i,5) == 2
%             toolclassmatrix(2,2) = toolclassmatrix(2,2) + 1;
%         elseif testdata(i,5) == 3
%             toolclassmatrix(2,3) = toolclassmatrix(2,3) + 1;
%         end
%     elseif toolprecluster(i) < 16
%         if testdata(i,5) == 1
%             toolclassmatrix(3,1) = toolclassmatrix(3,1) + 1;
%         elseif testdata(i,5) == 2
%             toolclassmatrix(3,2) = toolclassmatrix(3,2) + 1;
%         elseif testdata(i,5) == 3
%             toolclassmatrix(3,3) = toolclassmatrix(3,3) + 1;
%         end
%     end
% end
% 
% correct = toolclassmatrix(1,1) + toolclassmatrix(2,2) + toolclassmatrix(3,3);
% fprintf('tool correct_rate=%d%% \n',correct/50*100);