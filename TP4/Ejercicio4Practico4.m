clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 4 - EJERCICIO 4 (SISTEMAS NO HOMOGENEOS)
% Produccion de Componentes Electronicos (Transistores, Resistores, Chips)
%
% Materiales disponibles:
%   Cobre:  960 unidades
%   Zinc:   510 unidades
%   Vidrio: 610 unidades
%
% Requerimientos por componente:
%   Transistores (x1): 4.3 Cobre, 1.0 Zinc, 2.0 Vidrio
%   Resistores   (x2): 3.0 Cobre, 3.0 Zinc, 1.0 Vidrio
%   Chips comp.  (x3): 2.0 Cobre, 1.0 Zinc, 3.0 Vidrio
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 4 - EJERCICIO 4\n');
fprintf('======================================================================\n\n');

% ------------------------------------------------------------------------------
% a) Planteo del sistema de ecuaciones
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE a) PLANTEO DEL SISTEMA DE ECUACIONES:\n');
fprintf('----------------------------------------------------------------------\n');
fprintf('Definicion de variables (unidades a producir de cada componente):\n');
fprintf('  x1: Cantidad de Transistores\n');
fprintf('  x2: Cantidad de Resistores\n');
fprintf('  x3: Cantidad de Chips de computadora\n\n');

fprintf('Ecuaciones de balance de materiales:\n');
fprintf('  (Cobre) : 4.3*x1 + 3.0*x2 + 2.0*x3 = 960\n');
fprintf('  (Zinc)  : 1.0*x1 + 3.0*x2 + 1.0*x3 = 510\n');
fprintf('  (Vidrio): 2.0*x1 + 1.0*x2 + 3.0*x3 = 610\n\n');

A = [ 4.3, 3.0, 2.0;
      1.0, 3.0, 1.0;
      2.0, 1.0, 3.0 ];

b = [ 960;
      510;
      610 ];

M = [A b];

% ------------------------------------------------------------------------------
% b) Aplicacion de los diferentes metodos de resolucion
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE b) APLICACION DE DIFERENTES METODOS DE RESOLUCION:\n');
fprintf('----------------------------------------------------------------------\n\n');

% 1) Eliminacion de Gauss
fprintf('>>> 1) METODO DE ELIMINACION DE GAUSS:\n');
[x_gauss, ~] = gauss(M);

% 2) Gauss-Jordan
fprintf('>>> 2) METODO DE GAUSS-JORDAN:\n');
[x_gj, ~] = gaussJordan(M);

% 3) Descomposicion LU
fprintf('>>> 3) METODO DE DESCOMPOSICION LU:\n');
[~, ~, x_lu] = descomposicionLU(A, b);

% 4) Gauss-Seidel (con reordenamiento si fuera necesario)
fprintf('>>> 4) METODO DE GAUSS-SEIDEL:\n');
[x_gs, k_gs, ~] = GaussSeidel(A, b, [0; 0; 0], 1e-4, 50);

% Solucion de referencia de Octave
x_ref = A \ b;

% ------------------------------------------------------------------------------
% Comparacion de resultados y analisis
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('         COMPARACION DE RESULTADOS ENTRE TODOS LOS METODOS\n');
fprintf('======================================================================\n');
fprintf('  Variable |  Gauss    | Gauss-Jordan | Factoriz LU | Gauss-Seidel | Octave A\\b\n');
fprintf('  ---------|-----------|--------------|-------------|--------------|-----------\n');
for i = 1:3
  fprintf('     x%d    | %9.4f | %12.4f | %11.4f | %12.4f | %9.4f\n', ...
          i, x_gauss(i), x_gj(i), x_lu(i), x_gs(i), x_ref(i));
endfor
fprintf('======================================================================\n\n');

fprintf('RESPUESTA AL PROBLEMA DE PRODUCCION:\n');
fprintf('  - Transistores a fabricar (x1): %8.2f unidades\n', x_gauss(1));
fprintf('  - Resistores a fabricar   (x2): %8.2f unidades\n', x_gauss(2));
fprintf('  - Chips de comp. a fabricar(x3): %8.2f unidades\n\n', x_gauss(3));

fprintf('ANALISIS COMPARATIVO DE METODOS:\n');
fprintf('  - Metodos Directos (Gauss, Gauss-Jordan, LU):\n');
fprintf('    Arrojan la solucion exacta en un numero finito de pasos.\n');
fprintf('    Gauss requiere ~2/3 n^3 operaciones, mientras que Gauss-Jordan requiere ~n^3.\n');
fprintf('    La factorizacion LU es ideal si el vector de suministros b cambia semana a semana,\n');
fprintf('    ya que solo se factoriza A una vez y luego se resuelven sustituciones en O(n^2).\n');
fprintf('  - Metodo Iterativo (Gauss-Seidel):\n');
fprintf('    Aproxima la solucion progresivamente y convergio en %d iteraciones.\n', k_gs);
fprintf('======================================================================\n');
