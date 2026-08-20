clc
clear
close all

%Fn = Fn-1 + Fn-2 con F1 = 0 (o 1), F2 = 1.
cantidadSecuencia = input("Ingrese cuantos numeros de la secuencia de fibonacci quiere ver: ");


x = 0;
y = 1;


for i=1:cantidadSecuencia-2

    if(x == 0 && y == 1)
        fprintf("Numero 1 de la secuencia: 0\n");
        fprintf("Numero 2 de la secuencia: 1\n");
    endif
    suma = x + y;

    fprintf("Numero %d de la secuencia: %d\n",i+2,suma);
    x = y;
    y = suma;
end
