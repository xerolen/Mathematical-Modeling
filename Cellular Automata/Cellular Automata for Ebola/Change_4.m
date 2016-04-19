function result = Change_4()
% Change of state 4
result = 4;
gamma2 = 0.001; %the probability of Q to R (nature)
r = rand;
if r < gamma2
    result = 5;
end
end

