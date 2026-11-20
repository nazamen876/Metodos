clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 6 - EJERCICIO 4
% Resolucion de la integral en [12, 17] combinando las dos formulas de Simpson
% (Simpson 1/3 + Simpson 3/8)
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 6 - EJERCICIO 4\n');
fprintf('       COMBINACION DE AMBAS FORMULAS DE SIMPSON (1/3 + 3/8)\n');
fprintf('======================================================================\n\n');

% Tabla de valores del ejercicio 1:
x = [12, 13, 14, 15, 16, 17];
y = [0.96262, 0.94718, 0.93108, 0.92221, 0.91181, 0.90151];

n_total = length(x) - 1;   % 5 subintervalos

fprintf('Analisis de descomposicion para 5 subintervalos:\n');
fprintf('  Total de subintervalos: n = 5.\n');
fprintf('  La combinacion ideal de formulas de Simpson se basa en la particion:\n');
fprintf('    5 = 2 + 3\n');
fprintf('    - 2 subintervalos -> se resuelven con Simpson 1/3 (requiere n par).\n');
fprintf('    - 3 subintervalos -> se resuelven con Simpson 3/8 (requiere n multiplo de 3).\n\n');
fprintf('  Existen dos formas posibles de ordenamiento:\n');
fprintf('    Opcion 1: Simpson 1/3 en [12, 14] (2 subint) + Simpson 3/8 en [14, 17] (3 subint)\n');
fprintf('    Opcion 2: Simpson 3/8 en [12, 15] (3 subint) + Simpson 1/3 en [15, 17] (2 subint)\n\n');

% ------------------------------------------------------------------------------
% OPCION 1: Simpson 1/3 en [12, 14] + Simpson 3/8 en [14, 17]
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('OPCION 1: SIMPSON 1/3 [12, 14] + SIMPSON 3/8 [14, 17]\n');
fprintf('----------------------------------------------------------------------\n');

% Tramo A: indices 1 a 3 (x = 12, 13, 14) -> 2 subintervalos
x_A = x(1:3);
y_A = y(1:3);
fprintf('Tramo A (Simpson 1/3 en [12, 14]):\n');
I_A = simpson13(x_A, y_A);

% Tramo B: indices 3 a 6 (x = 14, 15, 16, 17) -> 3 subintervalos
x_B = x(3:6);
y_B = y(3:6);
fprintf('Tramo B (Simpson 3/8 en [14, 17]):\n');
I_B = simpson38(x_B, y_B);

I_comb_1 = I_A + I_B;
fprintf('Resultado total Opcion 1: I = I_A + I_B = %.6f + %.6f = %12.6f\n\n', I_A, I_B, I_comb_1);

% ------------------------------------------------------------------------------
% OPCION 2: Simpson 3/8 en [12, 15] + Simpson 1/3 en [15, 17]
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('OPCION 2: SIMPSON 3/8 [12, 15] + SIMPSON 1/3 [15, 17]\n');
fprintf('----------------------------------------------------------------------\n');

% Tramo C: indices 1 a 4 (x = 12, 13, 14, 15) -> 3 subintervalos
x_C = x(1:4);
y_C = y(1:4);
fprintf('Tramo C (Simpson 3/8 en [12, 15]):\n');
I_C = simpson38(x_C, y_C);

% Tramo D: indices 4 a 6 (x = 15, 16, 17) -> 2 subintervalos
x_D = x(4:6);
y_D = y(4:6);
fprintf('Tramo D (Simpson 1/3 en [15, 17]):\n');
I_D = simpson13(x_D, y_D);

I_comb_2 = I_C + I_D;
fprintf('Resultado total Opcion 2: I = I_C + I_D = %.6f + %.6f = %12.6f\n\n', I_C, I_D, I_comb_2);

% Recuperar resultado de trapecios para comparar
I_trap = trapecios(x, y);

% ------------------------------------------------------------------------------
% Comparacion de todos los resultados
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('           COMPARACION GLOBAL DE RESULTADOS (EJERCICIOS 3 Y 4)\n');
fprintf('======================================================================\n');
fprintf('  1) Trapecios puro (n = 5):                           I = %12.6f\n', I_trap);
fprintf('  2) Simpson 1/3 + Simpson 3/8 (Opcion 1: [12-14]+[14-17]): I = %12.6f\n', I_comb_1);
fprintf('  3) Simpson 3/8 + Simpson 1/3 (Opcion 2: [12-15]+[15-17]): I = %12.6f\n', I_comb_2);
fprintf('  --------------------------------------------------------------------\n');
fprintf('  Diferencia entre las dos combinaciones de Simpson:   Dif = %12.6e\n', abs(I_comb_1 - I_comb_2));
fprintf('  Diferencia frente a Trapecios (Opcion 1 - Trap):      Dif = %12.6f\n\n', I_comb_1 - I_trap);
fprintf('  Conclusiones:\n');
fprintf('  - Al combinar Simpson 1/3 con Simpson 3/8 se logra cubrir la totalidad de\n');
fprintf('    los 5 subintervalos SIN recurrir a la regla de Trapecios.\n');
fprintf('  - Como ambas reglas de Simpson son de orden O(h^4) (grado de exactitud 3),\n');
fprintf('    la aproximacion es mucho mas precisa y de orden superior en todo el dominio.\n');
fprintf('  - Ambas particiones (2+3 y 3+2) arrojan resultados sumamente consistentes.\n');
fprintf('======================================================================\n');
