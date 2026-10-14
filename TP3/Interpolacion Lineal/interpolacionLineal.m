function [raiz, iter, historial] = interpolacionLineal(f, a, b, tol, max_iter)

  if nargin < 4 || isempty(tol)
    tol = 1e-5;
  endif
  if nargin < 5 || isempty(max_iter)
    max_iter = 100;
  endif

  % Verificación de raíces exactas en los extremos
  if f(a) == 0
    fprintf('\nEl extremo a = %f es exactamente una raiz.\n', a);
    raiz = a; iter = 0; historial = [0, a, b, a, 0, 0]; return;
  endif
  if f(b) == 0
    fprintf('\nEl extremo b = %f es exactamente una raiz.\n', b);
    raiz = b; iter = 0; historial = [0, a, b, b, 0, 0]; return;
  endif

  % Verificación de Condiciones de Fourier
  fprintf('\n--- Verificacion de Condiciones de Fourier en [%.4f, %.4f] ---\n', a, b);

  if f(a) * f(b) > 0
    error('No se cumple Bolzano: f(a) y f(b) tienen el mismo signo.');
  else
    fprintf('Bolzano: Cumple (existe al menos una raiz).\n');
  endif

  % Evaluacion numerica de derivadas para verificar Fourier
  n_pts = 100;
  x_eval = linspace(a, b, n_pts);
  h = max(abs(b - a) * 1e-5, 1e-6);

  df_vals = (arrayfun(f, x_eval + h) - arrayfun(f, x_eval - h)) ./ (2 * h);
  d2f_vals = (arrayfun(f, x_eval + h) - 2 * arrayfun(f, x_eval) + arrayfun(f, x_eval - h)) ./ (h^2);

  if min(df_vals) * max(df_vals) > 0
    fprintf('Monotonia: Cumple (f''(x) no cambia de signo, raiz unica).\n');
  else
    fprintf('Monotonia: No cumple (f''(x) cambia de signo en el intervalo).\n');
  endif

  if min(d2f_vals) * max(d2f_vals) > 0
    fprintf('Concavidad: Cumple (f''''(x) no cambia de signo, concavidad constante).\n');
  else
    fprintf('Concavidad: No cumple (f''''(x) cambia de signo, posible punto de inflexion).\n');
  endif

  d2f_a = (f(a + h) - 2 * f(a) + f(a - h)) / (h^2);
  d2f_b = (f(b + h) - 2 * f(b) + f(b - h)) / (h^2);

  if f(a) * d2f_a > 0
    fprintf('Punto fijo de Fourier: x = %.4f (f(a)*f''''(a) > 0).\n', a);
  elseif f(b) * d2f_b > 0
    fprintf('Punto fijo de Fourier: x = %.4f (f(b)*f''''(b) > 0).\n', b);
  else
    fprintf('Punto fijo de Fourier: No determinado estrictamente.\n');
  endif
  fprintf('-----------------------------------------------------------------\n\n');

  iter = 0;
  x_act = a; % Punto de referencia inicial
  error_act = tol + 1; % Fuerza a entrar al bucle en la primera vuelta
  
  % Preasignamos memoria para el historial (iter, a, b, x_act, f(x_act), error_act)
  historial = zeros(max_iter, 6);

  while error_act > tol && iter < max_iter
    x_ant = x_act;

    % Formula de la secante / interpolacion lineal
    calculoSup = a * f(b) - b * f(a);
    calculoInf = f(b) - f(a);
    x_act = calculoSup / calculoInf;

    iter = iter + 1;

    % En la primera iteracion no se compara contra el valor inicial 'a'
    if iter > 1
      error_act = abs(x_act - x_ant);
      historial(iter, :) = [iter, a, b, x_act, f(x_act), error_act];
    else
      historial(iter, :) = [iter, a, b, x_act, f(x_act), NaN];
    endif

    % Verificacion de raiz exacta
    if f(x_act) == 0
      break;
    % Actualizacion del intervalo conservando el cambio de signo
    elseif f(a) * f(x_act) < 0
      b = x_act;
    else
      a = x_act;
    endif
  endwhile

  if iter >= max_iter
    warning('Se alcanzó el máximo de iteraciones sin llegar a la tolerancia.');
  endif
  
  % Imprimimos la tabla con el historial al finalizar
  historial = historial(1:iter, :);
  fprintf('\nMetodo de Interpolacion Lineal\n');
  fprintf('%-5s | %-12s | %-12s | %-12s | %-12s | %-12s\n', 'Iter', 'a', 'b', 'x_k', 'f(x_k)', 'Error Est.');
  fprintf('--------------------------------------------------------------------------------\n');
  for i = 1:size(historial, 1)
    if isnan(historial(i, 6))
      fprintf('%-5d | %12.6f | %12.6f | %12.6f | %12.6f | %12s\n', historial(i, 1), historial(i, 2), historial(i, 3), historial(i, 4), historial(i, 5), '-');
    else
      fprintf('%-5d | %12.6f | %12.6f | %12.6f | %12.6f | %12.6e\n', historial(i, 1), historial(i, 2), historial(i, 3), historial(i, 4), historial(i, 5), historial(i, 6));
    endif
  endfor
  fprintf('\nRaiz aproximada: x = %f (en %d iteraciones)\n', x_act, iter);

  raiz = x_act;
endfunction
