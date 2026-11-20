function [X, Y] = milne(f, x_init, y_init, h, xf)
  % METODO DE MILNE (METODO MULTIPASO PREDICTOR-CORRECTOR)
  %
  % Requiere 4 puntos iniciales conocidos (x0..x3, y0..y3).
  %
  % Formulas para cada paso n >= 3:
  %   Predictor: y*_{n+1} = y_{n-3} + (4h/3) * [2*f_{n-2} - f_{n-1} + 2*f_n]
  %   Corrector: y_{n+1}  = y_{n-1} + (h/3)  * [f_{n-1} + 4*f_n + f(x_{n+1}, y*_{n+1})]
  %
  % Parametros:
  %   f:      function handle de la derivada f(x, y)
  %   x_init: vector con al menos 4 puntos iniciales de x (x0, x1, x2, x3)
  %   y_init: vector con los 4 valores iniciales de y (y0, y1, y2, y3)
  %   h:      paso constante
  %   xf:     valor final de x
  %
  % Retorna:
  %   X: vector completo de x
  %   Y: vector completo de y (incluye valores iniciales y calculados)

  if length(x_init) < 4 || length(y_init) < 4
    error('El metodo de Milne requiere al menos 4 puntos iniciales.');
  endif

  % Inicializar vectores
  pasos_nuevos = round((xf - x_init(4)) / h);
  if pasos_nuevos < 1
    pasos_nuevos = 0;
  endif

  total_pts = 4 + pasos_nuevos;
  X = zeros(total_pts, 1);
  Y = zeros(total_pts, 1);

  X(1:4) = x_init(1:4);
  Y(1:4) = y_init(1:4);

  printf('======================================================================\n');
  printf('         METODO MULTIPASO DE MILNE (PREDICTOR-CORRECTOR)\n');
  printf('======================================================================\n\n');
  printf('  Puntos iniciales conocidos (requiere 4 puntos previos):\n');
  for i = 1:4
    f_val = f(X(i), Y(i));
    printf('    Punto %d: x = %8.4f | y = %12.6f | y'' = %12.6f\n', ...
           i-1, X(i), Y(i), f_val);
  endfor
  printf('\n  Paso h = %.4f | Objetivo final xf = %.4f\n\n', h, xf);

  printf('  Avanzando mediante Milne:\n');

  for n = 4:(total_pts - 1)
    % Indices Octave: n corresponde al paso n-1 matematico
    % Puntos disponibles: (n-3), (n-2), (n-1), n
    x_prev3 = X(n - 3); y_prev3 = Y(n - 3);
    x_prev2 = X(n - 2); y_prev2 = Y(n - 2); f_prev2 = f(x_prev2, y_prev2);
    x_prev1 = X(n - 1); y_prev1 = Y(n - 1); f_prev1 = f(x_prev1, y_prev1);
    x_curr  = X(n);     y_curr  = Y(n);     f_curr  = f(x_curr, y_curr);

    x_next = x_curr + h;
    X(n + 1) = x_next;

    % 1) Predictor de Milne
    y_pred = y_prev3 + (4 * h / 3) * (2 * f_prev2 - f_prev1 + 2 * f_curr);

    % Derivada evaluada con el valor predicho
    f_pred = f(x_next, y_pred);

    % 2) Corrector de Milne (Regla de Simpson aplicada a la integral)
    y_corr = y_prev1 + (h / 3) * (f_prev1 + 4 * f_curr + f_pred);

    % Diferencia entre predictor y corrector
    dif = abs(y_corr - y_pred);

    printf('----------------------------------------------------------------------\n');
    printf('Calculo para x(%d) = %.4f:\n', n, x_next);
    printf('  [Predictor] y*(%d) = y(%d) + (4h/3)*[2*f(%d) - f(%d) + 2*f(%d)]\n', ...
           n, n-4, n-3, n-2, n-1);
    printf('              y*(%d) = %.6f + (%.6f)*[2*(%.6f) - (%.6f) + 2*(%.6f)]\n', ...
           n, y_prev3, 4*h/3, f_prev2, f_prev1, f_curr);
    printf('              y*(%d) = %12.6f\n', n, y_pred);
    printf('  f(x, y*)           = %12.6f\n', f_pred);
    printf('  [Corrector] y(%d)  = y(%d) + (h/3)*[f(%d) + 4*f(%d) + f*]\n', ...
           n, n-2, n-2, n-1);
    printf('              y(%d)  = %.6f + (%.6f)*[(%.6f) + 4*(%.6f) + (%.6f)]\n', ...
           n, y_prev1, h/3, f_prev1, f_curr, f_pred);
    printf('              y(%d)  = %12.6f\n', n, y_corr);
    printf('  |Corrector - Predictor| = %12.6e\n\n', dif);

    Y(n + 1) = y_corr;
  endfor

  printf('======================================================================\n');
  printf('TABLA FINAL DE SOLUCION POR METODO DE MILNE:\n');
  printf('  %-4s | %-10s | %-12s | %-12s\n', 'Punto', 'x', 'y', 'y'' = f(x,y)');
  printf('  ------|------------|--------------|--------------\n');
  for i = 1:total_pts
    printf('  %5d | %10.4f | %12.6f | %12.6f\n', i-1, X(i), Y(i), f(X(i), Y(i)));
  endfor
  printf('======================================================================\n\n');

endfunction
