function I = simpson38(x, y)
  % INTEGRACION NUMERICA POR LA REGLA DE SIMPSON 3/8 COMPUESTA
  %
  % Parametros:
  %   x: vector de nodos equiespaciados
  %   y: vector de ordenadas f(x)
  %
  % Retorna:
  %   I: aproximacion de la integral definida

  n = length(x) - 1;   % Cantidad de subintervalos
  if n < 3
    error('Simpson 3/8 requiere al menos 3 subintervalos (4 puntos).');
  endif

  if mod(n, 3) != 0
    error('Simpson 3/8 requiere que la cantidad de subintervalos sea MULTIPLO DE 3 (n = %d).', n);
  endif

  h = (x(end) - x(1)) / n;

  printf('======================================================================\n');
  printf('        INTEGRACION NUMERICA: REGLA DE SIMPSON 3/8 (COMPUESTA)\n');
  printf('======================================================================\n\n');
  printf('  Intervalo de integracion: [%.6f, %.6f]\n', x(1), x(end));
  printf('  Subintervalos (n)        = %d (Multiplo de 3 - Valido para Simpson 3/8)\n', n);
  printf('  Paso (h)                 = %.6f\n\n', h);

  % Formula:
  % I = (3h/8) * [y0 + 3*y1 + 3*y2 + 2*y3 + 3*y4 + 3*y5 + 2*y6 + ... + yn]
  extremos = y(1) + y(end);
  suma_pond = extremos;

  printf('  Puntos y ponderaciones:\n');
  printf('    x(0) = %10.5f | y(0) = %12.6f (peso 1)\n', x(1), y(1));

  sum3 = 0;
  sum2 = 0;
  for i = 2:length(x)-1
    sub_idx = i - 1;
    if mod(sub_idx, 3) == 0
      peso = 2;
      sum2 = sum2 + y(i);
    else
      peso = 3;
      sum3 = sum3 + y(i);
    endif
    suma_pond = suma_pond + peso * y(i);
    printf('    x(%d) = %10.5f | y(%d) = %12.6f (peso %d)\n', sub_idx, x(i), sub_idx, y(i), peso);
  endfor
  printf('    x(%d) = %10.5f | y(%d) = %12.6f (peso 1)\n\n', n, x(end), n, y(end));

  I = (3 * h / 8) * suma_pond;

  printf('  Calculo:\n');
  printf('    Extremos (y0 + yn)            = %12.6f\n', extremos);
  printf('    3 * Suma no multiplos de 3    = %12.6f (suma = %.6f)\n', 3 * sum3, sum3);
  printf('    2 * Suma multiplos de 3       = %12.6f (suma = %.6f)\n', 2 * sum2, sum2);
  printf('    Suma ponderada total          = %12.6f\n', suma_pond);
  printf('    I = (3 * %.6f / 8) * (%.6f) = %12.6f\n', h, suma_pond, I);
  printf('======================================================================\n\n');

endfunction
