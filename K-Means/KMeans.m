function [label] = KMeans(data, k)
% k-Means clustering
% @Author: Moming
% 2015-05-07

n = size(data, 1);

if k > n
    warning('k must be smaller than data"s row.')
    return;
end


index = randperm(n, k);
center = data(index, :);
dist = getDistance(data, center, k);
[~, label] = min(dist');

while true
    center = updateCenter(data, label, k);
    dist = getDistance(data, center, k);
    [~, newLabel] = min(dist');
    if isequal(label, newLabel)
        break;
    else
        label = newLabel;
    end
end

end