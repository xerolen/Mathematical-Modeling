%subfunction of RAGA_PPC
function y=Target(x,y,a)
[m,n]=size(x);
for i=1:m
    s1=0;
    for j=1:n
        s1=s1+a(j)*x(i,j);
    end
    z(i)=s1;
end
%��z�ı�׼��Sz
Sz=std(z);
%����z�ľֲ��ܶ�Dz
r1=0;r2=0;r3=0;
for i=1:m
    r1=r1+(z(i)-mean(z))*(y(i)-mean(y));
    r2=r2+(z(i)-mean(z))^2;
    r3=r3+(y(i)-mean(y))^2;
end
r4=(r2*r3)^0.5;
Rzy=r1/r4;
%����Ŀ�꺯��ֵQ
y=Sz*abs(Rzy);