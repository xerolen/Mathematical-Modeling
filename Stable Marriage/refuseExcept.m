function [ Refuse ] = refuseExcept(pos, CrushOn, Refuse)
%refuseExcept 
n = length(CrushOn);
for i = 1 : n
    if i ~= pos && CrushOn(i) == 1
        Refuse(i) = 1;
    end
end

end

