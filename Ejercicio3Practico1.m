clc
clear
close all

cantidadSecuencia = input("Ingrese cuantos numeros de la secuencia de fibonacci quiere ver: ");


x = 0;
y = 1;


for i=1:cantidadSecuencia-1

    if(x == 0 && y == 1)
        fprintf("Numero 1 de la secuencia: 0\n");
    endif
    suma = x + y;

    fprintf("Numero %d de la secuencia: %d\n",i+1,suma);
    x = y;
    y = suma;
end
