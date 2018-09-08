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

nearest1 = zeros(testNUM,5);
classmatrix1 = zeros(3,3);
correct1 = 0;
for i = 1 : testNUM
    min = 10000;
    for j = 1 : trainNUM
        distance = (testdata(i,1)-traindata(j,1))^2 +  (testdata(i,2)-traindata(j,2))^2 + (testdata(i,3)-traindata(j,3))^2 + (testdata(i,4)-traindata(j,4))^2;
        if distance < min
            min = distance;
            nearest1(i,1:5) = traindata(j,1:5);
        end
    end
    classmatrix1(nearest1(i,5),testdata(i,5)) = classmatrix1(nearest1(i,5),testdata(i,5)) + 1;
    if nearest1(i,5) == testdata(i,5)
        correct1 = correct1 + 1;
    end
end

I1 = nearest1(:,5);

fprintf('1-NN correct_rate=%d%% \n',correct1/testNUM*100);

nearest3_1 = zeros(testNUM,5);
nearest3_2 = zeros(testNUM,5);
nearest3_3 = zeros(testNUM,5);
h = 2;
weight3 = zeros(testNUM,3);
sigma_wt = zeros(testNUM,3);
for i = 1 : testNUM
    min1 = 10000;
    min2 = 10000;
    min3 = 10000;
    for j = 1 : trainNUM
        distance = (testdata(i,1)-traindata(j,1))^2 +  (testdata(i,2)-traindata(j,2))^2 + (testdata(i,3)-traindata(j,3))^2 + (testdata(i,4)-traindata(j,4))^2;
        if distance < min1
            min1 = distance;
            nearest3_1(i,1:5) = traindata(j,1:5);
        elseif distance < min2
            min2 = distance;
            nearest3_2(i,1:5) = traindata(j,1:5);
        elseif distance < min3
            min3 = distance;
            nearest3_3(i,1:5) = traindata(j,1:5);
        end
    end
    u(i,1) = (abs(testdata(i,1) - nearest3_1(i,1)) + abs(testdata(i,2) - nearest3_1(i,2)) + abs(testdata(i,3) - nearest3_1(i,3)) + abs(testdata(i,4) - nearest3_1(i,4)))/h;
    u(i,2) = (abs(testdata(i,1) - nearest3_2(i,1)) + abs(testdata(i,2) - nearest3_2(i,2)) + abs(testdata(i,3) - nearest3_2(i,3)) + abs(testdata(i,4) - nearest3_2(i,4)))/h;
    u(i,3) = (abs(testdata(i,1) - nearest3_3(i,1)) + abs(testdata(i,2) - nearest3_3(i,2)) + abs(testdata(i,3) - nearest3_3(i,3)) + abs(testdata(i,4) - nearest3_3(i,4)))/h;
    sigma_wt(i,1) = ((1/sqrt(2*pi))^4)*exp(-u(i,1)^2/2);
    sigma_wt(i,2) = ((1/sqrt(2*pi))^4)*exp(-u(i,2)^2/2);
    sigma_wt(i,3) = ((1/sqrt(2*pi))^4)*exp(-u(i,3)^2/2);
%     if u(i,1) <=1
%         sigma_wt(i,1) = (1-abs(u(i,1))^3)^3;
%     end
%     if u(i,2) <=1
%         sigma_wt(i,2) = (1-abs(u(i,2))^3)^3;
%     end
%     if u(i,3) <=1
%         sigma_wt(i,3) = (1-abs(u(i,3))^3)^3;
%     end

    if nearest3_1(i,5) == 1
        weight3(i,1) = sigma_wt(i,1);
    elseif nearest3_1(i,5) == 2
        weight3(i,2) = sigma_wt(i,1);
    elseif nearest3_1(i,5) == 3
        weight3(i,3) = sigma_wt(i,1);
    end
    
    if nearest3_2(i,5) == 1
        weight3(i,1) = weight3(i,1) + sigma_wt(i,2);
    elseif nearest3_2(i,5) == 2
        weight3(i,2) = weight3(i,2) + sigma_wt(i,2);
    elseif nearest3_2(i,5) == 3
        weight3(i,3) = weight3(i,3) + sigma_wt(i,2);
    end
    
    if nearest3_3(i,5) == 1
        weight3(i,1) = weight3(i,1) + sigma_wt(i,3);
    elseif nearest3_3(i,5) == 2
        weight3(i,2) = weight3(i,2) + sigma_wt(i,3);
    elseif nearest3_3(i,5) == 3
        weight3(i,3) = weight3(i,3) + sigma_wt(i,3);
    end
    g3(i,1) = weight3(i,1)/(h^4*(sigma_wt(i,1)+sigma_wt(i,2)+sigma_wt(i,3)));
    g3(i,2) = weight3(i,2)/(h^4*(sigma_wt(i,1)+sigma_wt(i,2)+sigma_wt(i,3)));
    g3(i,3) = weight3(i,3)/(h^4*(sigma_wt(i,1)+sigma_wt(i,2)+sigma_wt(i,3)));
