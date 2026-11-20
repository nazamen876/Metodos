clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 6 - EJERCICIO 3
% Calculo de la integral de f(x) en [12, 17] con tabla del Ejercicio 1
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 6 - EJERCICIO 3\n');
fprintf('  INTEGRACION EN [12, 17]: SELECCION ENTRE TRAPECIOS Y SIMPSON\n');
fprintf('======================================================================\n\n');

% Tabla de valores del ejercicio 1:
x = [12, 13, 14, 15, 16, 17];
y = [0.96262, 0.94718, 0.93108, 0.92221, 0.91181, 0.90151];

n_total = length(x) - 1;   % 5 subintervalos
h = x(2) - x(1);          % h = 1

fprintf('Datos disponibles (del Ejercicio 1):\n');
fprintf('  x: '); fprintf('%10.2f ', x); fprintf('\n');
fprintf('  y: '); fprintf('%10.5f ', y); fprintf('\n\n');
fprintf('  Cantidad de subintervalos n = %d (Paso h = %.2f)\n\n', n_total, h);

fprintf('Analisis de seleccion de metodos:\n');
fprintf('  1) Trapecios: Se puede aplicar de forma directa sobre los 5 subintervalos.\n');
fprintf('  2) Simpson 1/3 puro: No se puede aplicar a todo el intervalo porque n = 5 es impar.\n');
fprintf('  3) Simpson 3/8 puro: No se puede aplicar a todo el intervalo porque n = 5 no es multiplo de 3.\n');
fprintf('  4) Combinacion Trapecio + Simpson 1/3: Aplicar Simpson 1/3 en [12, 16] (4 subint)\n');
fprintf('     y Trapecio en [16, 17] (1 subint).\n\n');

% ------------------------------------------------------------------------------
% 1) Metodo de los Trapecios puro
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('1) CALCULO MEDIANTE REGLA DE LOS TRAPECIOS (n = 5)\n');
fprintf('----------------------------------------------------------------------\n');
I_trap = trapecios(x, y);

% ------------------------------------------------------------------------------
% 2) Combinacion Simpson 1/3 (n = 4) + Trapecio (n = 1)
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('2) CALCULO COMBINADO: SIMPSON 1/3 [12, 16] + TRAPECIO [16, 17]\n');
fprintf('----------------------------------------------------------------------\n');
x_s13 = x(1:5);   % [12, 13, 14, 15, 16] -> 4 subintervalos
y_s13 = y(1:5);
fprintf('Tramo 1: Simpson 1/3 en [%.2f, %.2f]:\n', x_s13(1), x_s13(end));
I_s13 = simpson13(x_s13, y_s13);

x_tr = x(5:6);    % [16, 17] -> 1 subintervalo
y_tr = y(5:6);
fprintf('Tramo 2: Trapecio en [%.2f, %.2f]:\n', x_tr(1), x_tr(end));
I_tr = trapecios(x_tr, y_tr);

I_comb = I_s13 + I_tr;

fprintf('======================================================================\n');
fprintf('                   RESUMEN DE RESULTADOS EJERCICIO 3\n');
fprintf('======================================================================\n');
fprintf('  Integral por Trapecios (puro, n = 5):          I = %12.6f\n', I_trap);
fprintf('  Integral por Simpson 1/3 (n=4) + Trapecio (n=1): I = %12.6f\n', I_comb);
fprintf('  Diferencia absoluta:                            Dif = %12.6f\n', abs(I_trap - I_comb));
fprintf('======================================================================\n');
