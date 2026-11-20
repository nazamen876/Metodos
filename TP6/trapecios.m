function I = trapecios(x, y)
  % INTEGRACION NUMERICA POR LA REGLA DE LOS TRAPECIOS COMPUESTA
  %
  % Parametros:
  %   x: vector de nodos equiespaciados
  %   y: vector de ordenadas f(x)
  %
  % Retorna:
  %   I: aproximacion de la integral definida

  n = length(x) - 1;   % Cantidad de subintervalos
  if n < 1
    error('Se necesitan al menos 2 puntos para aplicar Trapecios.');
  endif

  h = (x(end) - x(1)) / n;

  printf('======================================================================\n');
  printf('         INTEGRACION NUMERICA: REGLA DE LOS TRAPECIOS\n');
  printf('======================================================================\n\n');
  printf('  Intervalo de integracion: [%.6f, %.6f]\n', x(1), x(end));
  printf('  Subintervalos (n)        = %d\n', n);
  printf('  Paso (h)                 = %.6f\n\n', h);

  % Formula compuesta:
  % I = (h/2) * [y0 + 2*y1 + 2*y2 + ... + 2*y_{n-1} + yn]

  extremos = y(1) + y(end);
  interiores = sum(y(2:end-1));

  I = (h / 2) * (extremos + 2 * interiores);

  printf('  Puntos y ponderaciones:\n');
  printf('    x(0) = %10.5f | y(0) = %12.6f (peso 1)\n', x(1), y(1));
  for i = 2:length(x)-1
    printf('    x(%d) = %10.5f | y(%d) = %12.6f (peso 2)\n', i-1, x(i), i-1, y(i));
  endfor
  printf('    x(%d) = %10.5f | y(%d) = %12.6f (peso 1)\n\n', n, x(end), n, y(end));

  printf('  Calculo:\n');
  printf('    Suma extremos (y0 + yn)       = %12.6f\n', extremos);
  printf('    Suma interiores (sum y_i)     = %12.6f\n', interiores);
  printf('    Suma ponderada                = %12.6f\n', extremos + 2 * interiores);
  printf('    I = (%.6f / 2) * (%.6f)      = %12.6f\n', h, extremos + 2*interiores, I);
  printf('======================================================================\n\n');

endfunction
