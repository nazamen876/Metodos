function D = tablaDiferencias(x, y)
  % TABLA DE DIFERENCIAS FINITAS AVANZADAS
  %
  % Parametros:
  %   x: vector de valores de x (equiespaciados)
  %   y: vector de valores de y = f(x)
  %
  % Retorna:
  %   D: matriz de diferencias finitas avanzadas (n x n)
  %      Columna 1: y, Columna 2: Δy, Columna 3: Δ²y, etc.

  n = length(y);
  h = x(2) - x(1);

  % Construir la tabla de diferencias avanzadas
  D = zeros(n, n);
  D(:,1) = y(:);
  for k = 2:n
    for i = 1:(n - k + 1)
      D(i, k) = D(i+1, k-1) - D(i, k-1);
    endfor
  endfor

  % Imprimir la tabla formateada
  printf('======================================================================\n');
  printf('                  TABLA DE DIFERENCIAS FINITAS\n');
  printf('======================================================================\n\n');

  % Encabezado
  printf('  %10s | %12s', 'x', 'y');
  for k = 2:n
    etiqueta = sprintf('D^%dy', k-1);
    printf(' | %12s', etiqueta);
  endfor
  printf('\n');

  printf('  -----------|-------------');
  for k = 2:n
    printf('|-------------');
  endfor
  printf('\n');

  % Filas
  for i = 1:n
    printf('  %10.5f | %12.6f', x(i), D(i, 1));
    for k = 2:n
      if i <= n - k + 1
        printf(' | %12.6f', D(i, k));
      else
        printf(' | %12s', '');
      endif
    endfor
    printf('\n');
  endfor
  printf('\n======================================================================\n\n');

endfunction
