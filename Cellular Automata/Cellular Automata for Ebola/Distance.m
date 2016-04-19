function distance = Distance(x1, y1, x2, y2)
%distance of the points
dis1 = abs(x1 - x2);
dis2 = abs(y1 - y2);
if dis1 > dis2
    distance = dis1;
else
    distance = dis2;
end

end

