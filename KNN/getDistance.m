function [ dist ] = getDistance( data, center, k )
% getDistance( data, center, k )
% get the distance

n = size(data, 1);
dist = zeros(n, k);

for i = 1 : n
    for j = 1: k
        % calculate the distance (Euclidean distance)
        dist(i, j) = sqrt(sum( ( center(j, :) - data(i, :) ).^2 ));
    end
end

end

