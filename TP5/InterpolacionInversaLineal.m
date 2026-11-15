function x = InterpolacionInversaLineal(y, vectorX, vectorY)
  n = length(vectorY);

  % Encontrar el intervalo donde cae 'y' y calcular el paso 'h'
  indice = -1;
  h = 1;
  for i = 1 : n - 1
    if ((y >= vectorY(i) && y <= vectorY(i+1)) || (y <= vectorY(i) && y >= vectorY(i+1)))
      indice = i;
      h = vectorX(i+1) - vectorX(i);
      break;
    endif
  endfor

  % Validar que 'y' esté dentro del rango de la tabla
  if (indice == -1)
    error("El valor de y está fuera del rango de la tabla.");
  endif

  % Determinar si usar NG Ascendente o Descendente para la formula de interpolación lineal
  if (indice <= floor((n-1) / 2))
    x0 = vectorX(1);
    y0 = vectorY(1);
    dy0 = vectorY(2) - vectorY(1);

    x = (y - y0) / (dy0/h) + x0;
  else
    xn = vectorX(n);
    yn vectorY(n);
    dyn = vectorY(n) - vectorY(n-1);

    x = (y - yn) / (dyn/h) + xn;
  end

  fprintf('====================================================================================\n');
  fprintf('                            INTERPOLACION INVERSA LINEAL\n');
  fprintf('====================================================================================\n\n');

  printf("-- Tabla de diferencias\n")
  printf("x\t");
  for i=1 : length(vectorX)
    printf("%d\t", vectorX(i))
  endfor

  printf("\ny\t");
  for i=1 : length(vectorY)
    printf("%g\t", vectorY(i))
  endfor

  printf("\n\ny = %.4f\th = %d\n", y, h);
  printf("El valor de x para P(x) = %.4f es: %.4f\n", y, x);
endfunction

