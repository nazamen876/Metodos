function x = gauss(M, dig)
  % Eliminación de Gauss + sustitución regresiva
  % M: matriz aumentada [A | b]
  % dig (opcional): cantidad de cifras significativas por operación
  if nargin < 2
    dig = 0;                          % 0 = precisión completa
  endif
  if dig > 0
    red = @(v) redondear(v, dig);
  else
    red = @(v) v;
  endif

  n = size(M, 1);
  M = red(M);

  for k = 1:n-1
    % Pivoteo: fila (de k para abajo) con el pivote más grande
    [~, p] = max(abs(M(k:n, k)));
    p = p + k - 1;
    if abs(M(p, k)) < 1e-12
      error('El sistema no tiene solución única (pivote nulo).');
    endif
    if p != k
      M([k p], :) = M([p k], :);
    endif

    for i = k+1:n
      m = red(M(i, k) / M(k, k));
      M(i, :) = red(M(i, :) - red(m * M(k, :)));
    endfor
  endfor

  if abs(M(n, n)) < 1e-12
    error('El sistema no tiene solución única (pivote nulo).');
  endif

  % Sustitución regresiva
  x = zeros(n, 1);
  for i = n:-1:1
    s = 0;
    for j = i+1:n
      s = red(s + red(M(i, j) * x(j)));
    endfor
    x(i) = red(red(M(i, end) - s) / M(i, i));
  endfor
endfunction
