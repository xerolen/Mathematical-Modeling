function sum = SumofNei (area, i, j, n, range)
%the sum of neighbors
sum = 0;
for x = i - range : i + range
    for y = j -range : j + range
        if area(x, y) == n
            sum = sum + 1;
        end
    end
end
end