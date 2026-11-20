function [x, M] = gauss(M, dig)
  % ============================================================================
  % ELIMINACION DE GAUSS CON PIVOTEO PARCIAL Y SUSTITUCION REGRESIVA
  % ============================================================================
  %
  % Parametros:
  %   M:   matriz aumentada [A | b] de dimension n x (n+1)
  %   dig: (opcional) cantidad de cifras significativas para simular
  %        aritmetica finita (0 o vacio = precision completa de maquina)
  %
  % Retorna:
  %   x: vector columna con la solucion [x1; x2; ...; xn]
  %   M: matriz aumentada en forma triangular superior final [U | c]
  % ============================================================================

  % ----------------------------------------------------------------------------
  % 1. VERIFICACIONES DE ENTRADA
  % ----------------------------------------------------------------------------
  if nargin < 1 || isempty(M)
    error('Debe ingresar la matriz aumentada M = [A b].');
  endif

  if ~isnumeric(M) || ndims(M) > 2
    error('La matriz aumentada debe ser numerica y bidimensional.');
  endif

  if any(isnan(M(:))) || any(isinf(M(:)))
    error('La matriz aumentada contiene valores invalidos (NaN o Infinito).');
  endif

  n = size(M, 1);       % Cantidad de ecuaciones (filas)
  ncols = size(M, 2);   % Columnas totales (coeficientes + terminos independientes)

  if n < 1
    error('La matriz no puede estar vacia.');
  endif

  % Validar que A sea cuadrada: si hay n filas, debe haber n+1 columnas
  if ncols != n + 1
    error('Dimension incorrecta: para un sistema de %d ecuaciones, la matriz aumentada debe tener %d columnas (dimension %d x %d).', ...
          n, n + 1, n, n + 1);
  endif

  % ----------------------------------------------------------------------------
  % 2. CONFIGURACION DE LA ARITMETICA (PRECISION)
  % ----------------------------------------------------------------------------
  if nargin < 2 || isempty(dig)
    dig = 0;   % Por defecto: precision completa
  endif

  if dig > 0
    % Redondeo a 'dig' cifras significativas por operacion elemental
    red = @(v) redondear(v, dig);
  else
    % Funcion identidad (sin redondeo artificial)
    red = @(v) v;
  endif

  % Redondear la matriz inicial si se definieron cifras significativas
  M = red(M);

  % ----------------------------------------------------------------------------
  % FUNCION AUXILIAR: impresion con separador visual entre A y b
  % ----------------------------------------------------------------------------
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

  % Encabezado inicial
  printf('======================================================================\n');
  printf('             METODO DE ELIMINACION DE GAUSS CON PIVOTEO\n');
  if dig > 0
    printf('             Aritmetica a %d cifras significativas\n', dig);
  else
    printf('             Precision completa de maquina\n');
  endif
  printf('======================================================================\n\n');
  imprimirMatriz(M, '--- MATRIZ AUMENTADA INICIAL [ A | b ] ---');

  % ----------------------------------------------------------------------------
  % 3. ETAPA 1: ELIMINACION HACIA ADELANTE (TRIANGULACION SUPERIOR)
  % ----------------------------------------------------------------------------
  % Recorremos cada columna k desde la 1 hasta la n-1 para generar ceros
  % debajo de cada elemento de la diagonal principal.
  for k = 1:n-1
    printf('----------------------------------------------------------------------\n');
    printf('PASO %d: Columna %d\n', k, k);

    % --- PIVOTEO PARCIAL ---
    % Buscamos el elemento con mayor valor absoluto en la columna k,
    % desde la fila k hasta la ultima fila n.
    [piv_val, p] = max(abs(M(k:n, k)));
    p = p + k - 1;   % Ajuste del indice al rango global de filas

    % Verificacion de solucion unica: si el maximo es cero (o menor a 1e-12),
    % la columna es nula y el determinante es cero (sistema singular).
    if abs(M(p, k)) < 1e-12
      error('El sistema no tiene solucion unica (pivote nulo en columna %d).', k);
    endif

    % Si el pivote no esta en la fila k, intercambiamos filas completas
    if p != k
      printf('  * Pivoteo: Mayor valor absoluto en fila %d (|%.4f|).\n', p, M(p, k));
      printf('    -> Intercambio de filas: Fila %d <---> Fila %d\n', k, p);
      M([k p], :) = M([p k], :);
    else
      printf('  * Pivoteo: El pivote en la diagonal (Fila %d) ya es el maximo (|%.4f|).\n', k, M(k, k));
      printf('    -> No requiere intercambio de filas.\n');
    endif

    % --- ELIMINACION POR FILAS ---
    % Restamos a cada fila i (debajo del pivote) un multiplo m de la fila k
    printf('  * Eliminacion hacia adelante:\n');
    for i = k+1:n
      % Multiplicador: razon entre el elemento a anular y el pivote
      m = red(M(i, k) / M(k, k));

      % Operacion elemental vectorial: Fila_i = Fila_i - m * Fila_k
      M(i, :) = red(M(i, :) - red(m * M(k, :)));

      % Forzamos cero exacto en la posicion bajo el pivote para eliminar
      % residuos de precision flotante (ej: 1e-16 o -0.0000)
      M(i, k) = 0;

      printf('    Fila %d = Fila %d - (%8.4f) * Fila %d\n', i, i, m, k);
    endfor

    % Mostrar el estado de la matriz tras completar la columna k
    imprimirMatriz(M, sprintf('\n  -> Matriz aumentada luego del Paso %d:', k));
  endfor

  % Verificacion del ultimo pivote en la diagonal (M(n,n))
  if abs(M(n, n)) < 1e-12
    error('El sistema no tiene solucion unica (pivote final M(%d,%d) nulo).', n, n);
  endif

  printf('======================================================================\n');
  printf('--- MATRIZ TRIANGULAR SUPERIOR FINAL [ U | c ] ---\n');
  printf('======================================================================\n');
  imprimirMatriz(M, '');

  % ----------------------------------------------------------------------------
  % 4. ETAPA 2: SUSTITUCION REGRESIVA (HACIA ATRAS)
  % ----------------------------------------------------------------------------
  % Con la matriz escalonada, despejamos las incognitas comenzando desde
  % la ultima (x_n) hasta la primera (x_1).
  printf('======================================================================\n');
  printf('--- SUSTITUCION REGRESIVA (Despeje de variables) ---\n');
  printf('======================================================================\n');

  x = zeros(n, 1);
  for i = n:-1:1
    % Sumamos todos los terminos conocidos a la derecha de la diagonal
    % s = sum_{j=i+1}^n (u_ij * x_j)
    s = 0;
    for j = i+1:n
      s = red(s + red(M(i, j) * x(j)));
    endfor

    % Despejamos x_i: x_i = (c_i - s) / u_ii
    x(i) = red(red(M(i, end) - s) / M(i, i));

    % Imprimir el despeje explicito paso a paso
    if i == n
      printf('  x%d = %.4f / %.4f = %.4f\n', i, M(i, end), M(i, i), x(i));
    else
      printf('  x%d = (%.4f - (%.4f)) / %.4f = %.4f\n', i, M(i, end), s, M(i, i), x(i));
    endif
  endfor

  % ----------------------------------------------------------------------------
  % 5. PRESENTACION DEL RESULTADO FINAL
  % ----------------------------------------------------------------------------
  printf('\n======================================================================\n');
  printf('--- SOLUCION DESPEJADA DEL SISTEMA ---\n');
  printf('======================================================================\n');
  for i = 1:n
    printf('  x%d = %10.4f\n', i, x(i));
  endfor
  printf('======================================================================\n\n');

endfunction
