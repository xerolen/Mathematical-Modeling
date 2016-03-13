function [new_area] = Change_area(area, weight)
% Change the area and Data
[L, W] = size(area);
temp = Amplify(area, mean(area(:)));
new_area = zeros(L, W);
for i = 1 : L
    for j = 1 : W
        for x = i : i + 2
            for y = j : j + 2
                if x == i+1 && y == j+1
                    new_area(i, j) = new_area(i, j) + weight(2)*temp(x, y);
                else
                    new_area(i, j) = new_area(i, j) + weight(1)*temp(x, y);
                end
            end
        end
    end
end
end