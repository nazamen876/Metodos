clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 7 - EJERCICIO 6
% EDO: y' = 3x + 3y, con y(0) = 1 en [0; 0.3]
% Solucion exacta: y(x) = (4/3)*e^(3x) - x - 1/3
% a) Valores iniciales con Euler Modificado para h = 0.1 y h = 0.05
% b) Metodo de Milne para calcular y en x = 0.20 y x = 0.25
% c) Errores cometidos en cada paso
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 7 - EJERCICIO 6\n');
fprintf('           INTEGRACION COMPLETA: EULER MODIFICADO + MILNE\n');
fprintf('======================================================================\n\n');

% Definicion del PVI:
f = @(x, y) 3 * x + 3 * y;
y_exacta = @(x) (4 / 3) * exp(3 * x) - x - (1 / 3);

fprintf('Ecuacion diferencial: y'' = 3x + 3y,  y(0) = 1\n');
fprintf('Solucion analitica:   y(x) = (4/3)*exp(3x) - x - 1/3\n\n');

% ------------------------------------------------------------------------------
% a) Valores iniciales con Euler Modificado para h = 0.05
% Para poder aplicar Milne en pasos de h = 0.05 y evaluar en x = 0.20 y 0.25:
% Necesitamos los 4 puntos: x = 0, 0.05, 0.10, 0.15
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE a) GENERACION DE VALORES INICIALES CON EULER MODIFICADO\n');
fprintf('----------------------------------------------------------------------\n');

h_paso = 0.05;
xf_iniciales = 0.15;
fprintf('Generando 4 puntos iniciales en [0, 0.15] con paso h = %.2f:\n', h_paso);
[X_em, Y_em] = eulerModificado(f, 0.0, 1.0, h_paso, xf_iniciales, 1e-5);

% Tambien resolvemos con h = 0.1 para cumplir la consigna de comparar pasos:
fprintf('\nGenerando puntos con paso h = 0.1:\n');
[X_em_01, Y_em_01] = eulerModificado(f, 0.0, 1.0, 0.1, 0.3, 1e-5);

% ------------------------------------------------------------------------------
% b) Aplicar Metodo de Milne para calcular en x = 0.20 y x = 0.25
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('PARTE b) METODO DE MILNE HASTA x = 0.25 (Paso h = 0.05)\n');
fprintf('----------------------------------------------------------------------\n');
xf_milne = 0.25;
[X_milne, Y_milne] = milne(f, X_em(1:4), Y_em(1:4), h_paso, xf_milne);

% ------------------------------------------------------------------------------
% c) Calculo de errores cometidos comparando con la solucion exacta
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('PARTE c) ANALISIS DE ERRORES FRENTE A LA SOLUCION EXACTA\n');
fprintf('======================================================================\n\n');

fprintf('Tabla comparativa completa (h = 0.05):\n');
fprintf('  Punto |    x   |  y calculado  |   y exacta    | Error Absoluto | Error Rel (%%)\n');
fprintf('  ------|--------|---------------|---------------|----------------|--------------\n');

for i = 1:length(X_milne)
  xi = X_milne(i);
  yi = Y_milne(i);
  ye = y_exacta(xi);
  err_abs = abs(yi - ye);
  err_rel = (err_abs / ye) * 100;

  if i <= 4
    metodo_str = '(E. Mod)';
  else
    metodo_str = '(Milne) ';
  endif

  fprintf('  %5d | %6.2f | %13.6f | %13.6f |   %12.6e |    %6.4f %% %s\n', ...
          i-1, xi, yi, ye, err_abs, err_rel, metodo_str);
endfor

fprintf('\n======================================================================\n');
fprintf('                       RESPUESTAS PUNTUALES\n');
fprintf('======================================================================\n');
idx_020 = find(abs(X_milne - 0.20) < 1e-5);
idx_025 = find(abs(X_milne - 0.25) < 1e-5);

fprintf('  En x = 0.20:\n');
fprintf('    y_calc   = %12.6f\n', Y_milne(idx_020));
fprintf('    y_exacta = %12.6f\n', y_exacta(0.20));
fprintf('    Error    = %12.6e (%.4f %%)\n\n', ...
        abs(Y_milne(idx_020) - y_exacta(0.20)), ...
        abs(Y_milne(idx_020) - y_exacta(0.20)) / y_exacta(0.20) * 100);

fprintf('  En x = 0.25:\n');
fprintf('    y_calc   = %12.6f\n', Y_milne(idx_025));
fprintf('    y_exacta = %12.6f\n', y_exacta(0.25));
fprintf('    Error    = %12.6e (%.4f %%)\n', ...
        abs(Y_milne(idx_025) - y_exacta(0.25)), ...
        abs(Y_milne(idx_025) - y_exacta(0.25)) / y_exacta(0.25) * 100);
fprintf('======================================================================\n');
