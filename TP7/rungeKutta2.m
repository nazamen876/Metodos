function [X, Y] = rungeKutta2(f, x0, y0, h, xf)
  % METODO DE RUNGE-KUTTA DE SEGUNDO ORDEN (RK2 - METODO DE HEUN)
  %
  % Resuelve y' = f(x, y), con y(x0) = y0 en [x0, xf]
  % Formulas:
  %   k1 = h * f(x_n, y_n)
  %   k2 = h * f(x_n + h, y_n + k1)
  %   y_{n+1} = y_n + (1/2) * (k1 + k2)
  %
  % Parametros:
  %   f:  function handle de la derivada f(x, y)
  %   x0: valor inicial de x
  %   y0: valor inicial de y
  %   h:  paso de integracion
  %   xf: valor final de x
  %
  % Retorna:
  %   X: vector de nodos x_n
  %   Y: vector de soluciones aproximadas y_n

  N = round((xf - x0) / h);
  X = zeros(N + 1, 1);
  Y = zeros(N + 1, 1);

  X(1) = x0;
  Y(1) = y0;

  printf('======================================================================\n');
  printf('             METODO DE RUNGE-KUTTA DE 2DO ORDEN (RK2)\n');
  printf('======================================================================\n\n');
  printf('  Condicion inicial: y(%.4f) = %.6f\n', x0, y0);
  printf('  Intervalo        : [%.4f, %.4f]\n', x0, xf);
  printf('  Paso (h)         : %.4f (Cantidad de pasos: %d)\n\n', h, N);

  printf('  %-4s | %-10s | %-12s | %-12s | %-12s | %-12s\n', ...
         'Paso', 'x_n', 'y_n', 'k1', 'k2', 'y_{n+1}');
  printf('  -----|------------|--------------|--------------|--------------|--------------\n');

  for n = 1:N
    xn = X(n);
    yn = Y(n);

    k1 = h * f(xn, yn);
    k2 = h * f(xn + h, yn + k1);

    y_next = yn + 0.5 * (k1 + k2);

    printf('  %4d | %10.4f | %12.6f | %12.6f | %12.6f | %12.6f\n', ...
           n-1, xn, yn, k1, k2, y_next);

    X(n + 1) = x0 + n * h;
    Y(n + 1) = y_next;
  endfor

  printf('  %4d | %10.4f | %12.6f | %12s | %12s | %12s\n', ...
         N, X(end), Y(end), '---', '---', '---');
  printf('======================================================================\n\n');

endfunction
