function dif = tablaDiferenciasDesc(vectorX, vectorY)
  %{
    Devuelve el valor yn para la tabla de diferencias.

    Parámetros:
      vectorX : Valores de la tabla de valores de X
      vectorY : Valores de y correspondientes a X en la tabla de valores
   %}

  n = length(vectorY);

  D = zeros(n, n);
  D(:, 1) = vectorY(:);
  for i=2 : n
    for j=1 : (n-i + 1)
      D(j, i) = D(j+1, i-1) - D(j, i-1);
    endfor
  endfor

  dif = zeros(1, n);
  for i=1 : n
    dif(i) = D(n-i+1, i);
  endfor

  % Impresion de los datos
  printf("-- Tabla de diferencias\n");

  for i=0 : length(vectorY)-1
    if i >= 2
      printf("d^%dyn\t", i);
    elseif i == 1
      printf("dyn\t");
    else
      printf("yn\t");
    endif
  endfor

  printf("\n");

  for i=1 : length(vectorY)
    printf("%g\t", dif(i));
  endfor

  printf("\n");
endfunction