end

[C3 I3] =  max(g3');

I3 = I3';

classmatrix3 = zeros(3,3);

for i = 1 : testNUM
    classmatrix3(I3(i),testdata(i,5)) = classmatrix3(I3(i),testdata(i,5)) + 1;
end

correct3 = classmatrix3(1,1) + classmatrix3(2,2) + classmatrix3(3,3);

fprintf('3-NN correct_rate=%d%% \n',correct3/testNUM*100);

nearest5_1 = zeros(testNUM,5);
nearest5_2 = zeros(testNUM,5);
nearest5_3 = zeros(testNUM,5);
nearest5_4 = zeros(testNUM,5);
nearest5_5 = zeros(testNUM,5);

weight5 = zeros(testNUM,3);
sigma_wt5 = zeros(testNUM,5);

for i = 1 : testNUM
    min1 = 10000;
    min2 = 10000;
    min3 = 10000;
    min4 = 10000;
    min5 = 10000;
    for j = 1 : trainNUM
        distance = (testdata(i,1)-traindata(j,1))^2 +  (testdata(i,2)-traindata(j,2))^2 + (testdata(i,3)-traindata(j,3))^2 + (testdata(i,4)-traindata(j,4))^2;
        if distance < min1
            min1 = distance;
            nearest5_1(i,1:5) = traindata(j,1:5);
        elseif distance < min2
            min2 = distance;
            nearest5_2(i,1:5) = traindata(j,1:5);
        elseif distance < min3
            min3 = distance;
            nearest5_3(i,1:5) = traindata(j,1:5);
        elseif distance < min4
            min4 = distance;
            nearest5_4(i,1:5) = traindata(j,1:5);
        elseif distance < min5
            min5 = distance;
            nearest5_5(i,1:5) = traindata(j,1:5);
        end
    end
    u5(i,1) = (abs(testdata(i,1) - nearest5_1(i,1)) + abs(testdata(i,2) - nearest5_1(i,2)) + abs(testdata(i,3) - nearest5_1(i,3)) + abs(testdata(i,4) - nearest5_1(i,4)))/h;
    u5(i,2) = (abs(testdata(i,1) - nearest5_2(i,1)) + abs(testdata(i,2) - nearest5_2(i,2)) + abs(testdata(i,3) - nearest5_2(i,3)) + abs(testdata(i,4) - nearest5_2(i,4)))/h;
    u5(i,3) = (abs(testdata(i,1) - nearest5_3(i,1)) + abs(testdata(i,2) - nearest5_3(i,2)) + abs(testdata(i,3) - nearest5_3(i,3)) + abs(testdata(i,4) - nearest5_3(i,4)))/h;
    u5(i,4) = (abs(testdata(i,1) - nearest5_4(i,1)) + abs(testdata(i,2) - nearest5_4(i,2)) + abs(testdata(i,3) - nearest5_4(i,3)) + abs(testdata(i,4) - nearest5_4(i,4)))/h;
    u5(i,5) = (abs(testdata(i,1) - nearest5_5(i,1)) + abs(testdata(i,2) - nearest5_5(i,2)) + abs(testdata(i,3) - nearest5_5(i,3)) + abs(testdata(i,4) - nearest5_5(i,4)))/h;
    
    sigma_wt5(i,1) = ((1/sqrt(2*pi))^4)*exp(-u5(i,1)^2/2);
    sigma_wt5(i,2) = ((1/sqrt(2*pi))^4)*exp(-u5(i,2)^2/2);
    sigma_wt5(i,3) = ((1/sqrt(2*pi))^4)*exp(-u5(i,3)^2/2);
    sigma_wt5(i,4) = ((1/sqrt(2*pi))^4)*exp(-u5(i,4)^2/2);
    sigma_wt5(i,5) = ((1/sqrt(2*pi))^4)*exp(-u5(i,5)^2/2);
    
%     if u5(i,1) <=1
%         sigma_wt5(i,1) = (1-abs(u5(i,1))^3)^3;
%     end
%     if u5(i,2) <=1
%         sigma_wt5(i,2) = (1-abs(u5(i,2))^3)^3;
%     end
%     if u5(i,3) <=1
%         sigma_wt5(i,3) = (1-abs(u5(i,3))^3)^3;
%     end
%     if u5(i,4) <=1
%         sigma_wt5(i,4) = (1-abs(u5(i,4))^3)^3;
%     end
%     if u5(i,5) <=1
%         sigma_wt5(i,5) = (1-abs(u5(i,5))^3)^3;
%     end
    
    if nearest5_1(i,5) == 1
        weight5(i,1) = sigma_wt5(i,1);
    elseif nearest5_1(i,5) == 2
        weight5(i,2) = sigma_wt5(i,1);
    elseif nearest5_1(i,5) == 3
        weight5(i,3) = sigma_wt5(i,1);
    end
    
    if nearest5_2(i,5) == 1
        weight5(i,1) = weight5(i,1) + sigma_wt5(i,2);
    elseif nearest5_2(i,5) == 2
        weight5(i,2) = weight5(i,2) + sigma_wt5(i,2);
    elseif nearest5_2(i,5) == 3
        weight5(i,3) = weight5(i,3) + sigma_wt5(i,2);
    end
    
    if nearest5_3(i,5) == 1
        weight5(i,1) = weight5(i,1) + sigma_wt5(i,3);
    elseif nearest5_3(i,5) == 2
        weight5(i,2) = weight5(i,2) + sigma_wt5(i,3);
    elseif nearest5_3(i,5) == 3
        weight5(i,3) = weight5(i,3) + sigma_wt5(i,3);
    end
    
    if nearest5_4(i,5) == 1
        weight5(i,1) = weight5(i,1) + sigma_wt5(i,4);
    elseif nearest5_4(i,5) == 2
        weight5(i,2) = weight5(i,2) + sigma_wt5(i,4);
    elseif nearest5_4(i,5) == 3
        weight5(i,3) = weight5(i,3) + sigma_wt5(i,4);
    end
    
    if nearest5_5(i,5) == 1
        weight5(i,1) = weight5(i,1) + sigma_wt5(i,5);
    elseif nearest5_5(i,5) == 2
        weight5(i,2) = weight5(i,2) + sigma_wt5(i,5);
    elseif nearest5_5(i,5) == 3
        weight5(i,3) = weight5(i,3) + sigma_wt5(i,5);
    end
    g5(i,1) = weight5(i,1)/(h^4*(sigma_wt5(i,1)+sigma_wt5(i,2)+sigma_wt5(i,3)+sigma_wt5(i,4)+sigma_wt5(i,5)));
    g5(i,2) = weight5(i,2)/(h^4*(sigma_wt5(i,1)+sigma_wt5(i,2)+sigma_wt5(i,3)+sigma_wt5(i,4)+sigma_wt5(i,5)));
    g5(i,3) = weight5(i,3)/(h^4*(sigma_wt5(i,1)+sigma_wt5(i,2)+sigma_wt5(i,3)+sigma_wt5(i,4)+sigma_wt5(i,5)));
end

realclass = testdata(:,5);

[C5 I5] =  max(g5');

I5 = I5';

classmatrix5 = zeros(3,3);

for i = 1 : testNUM
    classmatrix5(I5(i),testdata(i,5)) = classmatrix5(I5(i),testdata(i,5)) + 1;
end

correct5 = classmatrix5(1,1) + classmatrix5(2,2) + classmatrix5(3,3);

fprintf('5-NN correct_rate=%d%% \n',correct5/testNUM*100);

classmatrix1 = transpose(classmatrix1);
classmatrix3 = transpose(classmatrix3);
classmatrix5 = transpose(classmatrix5);