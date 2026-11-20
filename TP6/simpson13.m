function I = simpson13(x, y)
  % INTEGRACION NUMERICA POR LA REGLA DE SIMPSON 1/3 COMPUESTA
  %
  % Parametros:
  %   x: vector de nodos equiespaciados
  %   y: vector de ordenadas f(x)
  %
  % Retorna:
  %   I: aproximacion de la integral definida

  n = length(x) - 1;   % Cantidad de subintervalos
  if n < 2
    error('Simpson 1/3 requiere al menos 2 subintervalos (3 puntos).');
  endif

  if mod(n, 2) != 0
    error('Simpson 1/3 requiere una cantidad PAR de subintervalos (n = %d es impar).', n);
  endif

  h = (x(end) - x(1)) / n;

  printf('======================================================================\n');
  printf('        INTEGRACION NUMERICA: REGLA DE SIMPSON 1/3 (COMPUESTA)\n');
  printf('======================================================================\n\n');
  printf('  Intervalo de integracion: [%.6f, %.6f]\n', x(1), x(end));
  printf('  Subintervalos (n)        = %d (PAR - Valido para Simpson 1/3)\n', n);
  printf('  Paso (h)                 = %.6f\n\n', h);

  % Formula:
  % I = (h/3) * [y0 + 4*sum(y_impares) + 2*sum(y_pares) + yn]
  extremos = y(1) + y(end);
  impares = sum(y(2:2:end-1));    % Indices Octave pares corresponden a subindices impares 1, 3, 5...
  pares   = sum(y(3:2:end-2));    % Indices Octave impares corresponden a subindices pares 2, 4, 6...

  I = (h / 3) * (extremos + 4 * impares + 2 * pares);

  printf('  Puntos y ponderaciones:\n');
  printf('    x(0) = %10.5f | y(0) = %12.6f (peso 1)\n', x(1), y(1));
  for i = 2:length(x)-1
    sub_idx = i - 1;
    if mod(sub_idx, 2) != 0
      peso = 4;
    else
      peso = 2;
    endif
    printf('    x(%d) = %10.5f | y(%d) = %12.6f (peso %d)\n', sub_idx, x(i), sub_idx, y(i), peso);
  endfor
  printf('    x(%d) = %10.5f | y(%d) = %12.6f (peso 1)\n\n', n, x(end), n, y(end));

  printf('  Calculo:\n');
  printf('    Extremos (y0 + yn)            = %12.6f\n', extremos);
  printf('    4 * Suma impares              = %12.6f (suma = %.6f)\n', 4 * impares, impares);
  printf('    2 * Suma pares                = %12.6f (suma = %.6f)\n', 2 * pares, pares);
  suma_pond = extremos + 4 * impares + 2 * pares;
  printf('    Suma ponderada total          = %12.6f\n', suma_pond);
  printf('    I = (%.6f / 3) * (%.6f)      = %12.6f\n', h, suma_pond, I);
  printf('======================================================================\n\n');

endfunction
