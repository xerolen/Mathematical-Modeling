function [area, drug] = BuildStation(area, total_drug, range, thre)
%build station to cure patients
[L, W] = size(area);
data = area;
threshold = ((range * 2 + 1)^2 - 1) / thre;
sum = zeros(L, W);
NumOfSta = 0;
for i = range + 1 : L - range
    for j = range + 1 : W - range
        sum(i, j) = SumofNei(data, i, j, 3, range);
        if  sum(i, j) >= threshold
            data = Clear_dis(data, i, j, 3, range);
            area(i, j) = 2;
            NumOfSta = NumOfSta + 1;
            RedOfSta(NumOfSta) = sum (i, j);
        end
    end
end
drug = total_drug / NumOfSta;
data_s = Statistics(area);
disp('After building station:');
Display(data_s);
disp('The disease area of each station:');
disp(RedOfSta);
disp('The number of drug:');
disp(drug);
disp('----------------------------------------------------');
end

