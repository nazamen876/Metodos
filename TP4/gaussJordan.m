function [x, M] = gaussJordan(M, dig)
  % ============================================================================
  % METODO DE GAUSS-JORDAN CON PIVOTEO PARCIAL
  % ============================================================================
  % Parametros:
  %   M:   matriz aumentada [A | b] de dimension n x (n+1)
  %   dig: (opcional) cifras significativas para redondeo (0 = precision completa)
  %
  % Retorna:
  %   x: vector columna solucion
  %   M: matriz aumentada reducida final [I | x]
  % ============================================================================

  if nargin < 1 || isempty(M)
    error('Debe ingresar la matriz aumentada M = [A b].');
  endif

  if ~isnumeric(M) || ndims(M) > 2
    error('La matriz aumentada debe ser numerica y bidimensional.');
  endif

  if any(isnan(M(:))) || any(isinf(M(:)))
    error('La matriz aumentada contiene valores invalidos (NaN o Inf).');
  endif

  n = size(M, 1);
  ncols = size(M, 2);

  if ncols != n + 1
    error('Dimension incorrecta: la matriz aumentada debe ser de dimension %d x %d.', n, n + 1);
  endif

  if nargin < 2 || isempty(dig)
    dig = 0;
  endif

  if dig > 0
    red = @(v) redondear(v, dig);
  else
    red = @(v) v;
  endif

  M = red(M);

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

  printf('======================================================================\n');
  printf('                 METODO DE GAUSS-JORDAN CON PIVOTEO\n');
  if dig > 0
    printf('                 Aritmetica a %d cifras significativas\n', dig);
  else
    printf('                 Precision completa de maquina\n');
  endif
  printf('======================================================================\n\n');
  imprimirMatriz(M, '--- MATRIZ AUMENTADA INICIAL [ A | b ] ---');

  for k = 1:n
    printf('----------------------------------------------------------------------\n');
    printf('PASO %d: Columna %d\n', k, k);

    % Pivoteo parcial
    [piv_val, p] = max(abs(M(k:n, k)));
    p = p + k - 1;

    if abs(M(p, k)) < 1e-12
      error('El sistema no tiene solucion unica (pivote nulo en columna %d).', k);
    endif

    if p != k
      printf('  * Pivoteo: Mayor elemento en fila %d (|%.4f|).\n', p, M(p, k));
      printf('    -> Intercambio de filas: Fila %d <---> Fila %d\n', k, p);
      M([k p], :) = M([p k], :);
    else
      printf('  * Pivoteo: El pivote en diagonal (Fila %d) ya es el maximo (|%.4f|).\n', k, M(k, k));
    endif

    % Normalizar la fila pivote para que el pivote sea 1
    piv = M(k, k);
    printf('  * Normalizacion: Fila %d = Fila %d / %.4f\n', k, k, piv);
    M(k, :) = red(M(k, :) / piv);
    M(k, k) = 1;

    % Eliminacion: ceros arriba y abajo del pivote
    printf('  * Eliminacion en otras filas (arriba y abajo):\n');
    for i = 1:n
      if i != k
        factor = M(i, k);
        M(i, :) = red(M(i, :) - red(factor * M(k, :)));
        M(i, k) = 0;
        printf('    Fila %d = Fila %d - (%8.4f) * Fila %d\n', i, i, factor, k);
      endif
    endfor

    imprimirMatriz(M, sprintf('\n  -> Matriz aumentada luego del Paso %d:', k));
  endfor

  x = M(:, end);

  printf('======================================================================\n');
  printf('--- MATRIZ FINAL REDUCIDA [ I | x ] ---\n');
  printf('======================================================================\n');
  imprimirMatriz(M, '');

  printf('======================================================================\n');
  printf('--- SOLUCION DESPEJADA DIRECTA POR GAUSS-JORDAN ---\n');
  printf('======================================================================\n');
  for i = 1:n
    printf('  x%d = %10.4f\n', i, x(i));
  endfor
  printf('======================================================================\n\n');

endfunction
