function raices = graficar_raices(f, a, b)
  % f: function handle (usar .* y .^ adentro)
  % [a b]: intervalo donde se grafica
  % raices: vector con las raíces aproximadas que encontró

  % --- Cálculo de raíces: cambio de signo en una grilla fina ---
  x  = linspace(a, b, 10000);
  y  = f(x);
  i  = find(y(1:end-1) .* y(2:end) < 0);
  x1 = x(i);    y1 = y(i);
  x2 = x(i+1);  y2 = y(i+1);
  raices = x1 - y1 .* (x2 - x1) ./ (y2 - y1);

  % --- Gráfico ---
  figure;
  fplot(f, [a b], 'b-');
  hold on;
  plot([a b], [0 0], 'k--');                                % eje y = 0
  plot(raices, zeros(size(raices)), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    for k = 1:numel(raices)
    text(raices(k), 0, sprintf('  x = %.2f', raices(k)), ...
         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
    endfor
  grid on;
  xlabel('x');
  ylabel('f(x)');
  title('Búsqueda gráfica de raíces');
  hold off;

  % --- Mostrar las raíces por consola ---
  printf('Raíces aproximadas (gráfico):\n');
  printf('  x = %.4f\n', raices);
end
