function area = Change_2(area, i, j, range, drug)
% Change of state 2
eta = 0.025; %the probability of Q to R
death = 0.001; %the probability of I/Q to death
for x = i - range : i + range
    for y = j - range : j + range
        if area(x, y) == 3
            area(x, y) = 4;
        elseif area(x, y) == 4
            r = rand;
            dist = Distance(i, j, x, y);
            if drug >= 1
                if r < (eta + death) / dist
                    area(x, y) = 5;
                end
            else
                if r < drug * (eta + death) / dist
                    area(x, y) = 5;
                end
            end
        end
    end
end

end

