%%%%%%%%%%%%% cellular automaton %%%%%%%%%%%%%%
clear
clc
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MapData = imread('shanxi.png');
n = length(MapData);
T = 10;     % iteration
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

Display(StaData);
