% 1. Definir la función cuadrática
f = @(x) 3*x.^2 + 2*x - 1;

% 2. Calcular las raíces
coeficientes = [3, 2, -1];
raices = roots(coeficientes);


% 3. Crear el dominio para el gráfico
x_valores = -2.5:0.05:2;
y_valores = f(x_valores);

% 4. Graficar
figure;
plot(x_valores, y_valores, 'b-', 'LineWidth', 2);
hold on;

% Ejes X e Y
plot([-3 3], [0 0], 'k-', 'LineWidth', 1.2);
plot([0 0], [-5 15], 'k-', 'LineWidth', 1.2);

% Marcar las raíces como puntos rojos
plot(raices, f(raices), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% Mostrar el valor numérico de cada raíz en el gráfico
for i = 1:length(raices)
    r = raices(i);
    texto_etiqueta = sprintf('  Raíz: x = %.3f', r);
    text(r, 0, texto_etiqueta, 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'r');
endfor

grid on;
title('f(x) = 3x^2 + 2x - 1 y sus raíces');
xlabel('Eje X');
ylabel('Eje Y');
legend('f(x)', 'Eje X (y=0)', 'Eje Y (x=0)', 'Raíces', 'Location', 'northeast');
hold off;
