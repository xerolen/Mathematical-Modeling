function [Sta] = DrawArea(MapData, Data, range)
% Display the area's situation
n = length(Data);
temp = zeros(n, n);
Sta = zeros(1, 3);
total = 0;
for i = 1 : n
    for j = 1 : n
        temp(i, j) = Data(i, j, 1)*0.0007 + Data(i, j, 2)*0.16 + Data(i, j, 3)*0.0026;
    end
end

[n, m] = size(temp);

Area(:, :, 1) = temp;
Area(:, :, 2) = temp;
Area(:, :, 3) = temp;

for i = 1 : n
    for j = 1 : m
        if Equal(MapData(i, j, :), [0 0 0])
            Area(i, j, :) = [0 0 0];
            continue;
        end
        total = total + 1;
        if temp(i, j) <= range(1)
            Area(i, j, :) = [238 173 14];
            Sta(1) = Sta(1) + 1;
        elseif temp(i, j) <= range(2)
            Area(i, j, :) = [175 238 238];
            Sta(2) = Sta(2) + 1;
        else
            Area(i, j, :) = [0 206 209];
            Sta(3) = Sta(3) + 1;
        end
    end
end

Sta = Sta / total;

Area = uint8(Area);
   p = imagesc(Area); 
   hold on;
   plot([(0 : 2 : m)',(0 : 2 : m)']+0.5, [0, n]+0.5,'k');
   plot([0, m]+0.5, [(0 : 2 : n)',(0 : 2 : n)']+0.5,'k');
   axis image;
   set(gca,'xtick',[]);
   set(gca,'ytick',[]);
end