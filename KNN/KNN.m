function [result] = KNN(k, train, test)
% KNN
% @Author: Moming
% 2016-05-06
% the first colume of train is the label

[m, ~] = size(test);
num = size(train, 1);
result = zeros(m, 1);
dist = zeros(m, num);

for i = 1 : m
    for j = 1 : num
        dist(i, j) = sqrt(sum( ( test(i, :) - train(j, 2 : end) ).^2 ));
    end
end

for i = 1 : m
    [~, index] = min(dist(i, :));
    result(i) = train(index, 1);
end
