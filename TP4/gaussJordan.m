function x = gaussJordan(M)
  % Gauss-Jordan: deja la matriz en identidad, las soluciones quedan en la última columna
  n = size(M, 1);

  for k = 1:n
    % Pivoteo
    [~, p] = max(abs(M(k:n, k)));
    p = p + k - 1;
    if abs(M(p, k)) < 1e-12
      error('El sistema no tiene solución única (pivote nulo).');
    endif
    if p != k
      M([k p], :) = M([p k], :);
    endif

    % Pivote en 1
    M(k, :) = M(k, :) / M(k, k);

    % Ceros arriba y abajo del pivote
    for i = 1:n
      if i != k
        M(i, :) = M(i, :) - M(i, k) * M(k, :);
      endif
    endfor
  endfor

  x = M(:, end);
endfunction
