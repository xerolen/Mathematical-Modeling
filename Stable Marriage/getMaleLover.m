function [ index ] = getMaleLover(MaleScore, Refuse)
% getMaleLover
% get the index of lover (highest score)
index = -1;
tmp = 0;
n = length(MaleScore);
for i = 1 : n
    if tmp < MaleScore(i) && Refuse(i) == 0
        tmp = MaleScore(i);
        index = i;
    end
end
if index == -1
    index = randi([1, n]);
end
