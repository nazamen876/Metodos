clc
clear
close all
%{
numerosTotales = input("Ingrese la cantidad de numeros que desea sumar ");

sumaTotal = 0;

for i = 1:numerosTotales
  x = input("Ingrese un numero a sumar");
  sumaTotal += x;
end
fprintf("La suma total es: %.2f\n", sumaTotal);
%}

sumaN255 = 0;

for i = 0:255
  x = i;
  sumaN255 += x;
end
fprintf("La suma total es: %.2f\n", sumaN255);

sumaN10000 = 0;

for i = 0:10000
  x = i;
  sumaN10000 += x;
end
fprintf("La suma total es: %.2f\n", sumaN10000);
