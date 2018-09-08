% IDA HW6
clear all; clc;

iris_data= importdata('Irisdat2.xls');

% Create new variables in the base workspace from those fields.
%vars = fieldnames(iris_data);
%for i = 1:length(vars)
%    assignin('base', vars{i}, iris_data.(vars{i}));
%end

num_data=iris_data.data;
type_data=char( iris_data.textdata(2:151,5) );
type_data=sum(type_data')';
num_data(:,5)=type_data;


class_name=zeros(3,1);
class_name(1)=type_data(1);%setosa  527
class_name(2)=type_data(2);%virginica 603
class_name(3)=type_data(3);%versicolor 615


%class_train_1
%class_train_2
%class_train_3
class_num=zeros(3,1);
for i=1:100
    if type_data(i)==class_name(1)
        class_num(1)=class_num(1)+1;
        class_train(class_num(1),:,1)=num_data(i,1:4);
    elseif type_data(i)==class_name(2)
        class_num(2)=class_num(2)+1;        
        class_train(class_num(2),:,2)=num_data(i,1:4);
    elseif type_data(i)==class_name(3)
        class_num(3)=class_num(3)+1;
        class_train(class_num(3),:,3)=num_data(i,1:4);
    end
end

%Kernel====================================

trainNUM = 100;
testNUM = 50;

train_data=num_data(1:trainNUM,:);
test_data=num_data(trainNUM+1:trainNUM+testNUM,:);
est_class=zeros(testNUM,1);

%train_data=num_data(testNUM+1:testNUM+trainNUM,:);
%test_data=num_data(1:testNUM,:);
%est_class=zeros(testNUM,1);

h=2
%h=0.2
%h=0.02

for i=1:testNUM
    %distance_2=zeros(100,2);
    p_x_c=[0 0 0]';
    p_c=(class_num/100);
    for j=1:trainNUM
        %distance_2(j,1)=j;
        %distance_2(j,2)=norm( (train_data(j,1:4)-test_data(i,1:4))/h );
        if train_data(j,5)== class_name(1)
            %p_x_c(1)=p_x_c(1)+exp(-norm(((test_data(i,1:4)-train_data(j,1:4))/h))^2 /2) / sqrt(2*pi);
            p_x_c(1) = p_x_c(1) + ((1/sqrt(2*pi))^4)*exp(-norm(((test_data(i,1:4)-train_data(j,1:4))/h))^2/2);
            
            
        end
        
        if train_data(j,5)== class_name(2)
            %p_x_c(2)=p_x_c(2)+exp(-norm(((test_data(i,1:4)-train_data(j,1:4))/h))^2 /2) / sqrt(2*pi);
            p_x_c(2) = p_x_c(2) + ((1/sqrt(2*pi))^4)*exp(-norm(((test_data(i,1:4)-train_data(j,1:4))/h))^2/2);
        end
        
        if train_data(j,5)== class_name(3)
            %p_x_c(3)=p_x_c(3)+exp(-norm(((test_data(i,1:4)-train_data(j,1:4))/h))^2 /2) / sqrt(2*pi);
            p_x_c(3) = p_x_c(3) + ((1/sqrt(2*pi))^4)*exp(-norm(((test_data(i,1:4)-train_data(j,1:4))/h))^2/2);
        end
         
    end
    
    p_x_c=p_x_c ./ class_num * 3 / (h^4);
    [Y I]=max(p_x_c .* p_c);
        
    est_class(i)=class_name(I);
    
end


class_matrix=zeros(3,3);
for i=1:testNUM
    for k=1:3
       if  test_data(i,5)==class_name(k)
           for j=1:3
               if est_class(i)==class_name(j)
                   class_matrix(k,j)=class_matrix(k,j)+1;
               end
           end
       end
    end
end
class_matrix






