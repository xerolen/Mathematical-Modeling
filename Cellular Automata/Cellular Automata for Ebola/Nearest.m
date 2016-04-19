function distance = Nearest(area, i, j, n, range)
distance = Inf;
dis = range + 1;
for x = i - range : i + range
    for y = j -range : j + range
        if area(x, y) == n
            if x > y
                dis = x;
            else
                dis = y;
            end
            if dis < distance 
                distance = dis;
            end
        end
    end
end

end

