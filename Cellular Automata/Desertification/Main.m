%%%%%%%%%%%%% cellular automaton
clear
clc
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load data;%lunmu/kaiken/guomu
data = guomu;
T = 30;
Sit = 3;% number of situation
range = [0.3918, 0.7629];
lambda = [1 1];
human = 0.001 * lambda(1);
plant = 0.0005 * lambda(2);
weight = [0.01 - human + plant, 0.92 - human + plant];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[area, Data] = Create(data);
Draw_area(area, range);
figure;
sta_data = zeros(T, Sit);
for i = 1 : T
    area = Change_area(area, weight);
    Draw_area(area, range);
    drawnow;
    sta_data(i, :) = Statistics(area, Sit, range);
end
Display(sta_data);
