clear;clc;
d=[];e=[];
X=[3,81,92,74,4.5,7,709,50.14,1.54,9.7,9,10,8;4,80,97,80,6,10,296,58.79,1.92,10.5,8,8,9;2,79,80,63,3.5,6,410,47.8,1.46,9.8,10,90,7;3,80,95,76,3.5,9,898,51.67,1.56,10.4,9,9,9;];
%============���ݵĹ�һ������==============================================
[m,n]=size(X);a=[1 8 9 10];b=[2 3 4 5 6 7 11 12 13];
for k=1:50
    
    for i=1:m
        for j=1:9
            x(i,b(j))=(X(i,b(j))-min(X(:,b(j))))/(max(X(:,b(j)))-min(X(:,b(j))));
        end
    end
    
    for i=1:m
        for j=1:4
            x(i,a(j))=(max(X(:,a(j)))-X(i,a(j)))/(max(X(:,a(j)))-min(X(:,a(j))));
        end
    end
    
    N=400;Pc=0.8;Pm=0.2;M=10;Ci=7;n=13;DaiNo=2;ads=1;
    [a1,b1,ee,ff]=RAGA(x,N,n,Pc,Pm,M,DaiNo,Ci,ads);
    d=[d,a1];e=[b1;e];
end
[a2 b2]=max(d),e1=e(b2,:)
ff=e1*x'