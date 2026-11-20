function [X, Y] = eulerModificado(f, x0, y0, h, xf, tol)
  % METODO DE EULER MODIFICADO (PREDICTOR-CORRECTOR CON ITERACION)
  %
  % Resuelve y' = f(x, y), con y(x0) = y0 en [x0, xf]
  % Predictor (Euler): y*_{n+1} = y_n + h * f(x_n, y_n)
  % Corrector:         y^(k)_{n+1} = y_n + (h/2) * [f(x_n, y_n) + f(x_{n+1}, y^(k-1)_{n+1})]
  %
  % Parametros:
  %   f:   function handle de la derivada f(x, y)
  %   x0:  valor inicial de x
  %   y0:  valor inicial de y
  %   h:   paso de integracion
  %   xf:  valor final de x
  %   tol: tolerancia de parada para el corrector (opcional, por defecto 0.001)

  if nargin < 6 || isempty(tol)
    tol = 0.001;
  endif

  N = round((xf - x0) / h);
  X = zeros(N + 1, 1);
  Y = zeros(N + 1, 1);

  X(1) = x0;
  Y(1) = y0;

  printf('======================================================================\n');
  printf('         METODO DE EULER MODIFICADO (PREDICTOR-CORRECTOR)\n');
  printf('======================================================================\n\n');
  printf('  Condicion inicial: y(%.4f) = %.6f\n', x0, y0);
  printf('  Intervalo        : [%.4f, %.4f]\n', x0, xf);
  printf('  Paso (h)         : %.4f | Tolerancia: %.6f\n\n', h, tol);

  for n = 1:N
    xn = X(n);
    yn = Y(n);
    x_next = x0 + n * h;
    fn = f(xn, yn);

    % 1) Predictor (Euler simple)
    y_pred = yn + h * fn;

    printf('----------------------------------------------------------------------\n');
    printf('PASO %d: de x = %.4f a x = %.4f\n', n, xn, x_next);
    printf('  y(%d) actual = %.6f, f(x_n, y_n) = %.6f\n', n-1, yn, fn);
    printf('  [Predictor Euler] y*(%d) = %.6f + %.4f * %.6f = %.6f\n\n', ...
           n, yn, h, fn, y_pred);

    % 2) Corrector iterativo
    y_ant = y_pred;
    iter = 0;
    max_iter = 100;
    printf('  Iteraciones del Corrector:\n');
    printf('    %-5s | %-12s | %-12s | %-12s\n', 'Iter', 'y_corr', 'f(x+1, y_ant)', 'Error');
    printf('    ------|--------------|--------------|--------------\n');

    while iter < max_iter
      iter = iter + 1;
      f_next = f(x_next, y_ant);
      y_corr = yn + (h / 2) * (fn + f_next);
      err = abs(y_corr - y_ant);

      printf('    %5d | %12.6f | %12.6f | %12.6e\n', iter, y_corr, f_next, err);

      if err < tol
        break;
      endif
      y_ant = y_corr;
    endwhile

    Y(n + 1) = y_corr;
    X(n + 1) = x_next;
    printf('  -> Convergio en %d iteraciones: y(%.4f) = %.6f\n\n', iter, x_next, y_corr);
  endfor

  printf('======================================================================\n');
  printf('RESUMEN DE SOLUCION POR EULER MODIFICADO:\n');
  printf('  %-4s | %-10s | %-12s\n', 'Paso', 'x_n', 'y_n');
  printf('  -----|------------|--------------\n');
  for n = 1:N+1
    printf('  %4d | %10.4f | %12.6f\n', n-1, X(n), Y(n));
  endfor
  printf('======================================================================\n\n');

endfunction
