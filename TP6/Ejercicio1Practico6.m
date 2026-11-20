clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 6 - EJERCICIO 1
% Derivacion numerica a partir de formulas de Newton-Gregory
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 6 - EJERCICIO 1\n');
fprintf('     DERIVACION NUMERICA (NEWTON-GREGORY ASCENDENTE Y DESCENDENTE)\n');
fprintf('======================================================================\n\n');

% Tabla de valores dada:
x_datos = [12, 13, 14, 15, 16, 17];
y_datos = [0.96262, 0.94718, 0.93108, 0.92221, 0.91181, 0.90151];

fprintf('Tabla de valores dada:\n');
fprintf('  x: '); fprintf('%10.2f ', x_datos); fprintf('\n');
fprintf('  y: '); fprintf('%10.5f ', y_datos); fprintf('\n\n');

% ------------------------------------------------------------------------------
% a) Construir la tabla de diferencias
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE a) CONSTRUCCION DE LA TABLA DE DIFERENCIAS\n');
fprintf('----------------------------------------------------------------------\n');
D = tablaDiferencias(x_datos, y_datos);

% ------------------------------------------------------------------------------
% b) Calcular f'(12) con la formula de Gregory Newton Ascendente
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE b) CALCULO DE f''(12) CON NEWTON-GREGORY ASCENDENTE\n');
fprintf('----------------------------------------------------------------------\n');
fprintf('Como x = 12 es el primer nodo de la tabla, u = (12 - 12)/h = 0.\n');
fprintf('Los terminos de orden superior se simplifican considerablemente.\n\n');
[df1_12, df2_12] = derivadaNGAscendente(12, x_datos, y_datos);

% ------------------------------------------------------------------------------
% c) Calcular f'(12.4). ¿Cual es la diferencia al utilizar la formula en ambos casos?
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE c) CALCULO DE f''(12.4) Y ANALISIS DE DIFERENCIAS\n');
fprintf('----------------------------------------------------------------------\n');
fprintf('Aqui x = 12.4 NO coincide con un nodo (u = (12.4 - 12)/1 = 0.4 != 0).\n');
fprintf('Se deben derivar y evaluar los polinomios en u = 0.4.\n\n');
[df1_12_4, df2_12_4] = derivadaNGAscendente(12.4, x_datos, y_datos);

fprintf('======================================================================\n');
fprintf('COMPARACION DE RESULTADOS EN INCISO b) y c):\n');
fprintf('  f''(12.0) = %12.6f\n', df1_12);
fprintf('  f''(12.4) = %12.6f\n', df1_12_4);
fprintf('  Diferencia f''(12.4) - f''(12.0) = %12.6f\n\n', df1_12_4 - df1_12);
fprintf('  Conclusion tecnica:\n');
fprintf('  - En x = 12, u = 0, por lo que la derivada se reduce a la formula simple:\n');
fprintf('    f''(x0) = (1/h) * [Delta y0 - (1/2)*Delta^2 y0 + (1/3)*Delta^3 y0 - ...]\n');
fprintf('  - En x = 12.4, u = 0.4 != 0, por lo que los polinomios en u aportan\n');
fprintf('    coeficientes dependientes del punto, capturando la variacion de la pendiente.\n');
fprintf('======================================================================\n\n');

% ------------------------------------------------------------------------------
% d) Utilizar la formula de Gregory Newton descendente para calcular f''(17)
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE d) CALCULO DE f''''(17) CON NEWTON-GREGORY DESCENDENTE\n');
fprintf('----------------------------------------------------------------------\n');
fprintf('Como x = 17 es el ultimo nodo de la tabla, se utiliza NG Descendente\n');
fprintf('con x_n = 17 (u = 0), evaluando diferencias hacia atras (nabla).\n\n');
[df1_17, df2_17] = derivadaNGDescendente(17, x_datos, y_datos);

fprintf('======================================================================\n');
fprintf('                   RESUMEN GENERAL EJERCICIO 1\n');
fprintf('======================================================================\n');
fprintf('  f''(12)  (NG Ascendente)  = %12.6f\n', df1_12);
fprintf('  f''(12.4)(NG Ascendente)  = %12.6f\n', df1_12_4);
fprintf('  f''''(17) (NG Descendente) = %12.6f\n', df2_17);
fprintf('======================================================================\n');
