function area = Change_area(area, drug)
%Change_area 
%%%%%%%%%%%%%%%%%%%%%% explanation %%%%%%%%%%%%%%%%%%%%%%%
% 0 : black
% 1 : normal
% 2 : station
% 3 : disease
% 4 : isolated
% 5 : recover
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[L, W] = size(area);
range = 3;
for i = range + 1 : L - range
    for j = range + 1 : W - range
        if area(i, j) == 2
            area(i, j) = 2;
            area = Change_2(area, i, j, range, drug);
        end
    end
end
for i = range + 1 : L - range
    for j = range + 1 : W - range
        if area(i, j) == 1
            area(i, j) = Change_1(area, i, j, range);
        elseif area(i, j) == 3
            area(i, j) = Change_3(area, i, j, range);
        elseif area(i, j) == 4
            area(i, j) = Change_4();
        end
    end
end
end