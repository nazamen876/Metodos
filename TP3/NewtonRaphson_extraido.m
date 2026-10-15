function [x, it] = NewtonRaphson_extraido(f,df,d2f,a,b,tolerancia)
  t = linspace(a, b, 2001);

  printf("Intervalo [%g, %g]\n", a, b);

  if f(b) * d2f(b) > 0
    x = b;
  else
    x = a;
  endif

  for it = 1:100
    xn = x - f(x) / df(x);
    error = abs(xn - x);
    printf("Iteracion %d: x = %.8f\tError: %.2e\n", it, xn, error);
    x = xn;
    if error < tolerancia, break; end
  endfor
endfunction
