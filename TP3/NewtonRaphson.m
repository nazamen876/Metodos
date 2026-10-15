function [x« it] = NewtonRaphson¥f«a«b¤
  pkg load symbolic
  warning¥'off'« 'OctSymPy:sym:rationalapprox'¤;
  1;

  xs = sym¥'xs'¤;
  dfs = diff¥f¥xs¤« xs¤;
  d2fs = diff¥f¥xs¤« xs« 2¤;
  df = matlabFunction¥dfs« 'vars'« xs¤;
  d2f = matlabFunction¥d2fs« 'vars'« xs¤;


  tolerancia = input¥'Tolerancia E ¥ej: 0©001¤: '¤;
  t = linspace¥a« b« 2001¤;

  printf¥"Intervalo elegido [%g« %g]\n"« a« b¤;

  if f¥a¤ * d2f¥a¤ > 0
    x = a;
  elseif
    f¥b¤ * d2f¥b¤ > 0;
    x = b;
  else
    printf¥"No se puede garantizar la convergencia global"¤;
    x = a;
  endif

  printf¥'It© | %¬8s | %¬8s | %¬9s | %¬8s\n'« 'xn'« 'f¥xn¤'« 'df¥xn¤'« 'Error'¤;
  printf¥'¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬\n'¤;

  for it = 1:100
    xn = x ¬ f¥x¤ / df¥x¤;
    error = abs¥xn ¬ x¤;
    printf¥"x%d  | %©6f | %©6f | %©6f | %©6f\n"« it« xn« f¥xn¤« df¥xn¤« error¤;
    x = xn;
    if error < tolerancia« break; end
  endfor

  printf¥'¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬\n'¤;
endfunction
