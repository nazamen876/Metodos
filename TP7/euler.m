function [X, Y] = euler(f, x0, y0, h, xf)
  % METODO DE EULER PARA ECUACIONES DIFERENCIALES ORDINARIAS (PVI)
  %
  % Resuelve y' = f(x, y), con y(x0) = y0 en [x0, xf]
  % Formula: y_{n+1} = y_n + h * f(x_n, y_n)
  %
  % Parametros:
  %   f:  function handle de la derivada f(x, y)
  %   x0: valor inicial de x
  %   y0: valor inicial de y
  %   h:  paso de integracion
  %   xf: valor final de x
  %
  % Retorna:
  %   X: vector con los valores de x_n
  %   Y: vector con las soluciones aproximadas y_n

  N = round((xf - x0) / h);
  X = zeros(N + 1, 1);
  Y = zeros(N + 1, 1);

  X(1) = x0;
  Y(1) = y0;

  printf('======================================================================\n');
  printf('                    METODO DE EULER (PVI)\n');
  printf('======================================================================\n\n');
  printf('  Condicion inicial: y(%.4f) = %.6f\n', x0, y0);
  printf('  Intervalo        : [%.4f, %.4f]\n', x0, xf);
  printf('  Paso (h)         : %.4f (Cantidad de pasos: %d)\n\n', h, N);

  printf('  %-4s | %-10s | %-12s | %-12s | %-12s\n', 'Paso', 'x_n', 'y_n', 'f(x_n, y_n)', 'h*f(x_n,y_n)');
  printf('  -----|------------|--------------|--------------|--------------\n');

  for n = 1:N
    xn = X(n);
    yn = Y(n);
    fn = f(xn, yn);
    delta_y = h * fn;

    printf('  %4d | %10.4f | %12.6f | %12.6f | %12.6f\n', n-1, xn, yn, fn, delta_y);

    Y(n + 1) = yn + delta_y;
    X(n + 1) = x0 + n * h;
  endfor

  % Imprimir el ultimo punto
  fn_fin = f(X(end), Y(end));
  printf('  %4d | %10.4f | %12.6f | %12.6f | %12s\n', N, X(end), Y(end), fn_fin, '---');
  printf('======================================================================\n\n');

endfunction
