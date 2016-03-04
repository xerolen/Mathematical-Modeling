function [Data] = Create(n, num, MapData)
% Create origin system
Shaanxi = [192 192 192];
Neimenggu = [113 200 49];
Ningxia = [172 77 77];
Gansu = [255 255 0];
Shanxi = [255 51 0];
Henan = [0 128 255];
Sichuan = [0 255 255];
Chongqing = [255 102 102];
Hubei = [255 153 0];

% ShaanxiData = [55.16 1.07 28.83];
% NeimengguData = [89.06 2.91 11.56];
% NingxiaData = [64.67 0.67 3.28];
% GansuData = [90.9 0.56 6.93];
% ShanxiData = [32.77 0.7 20.55];
% HenanData = [59.25 0.68 17.5];
% SichuanData = [217.91 1.67 38.62];
% ChongqingData = [78.87 0.7 19.72];
% HubeiData = [279.1 3.82 39.31];
ShaanxiData = [41.93 0.74 19.57];
NeimengguData = [85.7 2.26 7.01];
NingxiaData = [68.68 0.15 1.37];
GansuData = [93.2 0.37 6.42];
ShanxiData = [20.41 0.8 15.75];
HenanData = [80.38 0.47 31.26];
SichuanData = [195.17 2.42 21.52];
ChongqingData = [65.48 0.24 9.99];
HubeiData = [233.81 2.01 29.57];

Data = zeros(n, n, num);
mu = 0.3;
for k = 1 : num
    for i = 1 : n
        for j = 1 : n
            if Equal(MapData(i, j, :), Shaanxi) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * ShaanxiData(k);
            elseif Equal(MapData(i, j, :), Neimenggu) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * NeimengguData(k);
            elseif Equal(MapData(i, j, :), Ningxia) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * NingxiaData(k);
            elseif Equal(MapData(i, j, :), Gansu) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * GansuData(k);
            elseif Equal(MapData(i, j, :), Shanxi) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * ShanxiData(k);
            elseif Equal(MapData(i, j, :), Henan) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * HenanData(k);
            elseif Equal(MapData(i, j, :), Sichuan) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * SichuanData(k);
            elseif Equal(MapData(i, j, :), Chongqing) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * ChongqingData(k);
            elseif Equal(MapData(i, j, :), Hubei) 
                Data(i, j, k) = (1 + unifrnd(-mu, mu, 1, 1)) * HubeiData(k);
            end
        end
    end
end
end