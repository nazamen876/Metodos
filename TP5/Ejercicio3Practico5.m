%{
  3. Dada la siguiente tabla:
    x 0 0.4     0.75    1.5     2
    y 1 1.63246 1.86603 2.22474 2.41421

    a. Exprese la forma del polinomio interpolante de Lagrange. Interpolar el valor correspondiente a x = 1.
    b. Determine el valor de y correspondiente a x = 0.45 aplicando el método de Lagrange.
%}

clc; clear;

vectorX = [0 0.4      0.75    1.5     2];
vectorY = [1 1.63246  1.86603 2.22474 2.41421];

printf("-- Tabla de valores\n")
  printf("x\t");
  for i=1 : length(vectorX)
    printf("%d\t", vectorX(i))
  endfor

  printf("\ny\t");
  for i=1 : length(vectorY)
    printf("%g\t", vectorY(i))
  endfor
  printf("\n\n");

% -- a. Interpolado para x = 1.
printf("-- a. Interpolacion para X = 1.\n")
Lagrange(1, vectorX, vectorY);

% -- b. Interpolado para x = 0.45
printf("-- a. Interpolacion para X = 0.45.\n")
Lagrange(0.45, vectorX, vectorY);


