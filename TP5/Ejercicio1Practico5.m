%{
  Interpolación en intervalos regularmente espaciados. Data la siguiente tabla de valores:
    x 15        25        35        45        55        65
    y 0.965926  0,906308  0,819152  0,707107  0,573576  0,422618
%}


% c. Determine el valor de x que corresponde a y = 0.90728517 usando Interpolación Inversa - Lineal y Cuadrática
y = 0.90728517;
%y = input("Ingrese el valor de y: ");

vectorX = [15 25 35 45 55 65];
vectorY = [0.965926 0.906308 0.819152 0.707107 0.573576 0.422618];

% vectorX = input("Intervalos del eje x: ");
% vectorY = input("Intervalos del eje y: ");

for i=1 : length(vectorY)-1
  if (y > vectorY(i) && y < vectorY(i+1) || y < vectorY(i) && y > vectorY(i+1))
    h = vectorX(i+1) - vectorX(i);
    display(h);
  endif
endfor

InversaLineal(y, vectorX, vectorY, h)



