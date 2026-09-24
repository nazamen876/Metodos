function [raiz, iter] = interpolacionLineal(f, a, b, tol, max_iter)
  if f(a) * f(b) >= 0
    error('La funcion no cambia de signo en el intervalo [a,b].');
  endif

  iter = 0;
  x_act = a; % Punto de referencia inicial
  error_act = tol + 1; % Fuerza a entrar al bucle en la primera vuelta

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

  raiz = x_act;
endfunction
