function [df1, df2] = derivadaNGDescendente(x_val, x, y)
  % DERIVADA POR FORMULA DE NEWTON-GREGORY DESCENDENTE (HACIA ATRAS)
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

  % Construir tabla de diferencias
  D = tablaDiferencias(x, y);

  % Elegir nodo base x_n (el nodo mas cercano posterior o igual a x_val)
  idx = find(x >= x_val, 1, 'first');
  if isempty(idx)
    idx = n;
  endif
  if idx < 2
    idx = 2;
  endif

  xn = x(idx);
  u = (x_val - xn) / h;

  printf('======================================================================\n');
  printf('       DERIVACION: NEWTON-GREGORY DESCENDENTE (HACIA ATRAS)\n');
  printf('======================================================================\n\n');
  printf('  Punto a evaluar: x = %.6f\n', x_val);
  printf('  Paso h          = %.6f\n', h);
  printf('  Nodo base xn    = %.6f (indice %d)\n', xn, idx);
  printf('  Parametro u     = (x - xn) / h = %.6f\n\n', u);

  % Diferencias regresivas (hacia atras) terminando en fila idx
  % En la tabla de diferencias avanzadas D:
  % nabla^k y(idx) = D(idx - k, k + 1)
  dif_disp = idx - 1;
  nablas = zeros(1, dif_disp);
  for k = 1:dif_disp
    nablas(k) = D(idx - k, k + 1);
  endfor

  printf('  Diferencias regresivas (nabla^k y_n):\n');
  for k = 1:dif_disp
    printf('    nabla^%d y_n = %12.6f\n', k, nablas(k));
  endfor
  printf('\n');

  % Primera derivada:
  % P(u) = yn + u*nabla yn + u(u+1)/2! nabla^2 yn + u(u+1)(u+2)/3! nabla^3 yn + ...
  % Derivadas de los coeficientes respecto de u:
  % orden 1: nabla yn
  % orden 2: (2u + 1) / 2 * nabla^2 yn
  % orden 3: (3u^2 + 6u + 2) / 6 * nabla^3 yn
  % orden 4: (4u^3 + 18u^2 + 22u + 6) / 24 * nabla^4 yn
  % orden 5: (5u^4 + 40u^3 + 105u^2 + 100u + 24) / 120 * nabla^5 yn

  terminos_df1 = zeros(1, dif_disp);
  if dif_disp >= 1
    terminos_df1(1) = nablas(1);
  endif
  if dif_disp >= 2
    terminos_df1(2) = ((2*u + 1) / 2) * nablas(2);
  endif
  if dif_disp >= 3
    terminos_df1(3) = ((3*u^2 + 6*u + 2) / 6) * nablas(3);
  endif
  if dif_disp >= 4
    terminos_df1(4) = ((4*u^3 + 18*u^2 + 22*u + 6) / 24) * nablas(4);
  endif
  if dif_disp >= 5
    terminos_df1(5) = ((5*u^4 + 40*u^3 + 105*u^2 + 100*u + 24) / 120) * nablas(5);
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
  % orden 2: nabla^2 yn
  % orden 3: (u + 1) * nabla^3 yn
  % orden 4: (6u^2 + 18u + 11) / 12 * nabla^4 yn
  % orden 5: (20u^3 + 120u^2 + 210u + 100) / 120 * nabla^5 yn

  terminos_df2 = zeros(1, dif_disp);
  if dif_disp >= 2
    terminos_df2(2) = nablas(2);
  endif
  if dif_disp >= 3
    terminos_df2(3) = (u + 1) * nablas(3);
  endif
  if dif_disp >= 4
    terminos_df2(4) = ((6*u^2 + 18*u + 11) / 12) * nablas(4);
  endif
  if dif_disp >= 5
    terminos_df2(5) = ((20*u^3 + 120*u^2 + 210*u + 100) / 120) * nablas(5);
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
