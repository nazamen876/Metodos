clear; clc;

%Matriz Ejercicio
% A = [80 15 35 60; 28 72 57 25; 20 20 12 20; 50 10 20 60]
% b = [230; 180; 80; 160]

dig = 3;    % cifras significativas de la aritmética (0 = precisión completa)

A = input('Matriz de coeficientes A, ej [2 1 -1; -3 -1 2; -2 1 2]: ');
b = input('Columna de términos independientes b, ej [8; -11; -3]: ');
b = b(:);   %Pasa a columna en caso de ingresar como fila
n = size(A, 1);
if size(A, 2) != n
  disp('A tiene que ser cuadrada (misma cantidad de ecuaciones que de incógnitas).');
  return;
endif
if numel(b) != n
  disp('b tiene que tener un elemento por cada ecuación.');
  return;
endif

M = [A b];    % matriz aumentada

printf('\nMatriz aumentada:\n');
disp(M);

x = gauss(M, dig);

printf('Solución por Gauss (%d dígitos):\n', dig);
for i = 1:n
  printf('  x%d = %.4f\n', i, x(i));
endfor

% Verificación con el método propio de Octave (solo para comparar)
x_ref = A \ b;
printf('\nVerificación sin redondeo (A\\b):\n');
for i = 1:n
  printf('  x%d = %.4f\n', i, x_ref(i));
endfor

c = [18 5 7 20];     % costo por kg: maíz, desperdicios, alfalfa, cebada
costo = c * x;       % fila por columna = suma de los productos
printf('\nCosto de la mezcla: $ %.2f\n', costo);
