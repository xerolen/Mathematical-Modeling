function [area, drug] = Change_Renew(area, total_drug, range, thre)
%change the position of stations
[L, W] = size(area);
data = area;
threshold = ((range * 2 + 1)^2 - 1) / thre;
sum = zeros(L, W);
NumOfSta = 0;
for i = range + 1 : L - range
    for j = range + 1 : W - range
        if data(i, j) == 2
            area(i, j) = 5;
            data(i, j) = 5;
        end
        if data(i, j) == 4
            area(i, j) = 3;
            data(i, j) = 3;
        end
        sum(i, j) = SumofNei(data, i, j, 3, range) + SumofNei(data, i, j, 4, range);
        if  sum(i, j) >= threshold
            data = Clear_dis(data, i, j, 3, range);
            data = Clear_dis(data, i, j, 4, range);
            area(i, j) = 2;
            NumOfSta = NumOfSta + 1;
            RedOfSta(NumOfSta) = sum (i, j);
        end
    end
end
drug = total_drug / NumOfSta;
data_s = Statistics(area);
disp('After Change_Renew:');
Display(data_s);
disp('The disease area of each station:');
disp(RedOfSta);
disp('The number of drug:');
disp(drug);
disp('----------------------------------------------------');
end

