clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 7 - EJERCICIO 5
% Metodos que no se inician por si mismos: Metodo de Milne
% EDO: y' = x^2 + y^2, con y(0) = 1
% Puntos iniciales tomados de Runge-Kutta 2do Orden (Ejercicio 3.a)
% Calcular en x = 0.8 y x = 1.0
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 7 - EJERCICIO 5\n');
fprintf('         METODOS QUE NO SE INICIAN POR SI MISMOS: METODO DE MILNE\n');
fprintf('======================================================================\n\n');

f = @(x, y) x.^2 + y.^2;
h = 0.2;

% Generar los 4 valores iniciales mediante RK2 (Ejercicio 3.a)
fprintf('Generando los 4 puntos iniciales mediante Runge-Kutta 2do Orden:\n');
[x_rk2, y_rk2] = rungeKutta2(f, 0.0, 1.0, h, 0.6);

x_init = x_rk2(1:4);
y_init = y_rk2(1:4);
yp_init = zeros(4, 1);
for i = 1:4
  yp_init(i) = f(x_init(i), y_init(i));
endfor

% ------------------------------------------------------------------------------
% Tabla solicitada en el enunciado
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('TABLA COMPLETADA (SEGUN ENUNCIADO):\n');
fprintf('======================================================================\n');
fprintf('    x    |       y       |      y'' = x^2 + y^2\n');
fprintf('  -------|---------------|--------------------\n');
for i = 1:4
  fprintf('  %6.2f | %13.6f | %17.6f\n', x_init(i), y_init(i), yp_init(i));
endfor
fprintf('======================================================================\n\n');

% ------------------------------------------------------------------------------
% a) Calcular la solucion en x = 0.8 y x = 1.0 aplicando el Metodo de Milne
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('a) APLICACION DEL METODO DE MILNE HASTA x = 1.0\n');
fprintf('----------------------------------------------------------------------\n');
xf = 1.0;
[X_milne, Y_milne] = milne(f, x_init, y_init, h, xf);

% Comparar con RK4 como patron de referencia
[X_ref, Y_ref] = rungeKutta4(f, 0.0, 1.0, h, xf);

fprintf('======================================================================\n');
fprintf('        COMPARACION: METODO DE MILNE vs RUNGE-KUTTA 4TO ORDEN\n');
fprintf('======================================================================\n');
fprintf('    x   |   y (Milne)   |    y (RK4)    | Diferencia absoluta\n');
fprintf('  ------|---------------|---------------|--------------------\n');
for i = 1:length(X_milne)
  dif = abs(Y_milne(i) - Y_ref(i));
  fprintf('  %5.2f | %13.6f | %13.6f |      %12.6e\n', ...
          X_milne(i), Y_milne(i), Y_ref(i), dif);
endfor
fprintf('======================================================================\n\n');
fprintf('Conclusiones:\n');
fprintf('- El Metodo de Milne es un metodo multipaso predictor-corrector de orden 4.\n');
fprintf('- Su ventaja principal radica en que solo evalua f(x, y) 2 veces por paso\n');
fprintf('  (una en el predictor y otra en el corrector), frente a las 4 evaluaciones\n');
fprintf('  que demanda RK4, logrando igual orden de exactitud O(h^4) con menor costo.\n');
fprintf('======================================================================\n');
