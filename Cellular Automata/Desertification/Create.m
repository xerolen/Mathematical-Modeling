function [area, Data] = Create(data)
% Create origin system
[n, m] = size(data);
Data = zeros(n, n, m);
var = randperm(n);
for i = 1 : n
    for j = 1 : n
        for k = 1 : 3
            Data(i, j, k) = (data(i, k) + data(var(j), k))/2;
        end
    end
end
area = Data(:,:,1) + Data(:,:,2) + Data(:,:,3);
end