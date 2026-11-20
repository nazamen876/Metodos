clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 7 - EJERCICIO 3
% Metodos de Runge-Kutta de 2do y 4to Orden
% EDO: y' = x^2 + y^2, con y(0) = 1, h = 0.2 en (0; 0.6)
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 7 - EJERCICIO 3\n');
fprintf('          METODOS DE RUNGE-KUTTA DE 2DO Y 4TO ORDEN (RK2 Y RK4)\n');
fprintf('======================================================================\n\n');

f = @(x, y) x.^2 + y.^2;
x0 = 0.0;
y0 = 1.0;
h  = 0.2;
xf = 0.6;

% ------------------------------------------------------------------------------
% a) Metodo de Runge-Kutta de 2do Orden
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE a) RESOLUCION CON RUNGE-KUTTA DE 2DO ORDEN (RK2)\n');
fprintf('----------------------------------------------------------------------\n');
[X_rk2, Y_rk2] = rungeKutta2(f, x0, y0, h, xf);

% ------------------------------------------------------------------------------
% b) Metodo de Runge-Kutta de 4to Orden
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE b) RESOLUCION CON RUNGE-KUTTA DE 4TO ORDEN (RK4)\n');
fprintf('----------------------------------------------------------------------\n');
[X_rk4, Y_rk4] = rungeKutta4(f, x0, y0, h, xf);

% Resolver tambien con Euler Modificado del Ejercicio 1.b para comparar
[X_em, Y_em] = eulerModificado(f, x0, y0, h, xf, 0.001);

% ------------------------------------------------------------------------------
% c) Comparacion y conclusiones
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('    PARTE c) COMPARACION: RUNGE-KUTTA 2DO ORDEN vs EULER MODIFICADO vs RK4\n');
fprintf('======================================================================\n');
fprintf('    x   |  RK 2do Orden  | Euler Modificado |  RK 4to Orden  | Dif |RK2 - EM|\n');
fprintf('  ------|----------------|------------------|----------------|---------------\n');
for i = 1:length(X_rk2)
  dif = abs(Y_rk2(i) - Y_em(i));
  fprintf('  %5.2f |   %12.6f |     %12.6f |   %12.6f |   %12.6e\n', ...
          X_rk2(i), Y_rk2(i), Y_em(i), Y_rk4(i), dif);
endfor
fprintf('======================================================================\n\n');
fprintf('Conclusiones:\n');
fprintf('- RK2 y Euler Modificado (Heun sin iteracion) son de orden O(h^2).\n');
fprintf('  La pequena discrepancia surge de que Euler Modificado itera el corrector\n');
fprintf('  hasta convergencia (tolerancia 0.001).\n');
fprintf('- RK4 posee un orden O(h^4), siendo el estandar de referencia en exactitud\n');
fprintf('  debido a las cuatro evaluaciones de derivadas ponderadas por paso.\n');
fprintf('======================================================================\n');
