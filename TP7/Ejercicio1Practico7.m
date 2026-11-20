clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 7 - EJERCICIO 1
% Comparacion entre Euler y Euler Modificado
% EDO: y' = x^2 + y^2,  con y(0) = 1, h = 0.2 en (0; 0.6)
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 7 - EJERCICIO 1\n');
fprintf('         METODOS QUE SE INICIAN POR SI MISMOS: EULER Y MODIFICADO\n');
fprintf('======================================================================\n\n');

% Definicion del PVI:
f = @(x, y) x.^2 + y.^2;
x0 = 0.0;
y0 = 1.0;
h  = 0.2;
xf = 0.6;
tol = 0.001;   % Error < 0.001 segun consigna

fprintf('Ecuacion diferencial: y'' = x^2 + y^2\n');
fprintf('Condicion inicial:    y(%.1f) = %.1f\n', x0, y0);
fprintf('Intervalo:            (%.1f; %.1f]\n', x0, xf);
fprintf('Paso de integracion:  h = %.2f\n', h);
fprintf('Tolerancia pedida:    E < %.4f\n\n', tol);

% ------------------------------------------------------------------------------
% a) Resolver utilizando el Metodo de Euler
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE a) RESOLUCION MEDIANTE EL METODO DE EULER\n');
fprintf('----------------------------------------------------------------------\n');
[X_eul, Y_eul] = euler(f, x0, y0, h, xf);

% ------------------------------------------------------------------------------
% b) Resolver utilizando el Metodo Modificado de Euler con E < 0.001
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE b) RESOLUCION MEDIANTE EULER MODIFICADO (E < 0.001)\n');
fprintf('----------------------------------------------------------------------\n');
[X_eulMod, Y_eulMod] = eulerModificado(f, x0, y0, h, xf, tol);

% ------------------------------------------------------------------------------
% Comparacion de resultados
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('             COMPARACION DE RESULTADOS: EULER vs MODIFICADO\n');
fprintf('======================================================================\n');
fprintf('    x   |  Euler simple  | Euler Modificado | Diferencia absoluta\n');
fprintf('  ------|----------------|------------------|--------------------\n');
for i = 1:length(X_eul)
  dif = abs(Y_eul(i) - Y_eulMod(i));
  fprintf('  %5.2f |   %12.6f |     %12.6f |      %12.6f\n', ...
          X_eul(i), Y_eul(i), Y_eulMod(i), dif);
endfor
fprintf('======================================================================\n\n');
fprintf('Conclusiones:\n');
fprintf('- Euler simple usa la pendiente al inicio de cada intervalo, cometiendo\n');
fprintf('  un error de truncamiento global de orden O(h).\n');
fprintf('- Euler Modificado promedia las pendientes de los extremos y corrige\n');
fprintf('  iterativamente, alcanzando un orden O(h^2), lo que arroja valores\n');
fprintf('  mas exactos y estables frente a la no linealidad (x^2 + y^2).\n');
fprintf('======================================================================\n');
