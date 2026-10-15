function [x, it] = NewtonRaphson(f,a,b, tol)
  pkg load symbolic
  warning('off', 'OctSymPy:sym:rationalapprox');
  1;

  xs = sym('xs');
  dfs = diff(f(xs), xs);
  d2fs = diff(f(xs), xs, 2);
  df = matlabFunction(dfs, 'vars', xs);
  d2f = matlabFunction(d2fs, 'vars', xs);

  t = linspace(a, b, 2001);


  %--- Verificación de Condiciones de Fourier ---
  fprintf('\n--- Verificacion de Condiciones de Fourier en [%.4f, %.4f] ---\n', a, b);

  % Bolzano
  if f(a) * f(b) > 0
    error('No se cumple Bolzano: f(a) y f(b) tienen el mismo signo.');
  else
    fprintf('Bolzano: Cumple (existe al menos una raiz).\n');
  endif

  if all(df(t) > 0 || df(t) < 0)
    fprintf('Monotonia: Cumple (f''(x) no cambia de signo, raiz unica).\n');
  else
    fprintf('Monotonia: No cumple (f''(x) cambia de signo en el intervalo).\n');
  endif

  if all(d2f(t) > 0 || d2f(t) < 0)
    fprintf('Concavidad: Cumple (f''''(x) no cambia de signo, concavidad constante).\n');
  else
    fprintf('Concavidad: No cumple (f''''(x) cambia de signo, posible punto de inflexion).\n');
  endif

  % Condicion de Fourier para determinar el punto fijo
  if f(a) * d2f(a) > 0
    fprintf('Punto fijo de Fourier: x = %.4f (f(a)*f''''(a) > 0).\n', a);
    x = a;
  elseif f(b) * d2f(b) > 0
    fprintf('Punto fijo de Fourier: x = %.4f (f(b)*f''''(b) > 0).\n', b);
    x = b;
  else
    fprintf('Punto fijo de Fourier: No determinado estrictamente.\n');
    x = a;
  endif
  fprintf('-----------------------------------------------------------------\n\n');


  % Iteracion de Newton Raphson
  printf('It.  | %-8s | %-8s | %-9s | %-8s\n', 'xn', 'f(xn)', 'df(xn)', 'Error');
  printf('----------------------------------------------------------\n');

  for it = 1:100
    xn = x - f(x) / df(x);
    error = abs(xn - x);
    printf("x%d  | %.6f | %.6f | %.6f | %.6f\n", it, xn, f(xn), df(xn), error);
    x = xn;
    if error < tol, break; end
  endfor

  printf("\nRaiz aproximada %.6f en %d iteraciones\n", x, it);
endfunction
