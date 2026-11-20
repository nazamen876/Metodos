clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 4 - EJERCICIO 6 (SISTEMAS HOMOGENEOS 2)
% Vibraciones de un sistema de 3 masas insertadas en una varilla
% Problema de autovalores y autovectores
%
% Ecuacion matricial:
%   [  2  -1   0 ]   [ x1 ]          [ x1 ]
%   [ -1   2  -1 ] * [ x2 ] = lambda [ x2 ]
%   [  0  -1   2 ]   [ x3 ]          [ x3 ]
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 4 - EJERCICIO 2\n');
fprintf('======================================================================\n\n');

% Matriz tridiagonal de rigidez/masa del sistema mecanico de 3 masas:
A = [  2, -1,  0;
      -1,  2, -1;
       0, -1,  2 ];

fprintf('Matriz caracteristica del sistema de vibraciones:\n');
for i = 1:3
  fprintf('  [ %4.1f %4.1f %4.1f ]\n', A(i, 1), A(i, 2), A(i, 3));
endfor
fprintf('\n');

% ------------------------------------------------------------------------------
% b) Obtener todos los autovalores y el autovector del autovalor intermedio
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE b) OBTENCION DE TODOS LOS AUTOVALORES Y EL AUTOVECTOR INTERMEDIO\n');
fprintf('----------------------------------------------------------------------\n');
[p, autovalores, autovectores] = fadeevLeverrier(A);

% Ordenar autovalores en orden ascendente
[autoval_ord, idx_ord] = sort(autovalores, 'ascend');
autovec_ord = autovectores(:, idx_ord);

fprintf('Autovalores ordenados:\n');
fprintf('  lambda_min        = %12.6f\n', autoval_ord(1));
fprintf('  lambda_intermedio = %12.6f\n', autoval_ord(2));
fprintf('  lambda_max        = %12.6f\n\n', autoval_ord(3));

fprintf('Autovector correspondiente al valor propio intermedio (lambda = %.4f):\n', autoval_ord(2));
v_intermedio = autovec_ord(:, 2);
for i = 1:3
  fprintf('  v(%d) = %12.6f\n', i, v_intermedio(i));
endfor
fprintf('\n');

% ------------------------------------------------------------------------------
% c) Metodo de las potencias: 4 iteraciones partiendo de v0 = [1, 1, -0.5]^T
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE c) METODO DE LAS POTENCIAS (4 ITERACIONES DESDE [1, 1, -0.5]^T)\n');
fprintf('----------------------------------------------------------------------\n');

v0 = [1.0; 1.0; -0.5];
maxIter = 4;
tol = 1e-12;   % Para que realice exactamente las 4 iteraciones

[lambda_pot, v_pot, iters] = metodoPotencias(A, v0, maxIter, tol);

% Comparacion con el maximo autovalor exacto obtenido en b)
lambda_max_exacto = autoval_ord(3);
err_abs = abs(lambda_pot - lambda_max_exacto);
err_rel = (err_abs / abs(lambda_max_exacto)) * 100;

fprintf('======================================================================\n');
fprintf('COMPARACION DE RESULTADOS (METODO DE LAS POTENCIAS vs EXACTO):\n');
fprintf('======================================================================\n');
fprintf('  Autovalor maximo exacto (parte b) : lambda = %12.6f\n', lambda_max_exacto);
fprintf('  Autovalor por Potencias (4 iters) : lambda = %12.6f\n', lambda_pot);
fprintf('  Error absoluto                    : Err    = %12.6e\n', err_abs);
fprintf('  Error relativo porcentual         : Err%%   = %8.4f %%\n\n', err_rel);

fprintf('Autovector dominante exacto vs aproximado:\n');
v_max_exacto = autovec_ord(:, 3);
% Normalizar vector exacto por su componente maxima para comparar
[~, idx_p] = max(abs(v_max_exacto));
v_max_exacto_norm = v_max_exacto / v_max_exacto(idx_p);

fprintf('  Comp | Vector Exacto | Vector Potencias (4 it) | Diferencia\n');
fprintf('  -----|---------------|-------------------------|------------\n');
for i = 1:3
  dif_v = abs(v_max_exacto_norm(i) - v_pot(i));
  fprintf('   %d   | %13.6f | %23.6f | %10.4e\n', i, v_max_exacto_norm(i), v_pot(i), dif_v);
endfor
fprintf('======================================================================\n');
