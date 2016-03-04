function [newData] = ChangeArea(Data, MapData, lambda)
% Change the area and Data
[n, m, p] = size(Data);
newData = zeros(n, m, p);
newData(1, :, :) = Data(1, :, :);
newData(n, :, :) = Data(n, :, :);
newData(:, 1, :) = Data(:, 1, :);
newData(:, n, :) = Data(:, n, :);

for i = 2 : n - 1
    for j = 2 : m - 1
        if Equal(MapData(i, j, :), [0, 0, 0])
            continue;
        else
            newData(i, j, :) = Evolute(i, j, MapData, Data, lambda);
        end
    end
end
end