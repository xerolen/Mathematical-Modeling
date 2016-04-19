function Display(data)
% 1 : normal
% 2 : station
% 3 : disease
% 4 : isolated
% 5 : recover
str = {'normal','station','disease','isolated','recover'};
for i = 1 : 5
    disp([char(str(i)),char(':'),num2str(data(i))]);
end
disp('----------------------------------------------------');
end