%% 极值归一化处理
function a=normalize(b)
D=b;
[n m]=size(D);
for i=1:m
    Ex(i)=mean(D(:,i));
end
for i=1:m
    Sx(i)=std(D(:,i));
end
for i=1:n
    for j=1:m
        if Sx(j)~=0
            D(i,j)=(D(i,j)-Ex(j))/Sx(j);
        else
            D(i,j)=(D(i,j)-Ex(j))/1;
        end
    end
end
a=D;
