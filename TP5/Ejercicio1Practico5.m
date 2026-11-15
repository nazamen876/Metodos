%{
  Interpolación en intervalos regularmente espaciados. Data la siguiente tabla de valores:
    x 15        25        35        45        55        65
    y 0.965926  0,906308  0,819152  0,707107  0,573576  0,422618
%}
clear; clc;

opcion = input("Que formula desea mostrar?\n\
                1 - Newton-Gregory Ascendente\n\
                2 - Newton Gregory Descendente\n\
                3 - Interpolacion Inversa Lineal y Cuadratica\n\
                Elija una: ");

vectorX = [0 5 10 15];
vectorY = [1.792 1.519 1.308 1.140];

switch (opcion)
  case 1
    %a. Utilice la fórmula de Newton-Gregory Ascendente para hallar el valor de x = 17.
    dif = tablaDiferencias(vectorX, vectorY);
    NGAscendente(0.35, vectorX, dif);
  case 2
    %b. Aplique la fórmula de Newton-Gregory Descendente y hallar el valor de 𝑥 = 60.
    NGDescendente(60, vectorX, vectorY);
  case 3
    %c. Determine el valor de x que corresponde a 𝑦 = 0.90728517 usando Interpolación Inversa - Lineal y Cuadrática.
    InterpolacionInversaLineal(1.702, vectorX, vectorY);
    InterpolacionInversaCuadratica(1.702, vectorX, vectorY);
  otherwise
    printf("Error: Seleccione una de las opciones (1-3)\n");
endswitch










% c. Determine el valor de x que corresponde a y = 0.90728517 usando Interpolación Inversa - Lineal y Cuadrática
%y = 0.90728517;
%y = input("Ingrese el valor de y: ");

%vectorX = [15 25 35 45 55 65];
%vectorY = [0.965926 0.906308 0.819152 0.707107 0.573576 0.422618];

% vectorX = input("Intervalos del eje x: ");
% vectorY = input("Intervalos del eje y: ");

%InterpolacionInversaLineal(y, vectorX, vectorY);
%printf("\n");



