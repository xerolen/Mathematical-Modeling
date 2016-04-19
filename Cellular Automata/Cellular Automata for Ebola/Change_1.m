function result = Change_1(area, i, j, range)
% Change of state 1
result = 1;
epsilon = 0.005; %the probability of E to I
eta = 0.01; %the probability of Q to R
sum3 = SumofNei (area, i, j, 3, 1);
sum2 = SumofNei (area, i, j, 2, range);
if sum3 == 0 
    result = 1;
elseif sum2 == 0
    r = rand;
    if r < epsilon
        result = 3;
    end
else
    dis_2 = Nearest(area, i, j, 2, range);
    r = rand;
    if r < epsilon - eta / dis_2
        result = 3;
    end
end
    
end

