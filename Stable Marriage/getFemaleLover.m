function [ index ] = getFemaleLover(FemaleScore, CrushOn, Single)
%getFemaleLover 
tmp = 0;
index = -1;
n = length(FemaleScore);
for i = 1 : n
    if tmp < FemaleScore(i) && CrushOn(i) == 1 && Single(i) == 1
        tmp = FemaleScore(i);
        index = i;
    end
end

end

