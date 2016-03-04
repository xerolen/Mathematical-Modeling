function result = Evolute(p, q, MapData, Data, lambda)
%Evolution
Shaanxi = [192 192 192];
Neimenggu = [113 200 49];
Ningxia = [172 77 77];
Gansu = [255 255 0];
Shanxi = [255 51 0];
Henan = [0 128 255];
Sichuan = [0 255 255];
Chongqing = [255 102 102];
Hubei = [255 153 0];

ShaanxiCorr = [0.0003 0.0003 0.0003];
NeimengguCorr = [0.532734893	0.601215033	0.910747354];
NingxiaCorr = [-0.594007473	0.775016712	0.940139908];
GansuCorr = [0.156311975	0.004425158	0.973632377];
ShanxiCorr = [0.863813518	0.256272409	0.921696396];
HenanCorr = [-0.951717589	-0.144666358	-0.953091616];
SichuanCorr = [0.814598682	0.072527645	0.937148138];
ChongqingCorr = [0.811095178	0.165459698	0.952459152];
HubeiCorr = [0.929455206	-0.362916622	0.946140193];

result = 0.1 * [Data(p, q, 1) Data(p, q, 2) Data(p, q, 3)];
center = [Data(60, 70, 1) Data(60, 70, 2) Data(60, 70, 3)];

for i = p - 1 : p + 1
    for j = q - 1 : q + 1
        for k = 1 : 3
            if Equal(MapData(i, j, :), [0 0 0])
                result(k) = result(k) + 0.1 * Data(p, q, k);
            else
                result(k) = result(k) + 0.1 * Data(i, j, k);
            end
        end
    end
end

result = result .* lambda;
mu = 0.1 / (sqrt((60 - p)^2 + (70 - q)^2) + 1);

if Equal(MapData(i, j, :), Neimenggu) 
    result = result + mu * NeimengguCorr .* center;
elseif Equal(MapData(i, j, :), Ningxia) 
    result = result + mu * NingxiaCorr .* center;
elseif Equal(MapData(i, j, :), Gansu) 
    result = result + mu * GansuCorr .* center;
elseif Equal(MapData(i, j, :), Shanxi) 
    result = result + mu * ShanxiCorr .* center;
elseif Equal(MapData(i, j, :), Henan) 
    result = result + mu * HenanCorr .* center;
elseif Equal(MapData(i, j, :), Sichuan) 
    result = result + mu * SichuanCorr .* center;
elseif Equal(MapData(i, j, :), Chongqing) 
    result = result + mu * ChongqingCorr .* center;
elseif Equal(MapData(i, j, :), Hubei) 
    result = result + mu * HubeiCorr .* center;
elseif Equal(MapData(i, j, :), Shaanxi) 
    result = result + mu * ShaanxiCorr .* center;
end

end