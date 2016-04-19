x=[-0.4357   -1.2404];
lei=5;
z=-8:0.01:8;
for i=1:1601
    y1(i)=lei/(1+exp(x(1)+x(2)*z(i)));
end
figure
plot(z,y1)