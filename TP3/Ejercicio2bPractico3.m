%{
  Aplicar el algoritmo diseñado del Método de Newton Raphson para
  aproximar los dos puntos a través del, con E<10-3, previamente analizar las
  condiciones de convergencia del método en los intervalos iniciales: [24 ; 26] y [250 ; 252].
%}

a = 0;
b = 0;
x = 0;

function [x, it] = NewtonRaphson(f,df,d2f,a,b,tolerancia)
  t = linspace(a, b, 2001);

  printf("Intervalo [%g, %g]\n", a, b);

  x = b;

  for it = 1:100
    xn = x - f(x) / df(x);
    error = abs(xn - x);
    printf("Iteracion %d: x = %.8f\tError: %.2e\n", it, xn, error);
    x = xn;
    if error < tolerancia, break; end
  endfor
endfunction

f = @(x) 8*x + 0.3*x.^2 - 0.0013*x.^3 - 372;
df = @(x) 8 + 0.6*x - 0.0039*x.^2;
d2f = @(x) 0.6 - 0.0078*x;
tolerancia = power(10, -3);

r1 = NewtonRaphson(f, df, d2f, 24, 26, tolerancia);
r2 = NewtonRaphson(f, df, d2f, 250, 252, tolerancia);
printf("r1 = %.6f\t f(r1) = %.2e\n", r1, f(r1));
printf("r2 = %.6f\t f(r2) = %.2e\n", r2, f(r2));




