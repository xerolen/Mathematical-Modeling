function [ center ] = updateCenter( data, label, k )
% updateCenter(data, label, k)
% update the center of k-means

center = zeros(k, size(data, 2));

for i = 1 : k
    center(i, :) = mean(data(label == i, :));
end

end

