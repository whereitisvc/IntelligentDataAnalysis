clc; clear all;

xt = rand(1,20); 
rt = zeros(5,20);
for i=1:1:5
    noise = normrnd(0,1,[1,20]);
    rt(i,:) = (3*sin(3.14*xt) + 4)+ noise;
end

points = 0:0.01:1; 
f = 3*sin(3.14*points) + 4;

% plot a sample of data along with f
figure; 
subplot(2,2,1);
plot(xt,rt(1,:), 'k+','LineWidth', 1); hold on;
plot(points,f,'r','LineWidth', 3); hold on;
%axis()

degree = 1;
p1 = polyfit(xt,rt(1,:),degree); p1v = polyval(p1,points);
p2 = polyfit(xt,rt(2,:),degree); p2v = polyval(p2,points);
p3 = polyfit(xt,rt(3,:),degree); p3v = polyval(p3,points);
p4 = polyfit(xt,rt(4,:),degree); p4v = polyval(p4,points);
p5 = polyfit(xt,rt(5,:),degree); p5v = polyval(p5,points);
pv_average = (p1v + p2v + p3v + p4v + p5v)/5;
subplot(2,2,2);
plot(points,f,'r','LineWidth', 3); hold on;
plot(points,p1v,'k','LineWidth', 1); hold on;
plot(points,p2v,'k','LineWidth', 1); hold on;
plot(points,p3v,'k','LineWidth', 1); hold on;
plot(points,p4v,'k','LineWidth', 1); hold on;
plot(points,p5v,'k','LineWidth', 1); hold on;
plot(points,pv_average,'b','LineWidth', 3);
legend('f','sample #1','sample #2','sample #3','sample #4','sample #5','average');

degree = 3;
p1 = polyfit(xt,rt(1,:),degree); p1v = polyval(p1,points);
p2 = polyfit(xt,rt(2,:),degree); p2v = polyval(p2,points);
p3 = polyfit(xt,rt(3,:),degree); p3v = polyval(p3,points);
p4 = polyfit(xt,rt(4,:),degree); p4v = polyval(p4,points);
p5 = polyfit(xt,rt(5,:),degree); p5v = polyval(p5,points);
pv_average = (p1v + p2v + p3v + p4v + p5v)/5;
subplot(2,2,3);
plot(points,f,'r','LineWidth', 3); hold on;
plot(points,p1v,'k','LineWidth', 1); hold on;
plot(points,p2v,'k','LineWidth', 1); hold on;
plot(points,p3v,'k','LineWidth', 1); hold on;
plot(points,p4v,'k','LineWidth', 1); hold on;
plot(points,p5v,'k','LineWidth', 1); hold on;
plot(points,pv_average,'b','LineWidth', 3);

degree = 5;
p1 = polyfit(xt,rt(1,:),degree); p1v = polyval(p1,points);
p2 = polyfit(xt,rt(2,:),degree); p2v = polyval(p2,points);
p3 = polyfit(xt,rt(3,:),degree); p3v = polyval(p3,points);
p4 = polyfit(xt,rt(4,:),degree); p4v = polyval(p4,points);
p5 = polyfit(xt,rt(5,:),degree); p5v = polyval(p5,points);
pv_average = (p1v + p2v + p3v + p4v + p5v)/5;
subplot(2,2,4);
plot(points,f,'r','LineWidth', 3); hold on;
plot(points,p1v,'k','LineWidth', 1); hold on;
plot(points,p2v,'k','LineWidth', 1); hold on;
plot(points,p3v,'k','LineWidth', 1); hold on;
plot(points,p4v,'k','LineWidth', 1); hold on;
plot(points,p5v,'k','LineWidth', 1); hold on;
plot(points,pv_average,'b','LineWidth', 3);

%%
Ft = 3*sin(3.14*xt) + 4; 
Variance = zeros(5,1);
Bias_2 = zeros(5,1);
M = 100;
for degree = 1:1:5
    rt = zeros(M,20); %100 samples
    
    pv_avg = 0;
    for i=1:1:M
        noise = normrnd(0,1,[1,20]);
        rt(i,:) = (3*sin(3.14*xt) + 4)+ noise;
        p = polyfit(xt,rt(i,:),degree); pv = polyval(p,points);
        pv_avg = pv_avg + pv;
    end
    pv_avg = pv_avg / M;
    
    % Caculate Bias^2
    temp = 0;
    for j=1:1:length(points)
        temp = temp + (pv_avg(1,j) - f(1,j))^2;
    end
    Bias_2(degree,1) = temp/length(points);
    
    % Caculate Variance
    temp1 = 0;
    for i=1:1:M
        p = polyfit(xt,rt(i,:),degree); pv = polyval(p,points);
        gx = pv;
        temp2 = 0;
        for j=1:1:length(points)
            temp2 = temp2 + (gx(1,j) - pv_avg(1,j))^2;
        end
        temp1 = temp1 + temp2;
    end
    Variance(degree,1) = temp1/(M*length(points));
end
Error = Bias_2 + Variance;

figure;

%{
subplot(2,1,1);
plot(points,f,'r','LineWidth', 3); hold on;
plot(points,pv_avg,'b','LineWidth', 3);

subplot(2,1,2);
%}
plot(Bias_2,'b-v'); hold on;
plot(Variance,'g-v'); hold on;
plot(Error, 'r-o');
legend('Bias^2','Variance','Error = Bias^2 + Variance');





