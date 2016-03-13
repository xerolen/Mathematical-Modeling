function data_sum = SumofNeib (area, i, j, range)
%the sum of neighbors
temp = Amplify(area);
data_sum = zeros(3);
for x = i : i + 2
    for y = j : j + 2
        if temp(x, y) >= 0 && temp(x, y) <= range(1)
            data_sum(1) = data_sum(1) + 1;
        elseif temp(x, y) <= range(2)
            data_sum(2) = data_sum(2) + 1;
        elseif temp(x, y) > range(3)
            data_sum(3) = data_sum(3) + 1;
        end
    end
end
end