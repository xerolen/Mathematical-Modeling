d=[];e=[];
X=Variable;
%============数据的归一化处理==============================================
[m,n]=size(X);
for k=1:50
    x=normalize(X);
    N=400;Pc=0.8;Pm=0.2;M=10;Ci=7;n=11;DaiNo=2;ads=1;
    [a1,b1,ee,ff]=RAGA(x,N,n,Pc,Pm,M,DaiNo,Ci,ads);
    d=[d,a1];e=[b1;e];
end
[a2 b2]=max(d);
e1=e(b2,:);
ff=e1*x';
figure(1);
title('样本评价图');
plot(1:41,ff(1,1:41),'k+');
hold on;
plot(42:72,ff(1,42:72),'r*');
plot(73:113,ff(1,73:113),'bo');
xlabel('样本编号');
ylabel('评价值大小');
legend('轮牧样本','开垦样本','过牧样本');



 figure(2);
for i=1:113
    if Idx(i,1)==1
        plot(i,ff(1,i),'k+');
        hold on;
    elseif Idx(i,1)==2
        plot(i,ff(1,i),'r*');
        hold on;
    else
        plot(i,ff(1,i),'o','Color',[0,0.5,0.4]);
        hold on;
    end;
end;
title('样本分类图');
xlabel('样本编号');
ylabel('评价值大小');
line([0,115],[0.3918,0.3918]);
hold on;
line([0,115],[0.7629,0.7629]);
hold off;