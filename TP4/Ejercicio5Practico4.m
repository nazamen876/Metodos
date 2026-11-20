clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 4 - EJERCICIO 5 (SISTEMAS HOMOGENEOS 1)
% Metodo de Fadeev-Leverrier para Autovalores y Autovectores
%
% Sistema homogeneo / Matriz de prueba:
%   A = [ 2, -1,  1;
%        -1,  2, -1;
%         1, -1,  2 ]
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                        Sistemas Homogeneos\n');
fprintf('                TRABAJO PRACTICO N° 4 - EJERCICIO 1\n');
fprintf('======================================================================\n\n');

% Matriz de coeficientes del sistema homogeneo (A - lambda*I)*x = 0
A = [  2, -1,  1;
      -1,  2, -1;
       1, -1,  2 ];

fprintf('Matriz A del sistema homogeneo (A - lambda*I)*v = 0:\n');
for i = 1:3
  fprintf('  [ %6.2f %6.2f %6.2f ]\n', A(i, 1), A(i, 2), A(i, 3));
endfor
fprintf('\n');

% ------------------------------------------------------------------------------
% Aplicacion del Metodo de Fadeev-Leverrier
% ------------------------------------------------------------------------------
[p, autovalores, autovectores, B, A_inv] = fadeevLeverrier(A);

