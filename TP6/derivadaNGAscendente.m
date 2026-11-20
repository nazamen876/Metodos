function [df1, df2] = derivadaNGAscendente(x_val, x, y)
  % DERIVADA POR FORMULA DE NEWTON-GREGORY ASCENDENTE (HACIA ADELANTE)
  %
  % Parametros:
  %   x_val: punto donde se desea calcular la derivada
  %   x: vector de nodos equiespaciados
  %   y: vector de valores funcionales f(x)
  %
  % Retorna:
  %   df1: aproximacion de la primera derivada f'(x_val)
  %   df2: aproximacion de la segunda derivada f''(x_val)

  n = length(x);
  h = x(2) - x(1);

  % Obtener tabla de diferencias
  D = tablaDiferencias(x, y);

  % Elegir nodo inicial x0 (el nodo mas cercano anterior o igual a x_val)
  idx = find(x <= x_val, 1, 'last');
  if isempty(idx)
    idx = 1;
  endif
  % Asegurar que no sea el ultimo para tener diferencias hacia adelante
  if idx >= n
    idx = n - 1;
  endif

  x0 = x(idx);
  u = (x_val - x0) / h;

  printf('======================================================================\n');
  printf('       DERIVACION: NEWTON-GREGORY ASCENDENTE (HACIA ADELANTE)\n');
  printf('======================================================================\n\n');
  printf('  Punto a evaluar: x = %.6f\n', x_val);
  printf('  Paso h          = %.6f\n', h);
  printf('  Nodo base x0    = %.6f (indice %d)\n', x0, idx);
  printf('  Parametro u     = (x - x0) / h = %.6f\n\n', u);

  % Diferencias disponibles a partir de la fila idx
  dif_disp = n - idx;
  deltas = zeros(1, dif_disp);
  for k = 1:dif_disp
    deltas(k) = D(idx, k+1);
  endfor

  printf('  Diferencias finitas a partir de x0:\n');
  for k = 1:dif_disp
    printf('    Delta^%d y0 = %12.6f\n', k, deltas(k));
  endfor
  printf('\n');

  % Primera derivada:
  % Si u == 0: f'(x0) = (1/h) * [Delta y0 - 1/2 Delta^2 y0 + 1/3 Delta^3 y0 - 1/4 Delta^4 y0 + ...]
  % Si u != 0: se derivan los factores (u)(u-1)(u-2)...
  % Coeficientes de P'(u) para primeros terminos:
  % orden 1: Delta y0
  % orden 2: (2u - 1) / 2 * Delta^2 y0
  % orden 3: (3u^2 - 6u + 2) / 6 * Delta^3 y0
  % orden 4: (4u^3 - 18u^2 + 22u - 6) / 24 * Delta^4 y0
  % orden 5: (5u^4 - 40u^3 + 105u^2 - 100u + 24) / 120 * Delta^5 y0

  terminos_df1 = zeros(1, dif_disp);
  if dif_disp >= 1
    terminos_df1(1) = deltas(1);
  endif
  if dif_disp >= 2
    terminos_df1(2) = ((2*u - 1) / 2) * deltas(2);
  endif
  if dif_disp >= 3
    terminos_df1(3) = ((3*u^2 - 6*u + 2) / 6) * deltas(3);
  endif
  if dif_disp >= 4
    terminos_df1(4) = ((4*u^3 - 18*u^2 + 22*u - 6) / 24) * deltas(4);
  endif
  if dif_disp >= 5
    terminos_df1(5) = ((5*u^4 - 40*u^3 + 105*u^2 - 100*u + 24) / 120) * deltas(5);
  endif

  suma1 = sum(terminos_df1);
  df1 = (1 / h) * suma1;

  printf('  Calculo de la PRIMERA DERIVADA f''(%.4f):\n', x_val);
  for k = 1:dif_disp
    printf('    Termino orden %d: %12.6f\n', k, terminos_df1(k));
  endfor
  printf('    -----------------------------------------\n');
  printf('    Suma de terminos = %12.6f\n', suma1);
  printf('    f''(%.4f) = (1 / %.4f) * (%.6f) = %12.6f\n\n', x_val, h, suma1, df1);

  % Segunda derivada:
  % f''(x) = (1/h^2) * P''(u)
  % orden 2: Delta^2 y0
  % orden 3: (u - 1) * Delta^3 y0
  % orden 4: (12u^2 - 36u + 22) / 24 * Delta^4 y0 = (6u^2 - 18u + 11)/12 * Delta^4 y0
  % orden 5: (20u^3 - 120u^2 + 210u - 100) / 120 * Delta^5 y0

  terminos_df2 = zeros(1, dif_disp);
  if dif_disp >= 2
    terminos_df2(2) = deltas(2);
  endif
  if dif_disp >= 3
    terminos_df2(3) = (u - 1) * deltas(3);
  endif
  if dif_disp >= 4
    terminos_df2(4) = ((6*u^2 - 18*u + 11) / 12) * deltas(4);
  endif
  if dif_disp >= 5
    terminos_df2(5) = ((20*u^3 - 120*u^2 + 210*u - 100) / 120) * deltas(5);
  endif

  suma2 = sum(terminos_df2);
  df2 = (1 / (h^2)) * suma2;

  printf('  Calculo de la SEGUNDA DERIVADA f''''(%.4f):\n', x_val);
  for k = 2:dif_disp
    printf('    Termino orden %d: %12.6f\n', k, terminos_df2(k));
  endfor
  printf('    -----------------------------------------\n');
  printf('    Suma de terminos = %12.6f\n', suma2);
  printf('    f''''(%.4f) = (1 / %.4f^2) * (%.6f) = %12.6f\n', x_val, h, suma2, df2);
  printf('======================================================================\n\n');

endfunction
