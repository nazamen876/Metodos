function P = Lagrange(x, vectorX, vectorY)
  n = length(vectorX);

  % Se verifica si x coincide con algun nodo para evitar la división por cero
  for i=1 : n
    if x == vectorX(i);
      return;
    endif
  endfor

  % Calculo del producto global
  producto = 1;
  for k=1 : n
    producto = producto * (x - vectorX(k));
  endfor

  % Calculo de la sumatoria
  suma = 0;
  for i=1 : n
    denominadorI = 1;
    for j=1 : n
      if j != i
        denominadorI = denominadorI * (vectorX(i) - vectorX(j));
      endif
    endfor
    suma = suma + vectorY(i) / ((x - vectorX(i)) * denominadorI);
  endfor

  % Despeje del valor final
  printf("P(%g)/%d = %.10f\n", x, producto, suma);
  printf("P(%g) = %.10f * %d\n", x, suma, producto);
  P = producto * suma;

  printf("P(%g) = %g\n\n", x, P);

  printf("El valor interpolado correspondiente a %g es: %g\n", x, P);

endfunction
