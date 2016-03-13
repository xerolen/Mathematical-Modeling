function [] = Display(sta_data)
figure;
x = 1 : T;
hold on;
plot(x, sta_data(:,1), 'Color', [0.545, 0.412, 0.078], 'LineWidth', 2);
plot(x, sta_data(:,2), 'Color', [0.596, 1, 0.596], 'LineWidth', 2) ;
plot(x, sta_data(:,3), 'Color', [0.133, 0.545, 0.133], 'LineWidth', 2);
xlabel('ʱ��');
ylabel('������');
legend('�˻�','���˻�','���˻�');
title('�������������仯����ͼ');
grid on;
end
