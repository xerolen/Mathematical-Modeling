function bool = Equal(x, y)
n = length(x);
bool = 1;
for i = 1 : n
    if x(i) ~= y(i)
        bool = 0;
        break;
    end
end
end