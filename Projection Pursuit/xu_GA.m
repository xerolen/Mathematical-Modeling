%% �Ŵ��㷨������
function xu_AGA()
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
close all
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
    %xbound=accelerate(t,dimension,xxx,xbound,maxj,minj);  %����
end
[mini,maxi,max]=best(s,pop,popsize,dimension,stringlength);
disp(['   ����ֵxi�ֱ�Ϊ��',num2str(xx(maxi,:)),'   ���ֵΪ��',num2str(max)]);
toc;
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

%% ��Ӧ�Ⱥ���funname
function n=funname(x)
z=[-1.178	-1.18	-1.215	-1.257	-1.191	-1.135	-0.84	-1.056	-0.755	-1.08	-0.939	-0.615	0.251	-0.166	0.399	0.088	-0.469	0.422	2.171	2.763	2.461	1.466	3.053	-1.042	-0.679	-0.421	-0.532	0.834	0.112	0.257	0.772	-0.289
    ];
y=[1	1	1	1	1	1.5	2	2	2	2	2	2.5	3	3	3	3	3	3.5	4	4	4	4	4	2	2	3	3	4	3	3	4	3];
a=size(z,2);
for i=1:a
    y1(i)=4/(1+exp(x(1)-x(2)*z(i)));
end
sum=0;
for i=1:a
    sum=sum+(y1(i)-y(i))^2;
end
n=-sum;
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