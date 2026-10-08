function [raiz, iter] = interpolacionLineal(f, a, b, tol, max_iter)

  if nargin < 5
    max_iter = 100;
  endif

  if f(a) * f(b) >= 0
    error('La funcion no cambia de signo en el intervalo [a,b].');
  endif

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
  fprintf('\n>>> METODO DE INTERPOLACION LINEAL <<<\n');
  fprintf('%-5s | %-12s | %-12s | %-12s | %-12s | %-12s\n', 'Iter', 'a', 'b', 'x_k', 'f(x_k)', 'Error Est.');
  fprintf('--------------------------------------------------------------------------------\n');
  for i = 1:size(historial, 1)
    if isnan(historial(i, 6))
      fprintf('%-5d | %12.6f | %12.6f | %12.6f | %12.6f | %12s\n', historial(i, 1), historial(i, 2), historial(i, 3), historial(i, 4), historial(i, 5), '-');
    else
      fprintf('%-5d | %12.6f | %12.6f | %12.6f | %12.6f | %12.6e\n', historial(i, 1), historial(i, 2), historial(i, 3), historial(i, 4), historial(i, 5), historial(i, 6));
    endif
  endfor
  fprintf('\nRaiz final aproximada: x = %f\n', x_act);

  raiz = x_act;
endfunction
