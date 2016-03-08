function []=StableMarriage(n, m)
% Stable Marriage Problem.
% input: n couples, m scores to tolerate.

% input
if n <= 0
    warning('n should be a integer bigger than 0');
    return;
end

% init
MaleScore = randi([0, 100], n, n);
FemaleScore = randi([0, 100], n, n);
Single = ones(n, 1);
BoyFriend = -ones(n, 1);
CrushOn = zeros(n);
Refuse = zeros(n);

% compute
while max(Single) == 1
    for i = 1 : n
        if Single(i) == 1
            CrushOn(getMaleLover(MaleScore(i, :), Refuse(i, :)), i) = 1;
        end
    end
    for i = 1 : n
        pos = getFemaleLover(FemaleScore(i, :), CrushOn(i, :), Single);
        if pos == -1
            continue;
        end
        if BoyFriend(i) == -1
            BoyFriend(i) = pos;
            Single(pos) = 0;
        elseif FemaleScore(i, pos) - FemaleScore(i, BoyFriend(i)) > m
            Refuse(BoyFriend(i), i) = 1;
            Single(pos) = 0;
            Single(BoyFriend(i)) = 1;
            BoyFriend(i) = pos;
        else
            continue;
        end
        Refuse(:, i) = refuseExcept(pos, CrushOn(i, :), Refuse(:, i));
    end
end

% display
disp('-------------------------------------------------');
disp('Result of stable marriage problem: ');
disp('Females'' score in males'' eyes: ');
disp(MaleScore);
disp('Males'' score in females'' eyes: ');
disp(FemaleScore);
disp('==================== Couples ====================');
for i = 1 : n
    fprintf('Female %d (%d) with Male %d (%d)\n', i, MaleScore(BoyFriend(i), i), BoyFriend(i), FemaleScore(i, BoyFriend(i)));
end

end