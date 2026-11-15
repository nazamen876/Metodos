function P = InterpolacionInversaCuadratica(y, vectorX, vectorY)
  %{
    Devuelve los valores de x para un determinado argumento y

    Parámetros:
      y : Valor a partir del cual tiene que determinarse su correspondiente x
      vectorX : valores de X en la tabla de valores
      vectorY : valores Y correspondientes a X en la tabla de valores
  %}
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


  fprintf('================================================================================================\n');
  fprintf('                                INTERPOLACION INVERSA CUADRATICA\n');
  fprintf('================================================================================================\n\n');

  printf("-- Tabla de diferencias\n")
  printf("x\t");
  for i=1 : length(vectorX)
    printf("%d\t", vectorX(i))
  endfor

  printf("\ny\t");
  for i=1 : length(vectorY)
    printf("%g\t", vectorY(i))
  endfor
  printf("\n\n");


  % Determinar si usar NG Ascendente o Descendente para la formula de interpolación lineal
  if (indice <= floor((n-1) / 2))
    x0 = vectorX(1);
    y0 = vectorY(1);
    dif = tablaDiferencias(vectorX, vectorY);

    a = dif(3) / (2 * h^2);
    b = dif(2)/h - dif(3)/(2*h) - (dif(3)*x0)/(h^2);
    c = (y0 - (dif(2)*x0)/h + (dif(3)*x0)/(2*h) + (dif(3)*x0^2)/(2*h^2)) - y;

    discriminante = b^2 - 4 * a * c;

    if (discriminante >= 0)
      x1 = (-b + sqrt(discriminante)) / (2 * a);
      x2 = (-b - sqrt(discriminante)) / (2 * a);

      printf("Raiz x1 = %g\n", x1);
      printf("Raiz x2 = %g\n", x2);
    else
      printf("Las raices son complejas");
    endif
  else
    xn = vectorX(n);
    yn vectorY(n);
    dif = tablaDiferenciasDesc(vectorX, vectorY);

    a = dif(3) / (2 * h^2);
    b = dif(2)/h + dif(3)/(2*h) - (dif(3)*xn)/(h^2);
    c = (yn - (dif(2)*xn)/h - (dif(3)*xn)/(2*h) + (dif(3)*xn^2)/(2*h^2)) - y;

    discriminante = b^2 - 4 * a * c;

    if (discriminante >= 0)
      x1 = (-b + sqrt(discriminante)) / (2 * a);
      x2 = (-b - sqrt(discriminante)) / (2 * a);

      printf("Raiz x1 = %g\n", x1);
      printf("Raiz x2 = %g\n", x2);
    else
      printf("Las raices son complejas");
    endif
  end
  printf("wep");


endfunction
