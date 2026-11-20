function [x, k, convergencia] = GaussSeidel(A, b, x0, tol, maxIter)
  % ============================================================================
  % METODO ITERATIVO DE GAUSS-SEIDEL
  % ============================================================================
  %
  % Parametros:
  %   A:       matriz de coeficientes cuadrada (n x n)
  %   b:       vector columna de terminos independientes (n x 1)
  %   x0:      (opcional) vector inicial de aproximacion (por defecto ceros)
  %   tol:     (opcional) tolerancia de error absoluto/relativo (por defecto 1e-4)
  %   maxIter: (opcional) maximo de iteraciones (por defecto 100)
  %
  % Retorna:
  %   x:            vector solucion aproximado
  %   k:            cantidad de iteraciones realizadas
  %   convergencia: booleano que indica si el metodo convergio
  % ============================================================================

  if nargin < 2 || isempty(A) || isempty(b)
    error('Debe ingresar la matriz A y el vector b.');
  endif

  n = size(A, 1);
  if size(A, 2) != n
    error('La matriz A debe ser cuadrada.');
  endif

  b = b(:);
  if length(b) != n
    error('La dimension de b no coincide con las filas de A.');
  endif

  if nargin < 3 || isempty(x0)
    x0 = zeros(n, 1);
  else
    x0 = x0(:);
  endif

  if nargin < 4 || isempty(tol)
    tol = 1e-4;
  endif

  if nargin < 5 || isempty(maxIter)
    maxIter = 100;
  endif

  printf('======================================================================\n');
  printf('                 METODO ITERATIVO DE GAUSS-SEIDEL\n');
  printf('======================================================================\n\n');

  % ----------------------------------------------------------------------------
  % 1. ANALISIS DE CONVERGENCIA PREVIO
  % ----------------------------------------------------------------------------
  printf('--- ANALISIS PREVIO DE CONVERGENCIA ---\n');

  % A) Criterio de diagonal dominante por filas
  diag_dom = true;
  for i = 1:n
    suma_fila = sum(abs(A(i, :))) - abs(A(i, i));
    if abs(A(i, i)) <= suma_fila
      diag_dom = false;
    endif
  endfor

  if diag_dom
    printf('  1) Criterio de Diagonal Estrictamente Dominante: CUMPLE\n');
    printf('     -> Se garantiza la convergencia del metodo para cualquier vector inicial.\n');
  else
    printf('  1) Criterio de Diagonal Estrictamente Dominante: NO CUMPLE estrictamente.\n');
  endif

  % B) Radio espectral de la matriz de iteracion de Gauss-Seidel
  % Descomposicion A = D - L_str - U_str (o A = D + L + U)
  D_mat = diag(diag(A));
  L_mat = tril(A, -1);
  U_mat = triu(A, 1);

  % T_gs = -(D + L)^(-1) * U
  T_gs = -inv(D_mat + L_mat) * U_mat;
  autovalores_T = eig(T_gs);
  radio_espectral = max(abs(autovalores_T));

  printf('  2) Radio Espectral rho(T_gs) = %.6f\n', radio_espectral);
  if radio_espectral < 1
    printf('     -> Como rho(T_gs) < 1, el metodo CONVERGE garantizadamente.\n\n');
  else
    printf('     -> Como rho(T_gs) >= 1, el metodo PUEDE DIVERGER.\n\n');
  endif

  % ----------------------------------------------------------------------------
  % 2. PROCESO ITERATIVO
  % ----------------------------------------------------------------------------
  x = x0;
  printf('Vector inicial x^(0):\n');
  for i = 1:n
    printf('  x%d^(0) = %10.4f\n', i, x(i));
  endfor
  printf('\nTolerancia: %.1e | Max iteraciones: %d\n\n', tol, maxIter);

  % Encabezado de la tabla de iteraciones
  printf('  %-5s', 'Iter');
  for i = 1:n
    printf(' | %-12s', sprintf('x%d', i));
  endfor
  printf(' | %-12s\n', 'Error max');

  printf('  -----');
  for i = 1:n
    printf('|-------------');
  endfor
  printf('|-------------\n');

  convergencia = false;
  for k = 1:maxIter
    x_prev = x;

    for i = 1:n
      suma = 0;
      for j = 1:n
        if j != i
          suma = suma + A(i, j) * x(j);  % Usa x actualizado (Gauss-Seidel)
        endif
      endfor
      x(i) = (b(i) - suma) / A(i, i);
    endfor

    error_iter = max(abs(x - x_prev));

    printf('  %5d', k);
    for i = 1:n
      printf(' | %12.6f', x(i));
    endfor
    printf(' | %12.6e\n', error_iter);

    if error_iter < tol
      convergencia = true;
      break;
    endif
  endfor

  printf('\n======================================================================\n');
  if convergencia
    printf('CONVERGENCIA ALCANZADA en %d iteraciones (Error < %.1e)\n', k, tol);
  else
    printf('ALERTA: Se alcanzo el maximo de %d iteraciones sin converger.\n', maxIter);
  endif
  printf('======================================================================\n');
  printf('SOLUCION FINAL POR GAUSS-SEIDEL:\n');
  for i = 1:n
    printf('  x%d = %12.6f\n', i, x(i));
  endfor
  printf('======================================================================\n\n');

endfunction
