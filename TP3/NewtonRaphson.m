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

  %{
  if f(a) * d2f(a) > 0
    x = a;
  elseif
    f(b) * d2f(b) > 0;
    x = b;
  else
    printf("No se puede garantizar la convergencia global\n");
    x = a;
  endif
  %}

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
