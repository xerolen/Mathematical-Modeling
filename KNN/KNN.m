function [result] = KNN(k, train, test)
% KNN
% @Author: Moming
% 2016-05-06
% the first colume of train is the label

[m, ~] = size(test);
num = size(train, 1);
if k > num % k should not bigger than num
    k = num;
end
dist = zeros(m, num);
index = zeros(m, k);

for i = 1 : m
    for j = 1 : num
        % calculate the distance (Euclidean distance)
        dist(i, j) = sqrt(sum( ( test(i, :) - train(j, 2 : end) ).^2 ));
    end
end

[~, pos] = sort(dist, 2);
for i = 1 : m
    for j = 1 : k
        index(i, j) = train(pos(i, j), 1);
    end
end

% mode() will return the min one if some numbers' frequencies are the same
result = mode(index')'; 
end
