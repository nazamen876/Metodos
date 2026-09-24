
function [raiz, iter] = biseccion (f, a, b, tol, max_iter)
  if f(a)*f(b) >= 0
    error('La funcion no cambia de signo en el intervalo [a,b].');
  endif

  iter = 0;
  while (b-a)/2 > tol && iter < max_iter
    c = (a+b)/2;

    if f(c) == 0
      break;
    elseif f(a)*f(c) < 0
      b = c;
    else
      a = c;
    endif

    iter = iter + 1;
  endwhile

  raiz = (a+b)/2;
endfunction
