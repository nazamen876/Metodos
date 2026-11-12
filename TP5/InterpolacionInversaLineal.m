function x = InversaLineal(y, vectorX, vectorY, h)
  x0 = vectorX(1);

  y0 = vectorY(1);
  dy0 = vectorY(2) - vectorY(1);

  x = (y - y0) / (dy0/h) + x0;

  printf("El valor de x para P(x) es: %.4f", x);
endfunction

