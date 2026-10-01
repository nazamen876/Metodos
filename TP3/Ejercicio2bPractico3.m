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

f = @(x) 8*x + 0.3*x.^2 - 0.0013*x.^3 - 372;
df = @(x) 8 + 0.6*x - 0.0039*x.^2;
d2f = @(x) 0.6 - 0.0078*x;
tolerancia = power(10, -3);

clc;

% Tanteo %
dx = input("Incremento para el tanteo: ");
intervalos = tanteo(f, 0, 300, dx)

% Primer intervalo [24, 26] %
r1 = NewtonRaphson(f, df, d2f, 24, 26, tolerancia);
printf("r1 = %.6f\t f(r1) = %.2e\n", r1, f(r1));

% Segundo intervalo [250, 252] %
r2 = NewtonRaphson(f, df, d2f, 250, 252, tolerancia);
printf("r2 = %.6f\t f(r2) = %.2e\n", r2, f(r2));

% Gráfico de las raíces %
opcion = input("Graficar raices? (1. Si/2. No): ");
  if opcion == 1
    graficar_raices(f, 0, 300);
  endif








