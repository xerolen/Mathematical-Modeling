function data = Statistics(area)
% 1 : normal
% 2 : station
% 3 : disease
% 4 : isolated
% 5 : recover
[L, W] = size (area);
data = zeros(5, 1);
for i = 1 : L
    for j = 1 : W
        if area(i, j) == 1
            data(1) = data(1) + 1;
        elseif area(i, j) == 2
            data(2) = data(2) + 1;
        elseif area(i, j) == 3
            data(3) = data(3) + 1;
        elseif area(i, j) == 4
            data(4) = data(4) + 1;
        elseif area(i, j) == 5
            data(5) = data(5) + 1;
        end
    end
end
end

