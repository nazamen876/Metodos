clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 4 - EJERCICIO 2 (SISTEMAS NO HOMOGENEOS)
% Metodo de Gauss-Seidel y Analisis de Convergencia
%
% Sistema dado:
%    0.1*x1 + 7.0*x2 -  0.3*x3 = -19.30
%    3.0*x1 - 0.1*x2 -  0.2*x3 =   7.85
%    0.3*x1 - 0.2*x2 - 10.3*x3 = -19.30
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 4 - EJERCICIO 2\n');
fprintf('======================================================================\n\n');

% Sistema original tal como esta escrito en la guia:
A_orig = [ 0.1,  7.0,  -0.3;
           3.0, -0.1,  -0.2;
           0.3, -0.2, -10.3 ];

b_orig = [ -19.30;
             7.85;
           -19.30 ];

fprintf('Sistema original ingresado:\n');
fprintf('  [  0.1  7.0  -0.3 | -19.30 ]\n');
fprintf('  [  3.0 -0.1  -0.2 |   7.85 ]\n');
fprintf('  [  0.3 -0.2 -10.3 | -19.30 ]\n\n');

% ------------------------------------------------------------------------------
% 1. ANALISIS DE CONVERGENCIA DEL SISTEMA ORIGINAL
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('1. ANALISIS DE CONVERGENCIA DEL SISTEMA ORIGINAL:\n');
fprintf('----------------------------------------------------------------------\n');
fprintf('Criterio de Diagonal Estrictamente Dominante:\n');
fprintf('  Fila 1: |0.1|  < |7.0| + |-0.3| = 7.3  --> NO ES DOMINANTE\n');
fprintf('  Fila 2: |-0.1| < |3.0| + |-0.2| = 3.2  --> NO ES DOMINANTE\n');
fprintf('  Fila 3: |-10.3| > |0.3| + |-0.2| = 0.5 --> ES DOMINANTE\n\n');
fprintf('Conclusion: En el orden original la matriz NO es diagonal dominante,\n');
fprintf('por lo que el metodo de Gauss-Seidel divergeria o tardaria muchisimo.\n\n');

% ------------------------------------------------------------------------------
% 2. REORDENAMIENTO DE ECUACIONES PARA LOGRAR DIAGONAL DOMINANTE
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('2. REORDENAMIENTO ESTRATEGICO DE ECUACIONES:\n');
fprintf('----------------------------------------------------------------------\n');
fprintf('Para que el elemento de mayor valor absoluto quede en la diagonal:\n');
fprintf('  - Nueva Fila 1 = Fila 2 original (pivote en x1 es 3.0 > 0.1 + 0.2)\n');
fprintf('  - Nueva Fila 2 = Fila 1 original (pivote en x2 es 7.0 > 0.1 + 0.3)\n');
fprintf('  - Nueva Fila 3 = Fila 3 original (pivote en x3 es |-10.3| > 0.3 + 0.2)\n\n');

A = [ 3.0, -0.1,  -0.2;
      0.1,  7.0,  -0.3;
      0.3, -0.2, -10.3 ];

b = [   7.85;
      -19.30;
      -19.30 ];

fprintf('Sistema reordenado:\n');
for i = 1:3
  fprintf('  [ %6.2f %6.2f %6.2f | %8.2f ]\n', A(i, 1), A(i, 2), A(i, 3), b(i));
endfor
fprintf('\n');

% ------------------------------------------------------------------------------
% 3. RESOLUCION CON GAUSS-SEIDEL (Vector inicial [1; 1; 1])
% ------------------------------------------------------------------------------
x0 = [1.0; 1.0; 1.0];
tol = 1e-4;
maxIter = 50;

fprintf('----------------------------------------------------------------------\n');
fprintf('3. APLICACION DEL METODO DE GAUSS-SEIDEL:\n');
fprintf('----------------------------------------------------------------------\n');
[x, k, conv] = GaussSeidel(A, b, x0, tol, maxIter);

% ------------------------------------------------------------------------------
% 4. VERIFICACION CON METODO DIRECTO DE OCTAVE (A\b)
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('VERIFICACION DE LA SOLUCION:\n');
fprintf('======================================================================\n');
x_exacto = A \ b;
fprintf('  Incognita | Gauss-Seidel | Octave (A\\b) | Diferencia absoluta\n');
fprintf('  ----------|--------------|--------------|--------------------\n');
for i = 1:3
  fprintf('     x%d    | %12.6f | %12.6f | %12.6e\n', i, x(i), x_exacto(i), abs(x(i) - x_exacto(i)));
endfor
fprintf('======================================================================\n');
