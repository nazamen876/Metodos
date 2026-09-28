function [raiz, iter] = biseccion(f, a, b, tol, max_iter)
  if nargin < 5
    max_iter = 100;
  endif
  if f(a)*f(b) >= 0
    error('La funcion no cambia de signo en el intervalo [a,b].');
  endif

  iter = 0;
  c = a;                 % referencia inicial, igual que en interpolacionLineal
  error_act = tol + 1;

  while error_act > tol && iter < max_iter
    c_ant = c;
    c = (a+b)/2;
    iter = iter + 1;

    if iter > 1
      error_act = abs(c - c_ant);
    endif

    if f(c) == 0
      break;
    elseif f(a)*f(c) < 0
      b = c;
    else
      a = c;
    endif
  endwhile

  if error_act > tol
    warning('Se alcanzó el máximo de iteraciones sin llegar a la tolerancia.');
  endif
  raiz = c;
endfunction
