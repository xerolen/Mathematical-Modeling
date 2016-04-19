%% 极值归一化处理
function a=normalize(b)
D=b;
maxi=max(D);
mini=min(D);
[n m]=size(D);
for i=1:n
    for j=1:m
        D(i,j)=(D(i,j)-mini(j))/(maxi(j)-mini(j));
    end
end
a=D;
