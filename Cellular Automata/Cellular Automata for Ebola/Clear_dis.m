function area = Clear_dis(area, i, j, n, range)
%change 3 to 1
for x = i - range : i + range
    for y = j -range : j + range
        if area(x, y) == n
            area(x, y) = 1;
        end
    end
end
end

