function [p, autovalores, autovectores, B_matrices, A_inv] = fadeevLeverrier(A)
  % ============================================================================
  % METODO DE FADEEV - LEVERRIER
  % ============================================================================
  %
  % Parametros:
  %   A: matriz cuadrada (n x n)
  %
  % Retorna:
  %   p:            vector con los coeficientes [p1, p2, ..., pn]
  %   autovalores:  raices de P(lambda)
  %   autovectores: matriz cuyas columnas son los autovectores normalizados
  % ============================================================================

  if nargin < 1 || isempty(A)
    error('Debe ingresar la matriz cuadrada A.');
  endif

  n = size(A, 1);
  if size(A, 2) != n
    error('La matriz A debe ser cuadrada.');
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
  printf('                 METODO DE FADEEV - LEVERRIER\n');
  printf('======================================================================\n\n');
  imprimirMat(A, '--- MATRIZ A (n = %d) ---');

  p = zeros(n, 1);
  B = cell(n, 1);
  B_prev = eye(n);

  for k = 1:n
    printf('----------------------------------------------------------------------\n');
    printf('PASO k = %d:\n', k);

    % A_k = A * B_{k-1}
    A_k = A * B_prev;
    imprimirMat(A_k, sprintf('  Matriz A_%d = A * B_%d:', k, k-1));

    % p_k = (1/k) * trace(A_k)
    traza_k = trace(A_k);
    p(k) = traza_k / k;
    printf('  Traza(A_%d) = %10.4f\n', k, traza_k);
    printf('  Coeficiente p_%d = Traza / %d = %10.6f\n\n', k, k, p(k));

    % B_k = A_k - p_k * I
    B_k = A_k - p(k) * eye(n);
    B{k} = B_k;
    imprimirMat(B_k, sprintf('  Matriz B_%d = A_%d - p_%d * I:', k, k, k));

    B_prev = B_k;
  endfor

  % Comprobacion teorica: B_n debe ser la matriz nula
  norma_Bn = norm(B{n}, 'fro');
  printf('======================================================================\n');
  printf('VERIFICACION FINAL:\n');
  printf('  Norma de B_%d (debe ser aproximadamente 0): ||B_n|| = %10.4e\n\n', n, norma_Bn);

  % Polinomio caracteristico
  % P(lambda) = lambda^n - p_1*lambda^(n-1) - ... - p_n = 0
  poly_coefs = [1, -p(:)'];

  printf('POLINOMIO CARACTERISTICO P(lambda):\n  P(lambda) = lambda^%d', n);
  for k = 1:n
    if p(k) >= 0
      printf(' - %.6f*lambda^%d', p(k), n - k);
    else
      printf(' + %.6f*lambda^%d', abs(p(k)), n - k);
    endif
  endfor
  printf(' = 0\n\n');

  % Autovalores: raices del polinomio caracteristico
  autovalores = roots(poly_coefs);
  printf('AUTOVALORES (Raices del polinomio caracteristico):\n');
  for i = 1:n
    if isreal(autovalores(i))
      printf('  lambda_%d = %12.6f\n', i, autovalores(i));
    else
      printf('  lambda_%d = %12.6f + %12.6fi\n', i, real(autovalores(i)), imag(autovalores(i)));
    endif
  endfor
  printf('\n');

  % Matriz inversa mediante Fadeev-Leverrier: A^(-1) = B_{n-1} / p_n
  A_inv = [];
  if abs(p(n)) > 1e-12
    A_inv = B{n-1} / p(n);
    printf('INVERSA DE A MEDIANTE FADEEV-LEVERRIER (A^(-1) = B_%d / p_%d):\n', n-1, n);
    imprimirMat(A_inv, '');
  else
    printf('El determinante es cero (p_%d = 0); la matriz A no tiene inversa.\n\n', n);
  endif

  % Calculo de autovectores asociados:
  % Para cada autovalor lambda_i, se puede evaluar la matriz de adjuntos:
  % E(lambda) = lambda^(n-1)*I + lambda^(n-2)*B_1 + ... + B_{n-1}
  % Cualquier columna no nula de E(lambda) es un autovector asociado a lambda.
  printf('======================================================================\n');
  printf('AUTOVALORES Y AUTOVECTORES ASOCIADOS:\n');
  printf('======================================================================\n');
  autovectores = zeros(n, n);
  for i = 1:n
    lam = autovalores(i);

    % Construir matriz adjunta polinomial E(lam)
    E_mat = eye(n);
    for k = 1:n-1
      E_mat = lam * E_mat + B{k};
    endfor

    % Buscar columna con mayor norma
    [max_col_norm, col_idx] = max(sum(abs(E_mat), 1));
    v = E_mat(:, col_idx);
    if norm(v) > 1e-10
      v = v / norm(v);   % Normalizar vector
    else
      % Alternativa clasica: null space de (A - lam*I)
      null_mat = null(A - lam * eye(n));
      if ~isempty(null_mat)
        v = null_mat(:, 1);
      endif
    endif
    autovectores(:, i) = v;

    printf('Autovalor lambda_%d = %10.6f:\n', i, lam);
    printf('  Autovector v_%d (normalizado):\n', i);
    for r = 1:n
      printf('    [%10.6f]\n', v(r));
    endfor
    % Verificacion A*v = lambda*v
    res_vec = norm(A * v - lam * v);
    printf('  Verificacion ||A*v - lambda*v|| = %10.4e\n\n', res_vec);
  endfor
  printf('======================================================================\n\n');

  B_matrices = B;

endfunction
