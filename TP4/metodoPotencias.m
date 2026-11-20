function [lambda, v, iteraciones] = metodoPotencias(A, v0, maxIter, tol)
  % ============================================================================
  % METODO DE LAS POTENCIAS (POWER METHOD)
  % ============================================================================
  % Parametros:
  %   A:       matriz cuadrada (n x n)
  %   v0:      (opcional) vector inicial de tanteo (por defecto unos)
  %   maxIter: (opcional) numero maximo de iteraciones (por defecto 100)
  %   tol:     (opcional) tolerancia para convergencia (por defecto 1e-5)
  %
  % Retorna:
  %   lambda:      autovalor dominante aproximado
  %   v:           autovector asociado normalizado
  %   iteraciones: cantidad de iteraciones realizadas
  % ============================================================================

  if nargin < 1 || isempty(A)
    error('Debe ingresar la matriz cuadrada A.');
  endif

  n = size(A, 1);
  if size(A, 2) != n
    error('La matriz A debe ser cuadrada.');
  endif

  if nargin < 2 || isempty(v0)
    v0 = ones(n, 1);
  else
    v0 = v0(:);
  endif

  if length(v0) != n
    error('La dimension del vector inicial v0 debe coincidir con el orden de A (%d).', n);
  endif

  if nargin < 3 || isempty(maxIter)
    maxIter = 100;
  endif

  if nargin < 4 || isempty(tol)
    tol = 1e-5;
  endif

  printf('======================================================================\n');
  printf('                       METODO DE LAS POTENCIAS\n');
  printf('======================================================================\n\n');

  printf('Vector inicial v^(0):\n');
  for i = 1:n
    printf('  v%d^(0) = %10.4f\n', i, v0(i));
  endfor
  printf('\nMaximo de iteraciones: %d | Tolerancia: %.1e\n\n', maxIter, tol);

  % Normalizar vector inicial por su norma infinito
  [~, max_idx] = max(abs(v0));
  v = v0 / v0(max_idx);

  lambda = 0;
  printf('  %-5s | %-12s | %-12s | %s\n', 'Iter', 'Autovalor (c_k)', 'Error rel', 'Vector v_k');
  printf('  ------|--------------|--------------|--------------------------------------\n');

  convergencia = false;
  for k = 1:maxIter
    lambda_prev = lambda;

    % y = A * v
    y = A * v;

    % El autovalor aproximado es la componente de mayor modulo
    [max_val, idx_piv] = max(abs(y));
    lambda = y(idx_piv);   % Mantiene el signo de la componente

    % Normalizar el vector
    v_new = y / lambda;

    % Error relativo de autovalor
    if abs(lambda) > 1e-12
      err = abs(lambda - lambda_prev) / abs(lambda);
    else
      err = abs(lambda - lambda_prev);
    endif

    % Imprimir fila de iteracion
    vec_str = sprintf('%8.4f ', v_new);
    printf('  %5d | %12.6f | %12.6e | [ %s]\n', k, lambda, err, vec_str);

    v = v_new;

    if k > 1 && err < tol
      convergencia = true;
      break;
    endif
  endfor

  iteraciones = k;

  printf('\n======================================================================\n');
  if convergencia
    printf('CONVERGENCIA ALCANZADA en %d iteraciones (Tol < %.1e)\n', k, tol);
  else
    printf('Se completaron %d iteraciones programadas.\n', maxIter);
  endif
  printf('======================================================================\n');
  printf('AUTOVALOR DOMINANTE APROXIMADO:\n');
  printf('  lambda_max = %12.6f\n\n', lambda);
  printf('AUTOVECTOR ASOCIADO:\n');
  for i = 1:n
    printf('  v(%d) = %12.6f\n', i, v(i));
  endfor
  printf('======================================================================\n\n');

endfunction
