function [x, M] = gauss(M, dig, mostrar_pasos)
  % ELIMINACION DE GAUSS CON PIVOTEO PARCIAL Y SUSTITUCION REGRESIVA
  %
  % Parametros:
  %   M: matriz aumentada [A | b] de dimension n x (n+1)
  %   dig (opcional): cantidad de cifras significativas (0 = precision completa)
  %   mostrar_pasos (opcional): true para imprimir detalle paso a paso (por defecto true)
  %
  % Retorna:
  %   x: vector columna solucion del sistema
  %   M: matriz aumentada en forma triangular superior final [U | c]

  if nargin < 2 || isempty(dig)
    dig = 0;                          % 0 = precisión completa
  endif
  if nargin < 3 || isempty(mostrar_pasos)
    mostrar_pasos = true;
  endif

  if dig > 0
    red = @(v) redondear(v, dig);
  else
    red = @(v) v;
  endif

  n = size(M, 1);
  ncols = size(M, 2);

  if ncols != n + 1
    error('La matriz aumentada debe ser de dimension n x (n+1).');
  endif

  M = red(M);

  % Funcion auxiliar para mostrar matriz aumentada formateada
  function imprimirMatriz(Mat, titulo)
    if ~isempty(titulo)
      printf('%s\n', titulo);
    endif
    for f = 1:size(Mat, 1)
      printf('  [ ');
      for c = 1:size(Mat, 2)-1
        printf('%10.4f ', Mat(f, c));
      endfor
      printf('| %10.4f ]\n', Mat(f, end));
    endfor
    printf('\n');
  endfunction

  if mostrar_pasos
    printf('======================================================================\n');
    printf('             METODO DE ELIMINACION DE GAUSS CON PIVOTEO\n');
    if dig > 0
      printf('             Aritmetica a %d cifras significativas\n', dig);
    else
      printf('             Precision completa de maquina\n');
    endif
    printf('======================================================================\n\n');
    imprimirMatriz(M, '--- MATRIZ AUMENTADA INICIAL [ A | b ] ---');
  endif

  % ----------------------------------------------------------------------------
  % ETAPA 1: ELIMINACION HACIA ADELANTE (TRIANGULACION)
  % ----------------------------------------------------------------------------
  for k = 1:n-1
    if mostrar_pasos
      printf('----------------------------------------------------------------------\n');
      printf('PASO %d: Columna %d\n', k, k);
    endif

    % Pivoteo parcial
    [piv_val, p] = max(abs(M(k:n, k)));
    p = p + k - 1;

    if abs(M(p, k)) < 1e-12
      error('El sistema no tiene solución única (pivote nulo o cercano a cero).');
    endif

    if p != k
      if mostrar_pasos
        printf('  * Pivoteo: El mayor elemento en col %d esta en fila %d (|%.4f|).\n', k, p, M(p, k));
        printf('    -> Intercambio de filas: Fila %d <---> Fila %d\n', k, p);
      endif
      M([k p], :) = M([p k], :);
    else
      if mostrar_pasos
        printf('  * Pivoteo: El pivote en la diagonal (Fila %d) ya es el maximo (|%.4f|).\n', k, M(k, k));
        printf('    -> No requiere intercambio de filas.\n');
      endif
    endif

    if mostrar_pasos
      printf('  * Eliminacion hacia adelante:\n');
    endif

    for i = k+1:n
      m = red(M(i, k) / M(k, k));
      M(i, :) = red(M(i, :) - red(m * M(k, :)));
      M(i, k) = 0;    % Cero teorico bajo el pivote
      if mostrar_pasos
        printf('    Fila %d = Fila %d - (%8.4f) * Fila %d\n', i, i, m, k);
      endif
    endfor

    if mostrar_pasos
      imprimirMatriz(M, sprintf('\n  -> Matriz aumentada luego del Paso %d:', k));
    endif
  endfor

  if abs(M(n, n)) < 1e-12
    error('El sistema no tiene solución única (pivote final nulo).');
  endif

  if mostrar_pasos
    printf('======================================================================\n');
    printf('--- MATRIZ TRIANGULAR SUPERIOR FINAL [ U | c ] ---\n');
    printf('======================================================================\n');
    imprimirMatriz(M, '');
  endif

  % ----------------------------------------------------------------------------
  % ETAPA 2: SUSTITUCION REGRESIVA (HACIA ATRAS)
  % ----------------------------------------------------------------------------
  if mostrar_pasos
    printf('======================================================================\n');
    printf('--- SUSTITUCION REGRESIVA (Despeje de variables) ---\n');
    printf('======================================================================\n');
  endif

  x = zeros(n, 1);
  for i = n:-1:1
    s = 0;
    for j = i+1:n
      s = red(s + red(M(i, j) * x(j)));
    endfor
    x(i) = red(red(M(i, end) - s) / M(i, i));

    if mostrar_pasos
      if i == n
        printf('  x%d = %.4f / %.4f = %.4f\n', i, M(i, end), M(i, i), x(i));
      else
        printf('  x%d = (%.4f - (%.4f)) / %.4f = %.4f\n', i, M(i, end), s, M(i, i), x(i));
      endif
    endif
  endfor

  if mostrar_pasos
    printf('\n======================================================================\n');
    printf('--- SOLUCION DESPEJADA DEL SISTEMA ---\n');
    printf('======================================================================\n');
    for i = 1:n
      printf('  x%d = %10.4f\n', i, x(i));
    endfor
    printf('======================================================================\n\n');
  endif

endfunction
