function P = NGDescendente(x, vectorX, vectorY)
  %{
    Función de la fórmula de Gregory-Newton Descendente, devuelve un P(x) para su x correspondiente

    Parámetros:
      x : Valor para el que se interpola
      vectorX : Valores de la tabla de valores de X
      vectorY : Valores de y correspondientes a X en la tabla de valores
  %}

  fprintf('====================================================================\n');
  fprintf('                NEWTON GREGORY DESCENDENTE\n');
  fprintf('====================================================================\n');

  printf("-- Tabla de Valores\n");
  printf("x\t");
  for i=1 : length(vectorX)
    printf("%d\t", vectorX(i))
  endfor

  printf("\nf(x)\t");
  for i=1 : length(vectorY)
    printf("%g\t", vectorY(i))
  endfor
  printf("\n\n");

  dif = tablaDiferenciasDesc(vectorX, vectorY);
  h = vectorX(2) - vectorX(1);
  n = length(vectorX);
  u = (x - vectorX(n)) / h;


  printf("\nSabiendo que xn = %g y h = %g entonces u = %g\n", vectorX(n), h, u);

  P = 0;
  producto = 1;
  for i = 1 : length(dif)
      P = P + dif(i) / factorial(i-1) * producto;
      producto = producto * (u + (i-1));
  end

  printf("El valor de P(%g) es: %g\n", x, P);
endfunction
