function [L, U, x] = descomposicionLU(A, b)
  % ============================================================================
  % METODO DE DESCOMPOSICION LU (DOOLITTLE)
  % ============================================================================
  % Parametros:
  %   A: matriz cuadrada de coeficientes (n x n)
  %   b: (opcional) vector columna de terminos independientes (n x 1)
  %
  % Retorna:
  %   L: matriz triangular inferior
  %   U: matriz triangular superior
  %   x: vector solucion del sistema A * x = b (si b fue provisto)
  % ============================================================================

  if nargin < 1 || isempty(A)
    error('Debe ingresar la matriz A.');
  endif

  if ~isnumeric(A) || ndims(A) > 2
    error('La matriz A debe ser numerica y bidimensional.');
  endif

  n = size(A, 1);
  if size(A, 2) != n
    error('La matriz A debe ser cuadrada (dimension %d x %d).', n, size(A, 2));
  endif

  resolver_sistema = (nargin >= 2 && ~isempty(b));
  if resolver_sistema
    b = b(:);
    if length(b) != n
      error('El vector b debe tener la misma cantidad de elementos que filas de A (%d).', n);
    endif
  endif

  function imprimirMat(Mat, titulo)
    if ~isempty(titulo)
      printf('%s\n', titulo);
    endif
    for f = 1:size(Mat, 1)
      printf('  [ ');
      for c = 1:size(Mat, 2)
        printf('%10.4f ', Mat(f, c));
      endfor
      printf(']\n');
    endfor
    printf('\n');
  endfunction

  printf('======================================================================\n');
  printf('              METODO DE DESCOMPOSICION LU (DOOLITTLE)\n');
  printf('======================================================================\n\n');
  imprimirMat(A, '--- MATRIZ DE COEFICIENTES A ---');

  % Inicializacion de matrices L y U
  L = eye(n);
  U = zeros(n, n);

  % Algoritmo de Doolittle paso a paso
  for i = 1:n
    printf('----------------------------------------------------------------------\n');
    printf('ETAPA %d:\n', i);

    % Calculo de la fila i de U
    for j = i:n
      suma = 0;
      for k = 1:i-1
        suma = suma + L(i, k) * U(k, j);
      endfor
      U(i, j) = A(i, j) - suma;
    endfor
    printf('  * Calculo de elementos de la Fila %d de U:\n', i);
    for j = i:n
      printf('    U(%d, %d) = %10.4f\n', i, j, U(i, j));
    endfor

    if abs(U(i, i)) < 1e-12
      error('Pivote nulo en U(%d,%d): la matriz no admite factorizacion LU sin pivoteo.', i, i);
    endif

    % Calculo de la columna i de L
    printf('  * Calculo de elementos de la Columna %d de L:\n', i);
    for j = i+1:n
      suma = 0;
      for k = 1:i-1
        suma = suma + L(j, k) * U(k, i);
      endfor
      L(j, i) = (A(j, i) - suma) / U(i, i);
      printf('    L(%d, %d) = %10.4f\n', j, i, L(j, i));
    endfor
    printf('\n');
  endfor

  printf('======================================================================\n');
  printf('FACTORIZACION OBTENIDA A = L * U:\n');
  printf('======================================================================\n');
  imprimirMat(L, '--- MATRIZ TRIANGULAR INFERIOR L ---');
  imprimirMat(U, '--- MATRIZ TRIANGULAR SUPERIOR U ---');

  % Comprobacion de la factorizacion L * U
  dif_factor = norm(A - L * U, 'fro');
  printf('Verificacion ||A - L*U|| = %10.4e\n\n', dif_factor);

  % ----------------------------------------------------------------------------
  % RESOLUCION DEL SISTEMA Ax = b MEDIANTE Ly = b Y Ux = y
  % ----------------------------------------------------------------------------
  x = [];
  if resolver_sistema
    printf('======================================================================\n');
    printf('RESOLUCION DEL SISTEMA A*x = b MEDIANTE FACTORIZACION LU:\n');
    printf('======================================================================\n\n');

    % Paso 1: L * y = b (Sustitucion progresiva hacia adelante)
    printf('1) Sustitucion Progresiva (L * y = b):\n');
    y = zeros(n, 1);
    for i = 1:n
      s = 0;
      for j = 1:i-1
        s = s + L(i, j) * y(j);
      endfor
      y(i) = (b(i) - s) / L(i, i);
      if i == 1
        printf('   y%d = %.4f / %.4f = %10.4f\n', i, b(i), L(i, i), y(i));
      else
        printf('   y%d = (%.4f - (%.4f)) / %.4f = %10.4f\n', i, b(i), s, L(i, i), y(i));
      endif
    endfor

    printf('\nVector intermedio y:\n');
    for i = 1:n
      printf('   y%d = %10.4f\n', i, y(i));
    endfor
    printf('\n');

    % Paso 2: U * x = y (Sustitucion regresiva hacia atras)
    printf('2) Sustitucion Regresiva (U * x = y):\n');
    x = zeros(n, 1);
    for i = n:-1:1
      s = 0;
      for j = i+1:n
        s = s + U(i, j) * x(j);
      endfor
      x(i) = (y(i) - s) / U(i, i);
      if i == n
        printf('   x%d = %.4f / %.4f = %10.4f\n', i, y(i), U(i, i), x(i));
      else
        printf('   x%d = (%.4f - (%.4f)) / %.4f = %10.4f\n', i, y(i), s, U(i, i), x(i));
      endif
    endfor

    printf('\n======================================================================\n');
    printf('SOLUCION FINAL x (A*x = b):\n');
    printf('======================================================================\n');
    for i = 1:n
      printf('   x%d = %10.4f\n', i, x(i));
    endfor
    printf('======================================================================\n\n');
  endif

endfunction
