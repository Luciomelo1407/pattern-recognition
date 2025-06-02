data = load('sinteticos1.txt');
x      = data(:,1);
y      = data(:,2);
labels = data(:,3);

figure;
plot(x, y, '.');
xlabel('x');
ylabel('y');
title('Scatter de todos os pontos');

figure; hold on;
idx0 = (labels == 0);
idx1 = (labels == 1);
plot(x(idx0), y(idx0), 'ro', 'MarkerFaceColor','r');   % classe 0 em vermelho
plot(x(idx1), y(idx1), 'b+', 'MarkerSize', 8);          % classe 1 em azul
hold off;
xlabel('x'); ylabel('y');
legend('Classe 0','Classe 1','Location','best');
title('Scatter por classe');

figure;
gscatter(x, y, labels, 'rb', 'o+');
xlabel('x'); ylabel('y');
title('Scatter por classe');

print('scatter_dataset.png','-dpng');