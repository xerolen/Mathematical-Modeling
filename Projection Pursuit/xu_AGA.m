%% 遗传算法主程序
function xu=xu_AGA()
%  pop--种群集合
%  popsize--种群个数
%  stringlength--分量二进制的维数
%  dimension--个体内的分量数即变量个数
%  parent1,parent2--分别为随机选出来进行交叉的个体
%  newpop--变异后种群
%  pm--变异概率
%  s--优秀个体数
%  xbound--n*2的矩阵，n为种群个数，每行第一个数为对应分量最小值，第二个数为对应分量最大值
clear all
% close all
%clc%清屏
tic;%计时器开始计时
t=1; % 迭代计数器
popsize=300;s=10;ger=1000;pm=0.05;stringlength=10;dimension=2;%初始化参数  (popsize,s)常用配比：(300,10) (400,20) (500,30)
pop=encoding(popsize,stringlength,dimension);    %初始化种群
xbound=[-10 10;-10 10];      %变量范围
[pop,xx]=decoding(pop,stringlength,dimension,xbound);   %第一次解码，为第一次选择做准备
xxx(1,:,:)=xx;
[mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
minj(1)=mini;
maxj(1)=maxi;
while t<=ger
    selected=selection(s,pop,popsize,stringlength,dimension);  %选择
    newpop=crossover(selected,popsize,stringlength,dimension);  %杂交
    pop=mutation(newpop,stringlength,dimension,pm);  %变异
    [pop,xx]=decoding(pop,stringlength,dimension,xbound);  %解码
    t=t+1;
    xxx(t,:,:)=xx;
    [mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
    maxj(t)=maxi;
    minj(t)=mini;
    if mod(t,2)==0
        xbound=accelerate(t,dimension,xxx,xbound,maxj,minj);  %加速
    end
    if t==100
        break;
    end
end
[mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
xu=xx(maxi,:);
%disp(['   变量值xi分别为：',num2str(xx(maxi,:)),'   最大值为：',num2str(max)]);
toc;
end


%% 适应度函数funname
function n=funname(x)
z=[-7.30358754259623,-6.64687765601312,-5.32622488837994,-4.61278270898859,-3.63760524438050,-2.27860272187538,-1.09625320283630,-0.317639066595691,0.460972555741536,1.23958444823612,2.01819656142335,2.79680819256576,3.57542034168973,4.35403169686950,5.13264331141664,5.91125512347735,6.68986887569802;];
y=[1	1	1	1	1	2	2	2	3	4	4	4	4	4	5	5	5];
lei=5;
a=size(z,2);
for i=1:a
    y1(i)=lei/(1+exp(x(1)+x(2)*z(i)));
end
sum=0;
for i=1:a
    sum=sum+(y1(i)-y(i))^2;
end
n=-sum;
end

%% 编码，生成初始种群
function pop=encoding(popsize,stringlength,dimension)
pop= round(rand(popsize,dimension*stringlength+1));
end

%% 交叉
function newpop=crossover(pop,popsize,stringlength,dimension)
match=round(rand(1,popsize)*(popsize-1))+1;    %match=unifrnd(1,popsize,1,popsize)
for i=1:popsize/2
    [child1,child2]=crossrunning(pop(i,:),pop(match(i),:),stringlength,dimension);
    newpop(2*i-1:2*i,:)=[child1,pop(2*i-1,dimension*stringlength+1);child2,pop(2*i,dimension*stringlength+1)];
end
end

%% crossrunning为crossover的子程序
function [child1,child2]=crossrunning(parent1,parent2,stringlength,dimension)
cpoint=round((stringlength-1)*rand( 1, dimension))+1;     %cpoint=unifrnd(1,stringlength,1,dimension)
for j=1:dimension
    child1((j-1)*stringlength+1:j*stringlength)=[parent1((j-1)*stringlength+1:(j-1)*stringlength+cpoint(j))   parent2((j-1)*stringlength+cpoint(j)+1:j*stringlength)];
    child2((j-1)*stringlength+1:j*stringlength)=[parent2((j-1)*stringlength+1:(j-1)*stringlength+cpoint(j))   parent1((j-1)*stringlength+cpoint(j)+1:j*stringlength)];
end
end

%% 变异
function newpop=mutation(newpop,stringlength,dimension,pm)
newpopsize=size(newpop,1);
for i=1:newpopsize
    if rand<pm
        mpoint=round(rand(1,dimension)*(stringlength-1))+1;   %随机选定个体中每个分量发生变异的位置
        for j=1:dimension
            newpop(i,(j-1)*stringlength+mpoint(j))=1-newpop(i,(j-1)*stringlength+mpoint(j));    %开始变异
        end
    end
end
end

%% 解码
function [pop,xx]=decoding(pop,stringlength,dimension,xbound)
popsize=size(pop,1);
temp=2.^(stringlength-1:-1:0)/(2^stringlength-1);
for i=1:dimension
    bound(i)=xbound(i,2)-xbound(i,1);
end
for i=1:popsize
    for j=1:dimension
        m(:,j)=pop(i,stringlength*(j-1)+1:stringlength*j);
    end
    x=temp*m;
    x= x.*bound+xbound(:,1)';
    xx(i,:)=x;
    pop(i,dimension*stringlength+1)=funname(x);    %每行的最后一位数为个样本的自适应函数值
end
end



%% 选择
function selected=selection(s,pop,popsize,stringlength,dimension)
PopsizeNew=size(pop,1) ;
r=rand(1,popsize-s);
fitness=pop(:,dimension*stringlength+1);
fitness=fitness/sum( fitness);
fitness=cumsum(fitness);         %构造轮盘
[sorti,sortj]=sort(pop);         %sorti为排序后的pop，sortj为排序后的原索引值
for si=1:s
    selected(si,:)=pop(sortj(popsize-si+1,dimension*stringlength+1),:);   %将前s个优秀个体直接复制到下一代
end
for i=1:popsize-s
    for j=1:PopsizeNew
        if r(i)<=fitness(j)
            selected(i+s,:)=pop(j,:);      %赌轮盘选择剩余个体
            break;
        end
    end
end
end

%% 找出每一次结果的最优解集、
function [mini,maxi,max]=best(s,pop,popsize,dimension,stringlength)
[sorti,sortj]=sort(pop);
maxi=sortj(popsize,dimension*stringlength+1);
mini=sortj(popsize-s+1,dimension*stringlength+1);
max=sorti(popsize,dimension*stringlength+1);
end

%% 加速遗传算法，缩小区间范围
function xbound=accelerate(t,dimension,xxx,xbound,maxj,minj)
for l=1:dimension
    if xxx(t,maxj(t),l)>xxx(t-1,maxj(t-1),l)
        xbound(l,1)=xxx(t,maxj(t),l);
    else
        xbound(l,1)=xxx(t-1,maxj(t-1),l);
    end
end
for l=1:dimension
    if xxx(t,minj(t),l)>xxx(t-1,minj(t-1),l)
        xbound(l,2)=xxx(t-1,minj(t-1),l);
    else
        xbound(l,2)=xxx(t,minj(t),l);
    end
end
end