function [] = Display(StaData)
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
end
