%% �Ŵ��㷨������
function xu=xu_AGA()
%  pop--��Ⱥ����
%  popsize--��Ⱥ����
%  stringlength--���������Ƶ�ά��
%  dimension--�����ڵķ���������������
%  parent1,parent2--�ֱ�Ϊ���ѡ�������н���ĸ���
%  newpop--�������Ⱥ
%  pm--�������
%  s--���������
%  xbound--n*2�ľ���nΪ��Ⱥ������ÿ�е�һ����Ϊ��Ӧ������Сֵ���ڶ�����Ϊ��Ӧ�������ֵ
clear all
% close all
%clc%����
tic;%��ʱ����ʼ��ʱ
t=1; % ����������
popsize=300;s=10;ger=1000;pm=0.05;stringlength=10;dimension=2;%��ʼ������  (popsize,s)������ȣ�(300,10) (400,20) (500,30)
pop=encoding(popsize,stringlength,dimension);    %��ʼ����Ⱥ
xbound=[-10 10;-10 10];      %������Χ
[pop,xx]=decoding(pop,stringlength,dimension,xbound);   %��һ�ν��룬Ϊ��һ��ѡ����׼��
xxx(1,:,:)=xx;
[mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
minj(1)=mini;
maxj(1)=maxi;
while t<=ger
    selected=selection(s,pop,popsize,stringlength,dimension);  %ѡ��
    newpop=crossover(selected,popsize,stringlength,dimension);  %�ӽ�
    pop=mutation(newpop,stringlength,dimension,pm);  %����
    [pop,xx]=decoding(pop,stringlength,dimension,xbound);  %����
    t=t+1;
    xxx(t,:,:)=xx;
    [mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
    maxj(t)=maxi;
    minj(t)=mini;
    if mod(t,2)==0
        xbound=accelerate(t,dimension,xxx,xbound,maxj,minj);  %����
    end
    if t==100
        break;
    end
end
[mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
xu=xx(maxi,:);
%disp(['   ����ֵxi�ֱ�Ϊ��',num2str(xx(maxi,:)),'   ���ֵΪ��',num2str(max)]);
toc;
end


%% ��Ӧ�Ⱥ���funname
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

%% ���룬���ɳ�ʼ��Ⱥ
function pop=encoding(popsize,stringlength,dimension)
pop= round(rand(popsize,dimension*stringlength+1));
end

%% ����
function newpop=crossover(pop,popsize,stringlength,dimension)
match=round(rand(1,popsize)*(popsize-1))+1;    %match=unifrnd(1,popsize,1,popsize)
for i=1:popsize/2
    [child1,child2]=crossrunning(pop(i,:),pop(match(i),:),stringlength,dimension);
    newpop(2*i-1:2*i,:)=[child1,pop(2*i-1,dimension*stringlength+1);child2,pop(2*i,dimension*stringlength+1)];
end
end

%% crossrunningΪcrossover���ӳ���
function [child1,child2]=crossrunning(parent1,parent2,stringlength,dimension)
cpoint=round((stringlength-1)*rand( 1, dimension))+1;     %cpoint=unifrnd(1,stringlength,1,dimension)
for j=1:dimension
    child1((j-1)*stringlength+1:j*stringlength)=[parent1((j-1)*stringlength+1:(j-1)*stringlength+cpoint(j))   parent2((j-1)*stringlength+cpoint(j)+1:j*stringlength)];
    child2((j-1)*stringlength+1:j*stringlength)=[parent2((j-1)*stringlength+1:(j-1)*stringlength+cpoint(j))   parent1((j-1)*stringlength+cpoint(j)+1:j*stringlength)];
end
end

%% ����
function newpop=mutation(newpop,stringlength,dimension,pm)
newpopsize=size(newpop,1);
for i=1:newpopsize
    if rand<pm
        mpoint=round(rand(1,dimension)*(stringlength-1))+1;   %���ѡ��������ÿ���������������λ��
        for j=1:dimension
            newpop(i,(j-1)*stringlength+mpoint(j))=1-newpop(i,(j-1)*stringlength+mpoint(j));    %��ʼ����
        end
    end
end
end

%% ����
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
    pop(i,dimension*stringlength+1)=funname(x);    %ÿ�е����һλ��Ϊ������������Ӧ����ֵ
end
end



%% ѡ��
function selected=selection(s,pop,popsize,stringlength,dimension)
PopsizeNew=size(pop,1) ;
r=rand(1,popsize-s);
fitness=pop(:,dimension*stringlength+1);
fitness=fitness/sum( fitness);
fitness=cumsum(fitness);         %��������
[sorti,sortj]=sort(pop);         %sortiΪ������pop��sortjΪ������ԭ����ֵ
for si=1:s
    selected(si,:)=pop(sortj(popsize-si+1,dimension*stringlength+1),:);   %��ǰs���������ֱ�Ӹ��Ƶ���һ��
end
for i=1:popsize-s
    for j=1:PopsizeNew
        if r(i)<=fitness(j)
            selected(i+s,:)=pop(j,:);      %������ѡ��ʣ�����
            break;
        end
    end
end
end

%% �ҳ�ÿһ�ν�������Ž⼯��
function [mini,maxi,max]=best(s,pop,popsize,dimension,stringlength)
[sorti,sortj]=sort(pop);
maxi=sortj(popsize,dimension*stringlength+1);
mini=sortj(popsize-s+1,dimension*stringlength+1);
max=sorti(popsize,dimension*stringlength+1);
end

%% �����Ŵ��㷨����С���䷶Χ
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