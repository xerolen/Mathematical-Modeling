function Plot_data(data, T)
%plot a graph
x = 1 : T;
figure;
hold on;
y3 = plot (x, data(3, :), 'rx');
y4 = plot (x, data(4, :), 'co');
y5 = plot (x, data(5, :), 'b+');
legend([y3 y4 y5],'symptomatic','isolated','recovered');
end

