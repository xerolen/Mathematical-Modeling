function area = Create( length )
%UNTITLED3 create an area
area = zeros(length);
for i = 1: length
    for j = 1: length
        if i > j
            area(i, j) = 0;
        elseif i < 4 || j > length - 4
            area(i, j) = 0;
        elseif j > round(0.8*length) || j <= round(length/4)
            area(i, j) = 1;
        elseif j > round(length/4) && j < round(length/2) && i < round(length/2)-j
            area(i, j) = 1;
        else
            s = rand;
            if i > round(0.4*length) && i < round(0.6*length) && j >round(0.4*length) && j <round(0.6*length)
                if s < 0.5
                    area(i, j) = 1;
                else
                    area(i, j) = 3;
                end
            else
                if s < 0.9
                    area(i, j) = 1;
                else
                    area(i, j) = 3;
                end
            end
        end
    end
end
data = Statistics(area);
disp('In the beginning:');
Display(data);
end

