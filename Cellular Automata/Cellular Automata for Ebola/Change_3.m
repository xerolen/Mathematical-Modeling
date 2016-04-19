function result = Change_3(area, i, j, range)
% Change of state 3
death = 0.001; %the probability of I/Q to death
result = 3;
gamma1 = 0.0005; %the probability of I to R (nature)
r = rand;
if r < gamma1
    result = 5;
else
    death = death * SumofNei(area, i, j, 3, range);
    if r > gamma1 && r < gamma1 + death
        result = 1;
    end
end
end

