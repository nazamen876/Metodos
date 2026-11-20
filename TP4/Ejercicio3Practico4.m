clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 4 - EJERCICIO 3 (SISTEMAS NO HOMOGENEOS)
% Descomposicion LU de la Matriz de Coeficientes y Resolucion
%
% Sistema dado:
%    2*x1 - 3*x2 +  4*x3 =  6
%    4*x1 - 5*x2 + 10*x3 =  6
%    4*x1 - 8*x2 +  2*x3 = -2
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 4 - EJERCICIO 3\n');
fprintf('======================================================================\n\n');

A = [ 2, -3,  4;
      4, -5, 10;
      4, -8,  2 ];

b = [ 6;
      6;
     -2 ];

fprintf('Sistema planteado:\n');
for i = 1:3
  fprintf('  [ %4.1f %4.1f %4.1f | %4.1f ]\n', A(i, 1), A(i, 2), A(i, 3), b(i));
endfor
fprintf('\n');

% ------------------------------------------------------------------------------
% a) Encontrar la factorizacion LU de la matriz de coeficientes
% b) Resolver el sistema utilizando dicha descomposicion
% ------------------------------------------------------------------------------
[L, U, x] = descomposicionLU(A, b);

% ------------------------------------------------------------------------------
% Verificacion con Octave
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('VERIFICACION DE RESULTADOS:\n');
fprintf('======================================================================\n');
x_exacto = A \ b;
fprintf('  Incognita | Solucion LU  | Solucion A\\b | Diferencia\n');
fprintf('  ----------|--------------|--------------|------------\n');
for i = 1:3
  fprintf('     x%d    | %12.6f | %12.6f | %10.4e\n', i, x(i), x_exacto(i), abs(x(i) - x_exacto(i)));
endfor
fprintf('======================================================================\n');
