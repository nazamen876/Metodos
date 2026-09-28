function graficar_raices(f, a, b)
  % f: function handle (usar .* y .^ adentro)
  % [a b]: intervalo donde se grafica
  figure;
  fplot(f, [a b], 'b-');
  hold on;
  plot([a b], [0 0], 'k--');   % eje y = 0
  grid on;
  xlabel('x');
  ylabel('f(x)');
  title('Búsqueda gráfica de raíces');
  hold off;
end
