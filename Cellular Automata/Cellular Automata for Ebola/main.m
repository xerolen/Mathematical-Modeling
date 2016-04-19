%%%%%%%%%%%%% cellular automaton %%%%%%%%%%%%%%
clear
clc
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
total_drug = 20;
length = 100;
T = 30;
Ti = 3;
range = 3;
thre = 6;
% epsilon %the probability of E to I
% gamma1  %the probability of I to R (nature)
% gamma2  %the probability of Q to R (nature)
% rho  %the probability of S to R
% delta  %the probability of I to Q
% eta  %the probability of Q to R
% death  %the probability of I/Q to death
% 0 : black
% 1 : normal
% 2 : station
% 3 : disease
% 4 : isolated
% 5 : recover
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
area = Create(length);
Draw_area(area);
figure;
[area, drug] = BuildStation(area, total_drug, range, thre);
Draw_area(area);
figure;
data = zeros(5,T);
for i = 1 : T
    area = Change_area(area, drug);
    Draw_area(area);
    drawnow;
    data(:, i) = Statistics(area);
end
% data = Statistics(area);
% Display(data);
Plot_data(data, T);
for j = 1 : Ti
    area = Change_Renew(area, total_drug, range, thre);
    figure;
    Draw_area(area);
    for i = 1 : T
        area = Change_area(area, drug);
        Draw_area(area);
        drawnow;
        data(:,i) = Statistics(area);
    end
%     data = Statistics(area);
%     Display(data);
    Plot_data(data, T);
end
% data(5,T) / (data(3,T) + data(4,T))