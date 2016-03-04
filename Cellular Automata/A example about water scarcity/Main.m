%%%%%%%%%%%%% cellular automaton %%%%%%%%%%%%%%
clear
clc
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MapData = imread('shanxi.png');
n = length(MapData);
T = 10;
NumOfVar = 3;
range = [0.35 0.52];
% lambda = [1.1 1.15 1.002];
lambda = [1.075 1.075 1.0015];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data = Create(n, NumOfVar, MapData);
DrawArea(MapData, Data, range);
figure;
StaData = zeros(T, 3);
for i = 1 : T
    Data = ChangeArea(Data, MapData, lambda);
    StaData(i, :) = DrawArea(MapData, Data, range);
%     pause();
    drawnow;
end
figure;
x = 1 : T;
hold on;
plot(x, StaData(:,1), 'Color', [0.933, 0.678, 0.055], 'LineWidth', 3);
plot(x, StaData(:,2), 'Color', [0.678, 0.933, 0.933], 'LineWidth', 3);
plot(x, StaData(:,3), 'Color', [0.000, 0.812, 0.812], 'LineWidth', 3);
xlabel('year');
ylabel('ratio');
legend('Over-exploited','Moderately exploited','Normal');
title('Trend');
grid on;