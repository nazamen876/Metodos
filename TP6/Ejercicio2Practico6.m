clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 6 - EJERCICIO 2
% Integracion numerica: Trapecios vs Simpson 1/3
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 6 - EJERCICIO 2\n');
fprintf('         INTEGRACION NUMERICA: SELECCION ADECUADA DE METODOS\n');
fprintf('======================================================================\n\n');

% Tabla de valores dada:
t = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5];
i = [0.0, 0.15, 0.3, 0.55, 0.73, 0.81];

n_total = length(t) - 1;   % 6 puntos -> 5 subintervalos
h = t(2) - t(1);

fprintf('Tabla de valores dada:\n');
fprintf('  t (s): '); fprintf('%10.2f ', t); fprintf('\n');
fprintf('  i (A): '); fprintf('%10.2f ', i); fprintf('\n\n');

fprintf('Analisis del problema:\n');
fprintf('  Cantidad de puntos          = %d\n', length(t));
fprintf('  Cantidad de subintervalos n = %d\n', n_total);
fprintf('  Paso constante h            = %.4f\n\n', h);
fprintf('  Observacion teorica:\n');
fprintf('  - La regla de Trapecios se puede aplicar directamente sobre los 5 subintervalos.\n');
fprintf('  - La regla de Simpson 1/3 REQUIERE n PAR (por ejemplo n = 2 o n = 4).\n');
fprintf('  - Como n = 5 es impar, Simpson 1/3 NO puede cubrir todo el intervalo por si solo.\n');
fprintf('  - Por lo tanto, para obtener la mejor precision se puede COMBINAR formulas:\n');
fprintf('      Opcion A: Simpson 1/3 en [0.0, 0.4] (4 subint) + Trapecio en [0.4, 0.5] (1 subint)\n');
fprintf('      Opcion B: Trapecio en [0.0, 0.1] (1 subint) + Simpson 1/3 en [0.1, 0.5] (4 subint)\n\n');

% ------------------------------------------------------------------------------
% 1) Metodo de Trapecios puro (sobre los 5 subintervalos)
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('1) APLICACION DE LA REGLA DE TRAPECIOS COMPUESTA (n = 5)\n');
fprintf('----------------------------------------------------------------------\n');
I_trap = trapecios(t, i);

% ------------------------------------------------------------------------------
% 2) Combinacion de formulas: Simpson 1/3 + Trapecio
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('2) COMBINACION DE FORMULAS (Simpson 1/3 en [0, 0.4] + Trapecio en [0.4, 0.5])\n');
fprintf('----------------------------------------------------------------------\n');
% Tramo 1: t = 0 a 0.4 (indices 1 a 5, 4 subintervalos -> par, aplicable Simpson 1/3)
t_simp = t(1:5);
i_simp = i(1:5);
fprintf('Tramo 1: Simpson 1/3 en [%.2f, %.2f] (n = 4 subintervalos):\n', t_simp(1), t_simp(end));
I_simp_tramo1 = simpson13(t_simp, i_simp);

% Tramo 2: t = 0.4 a 0.5 (indices 5 a 6, 1 subintervalo -> regla del Trapecio)
t_trap = t(5:6);
i_trap = i(5:6);
fprintf('Tramo 2: Trapecio simple en [%.2f, %.2f] (n = 1 subintervalo):\n', t_trap(1), t_trap(end));
I_trap_tramo2 = trapecios(t_trap, i_trap);

I_comb_A = I_simp_tramo1 + I_trap_tramo2;

% ------------------------------------------------------------------------------
% Comparacion y conclusiones
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('                   COMPARACION DE RESULTADOS (EJ. 2)\n');
fprintf('======================================================================\n');
fprintf('  a) Trapecios compuesto (n = 5):                 I = %12.6f\n', I_trap);
fprintf('  b) Combinacion Simpson 1/3 (n=4) + Trap (n=1):  I = %12.6f\n', I_comb_A);
fprintf('     - Tramo Simpson 1/3 [0.0, 0.4]:              I1 = %12.6f\n', I_simp_tramo1);
fprintf('     - Tramo Trapecio    [0.4, 0.5]:              I2 = %12.6f\n', I_trap_tramo2);
fprintf('  Diferencia entre ambos enfoques:                Dif = %12.6f\n\n', abs(I_trap - I_comb_A));
fprintf('  Conclusion:\n');
fprintf('  La combinacion Simpson 1/3 + Trapecio es superior porque Simpson 1/3\n');
fprintf('  posee un orden de error O(h^4) frente al O(h^2) de los Trapecios,\n');
fprintf('  aprovechando la maxima cantidad posible de subintervalos pares.\n');
fprintf('======================================================================\n');
