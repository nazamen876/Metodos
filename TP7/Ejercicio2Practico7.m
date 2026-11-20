clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 7 - EJERCICIO 2
% Modelo logistico de crecimiento de una poblacion:
% P'(t) = gamma*P(t) - tau*P(t)^2, con P(0) = 5
% Parametros: gamma = 3, tau = 0.1, en intervalo [0, 2]
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('                TRABAJO PRACTICO N° 7 - EJERCICIO 2\n');
fprintf('         MODELO POBLACIONAL - METODO DE EULER Y SOLUCION EXACTA\n');
fprintf('======================================================================\n\n');

gamma = 3.0;
tau   = 0.1;
P0    = 5.0;
t0    = 0.0;
tf    = 2.0;

% EDO: P' = gamma*P - tau*P^2
f = @(t, P) gamma * P - tau * P.^2;

% Solucion analitica exacta:
% P(t) = (gamma * P0) / (tau * P0 + (gamma - tau * P0) * exp(-gamma * t))
P_exacta = @(t) (gamma * P0) ./ (tau * P0 + (gamma - tau * P0) .* exp(-gamma .* t));

fprintf('Parametros del modelo:\n');
fprintf('  Tasa de natalidad (gamma) = %.2f\n', gamma);
fprintf('  Mortalidad (tau)          = %.2f\n', tau);
fprintf('  Poblacion inicial P(0)    = %.2f\n', P0);
fprintf('  Capacidad de carga (gamma/tau) = %.2f\n\n', gamma / tau);

% ------------------------------------------------------------------------------
% a) Resolver con h = 0.5 y h = 0.25 usando Euler
% ------------------------------------------------------------------------------
fprintf('----------------------------------------------------------------------\n');
fprintf('1) RESOLUCION CON PASO h = 0.5:\n');
fprintf('----------------------------------------------------------------------\n');
[T1, P_eul1] = euler(f, t0, P0, 0.5, tf);

fprintf('----------------------------------------------------------------------\n');
fprintf('2) RESOLUCION CON PASO h = 0.25:\n');
fprintf('----------------------------------------------------------------------\n');
[T2, P_eul2] = euler(f, t0, P0, 0.25, tf);

% ------------------------------------------------------------------------------
% b) Comparar con la solucion exacta
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('             COMPARACION CON LA SOLUCION ANALITICA EXACTA\n');
fprintf('======================================================================\n\n');

fprintf('Comparacion para h = 0.5:\n');
fprintf('    t   | P(t) Euler (h=0.5) | P(t) Exacta  | Error Absoluto | Error Rel (%%)\n');
fprintf('  ------|--------------------|--------------|----------------|--------------\n');
for i = 1:length(T1)
  ti = T1(i);
  pe = P_eul1(i);
  px = P_exacta(ti);
  err_abs = abs(pe - px);
  err_rel = (err_abs / px) * 100;
  fprintf('  %5.2f |       %12.6f | %12.6f |   %12.6f |    %6.2f %%\n', ...
          ti, pe, px, err_abs, err_rel);
endfor

fprintf('\nComparacion para h = 0.25:\n');
fprintf('    t   | P(t) Euler (h=0.25)| P(t) Exacta  | Error Absoluto | Error Rel (%%)\n');
fprintf('  ------|--------------------|--------------|----------------|--------------\n');
for i = 1:length(T2)
  ti = T2(i);
  pe = P_eul2(i);
  px = P_exacta(ti);
  err_abs = abs(pe - px);
  err_rel = (err_abs / px) * 100;
  fprintf('  %5.2f |       %12.6f | %12.6f |   %12.6f |    %6.2f %%\n', ...
          ti, pe, px, err_abs, err_rel);
endfor

fprintf('\n======================================================================\n');
fprintf('Conclusiones sobre el tamano de paso:\n');
fprintf('- Al reducir el paso a la mitad (de h = 0.5 a h = 0.25), el error de\n');
fprintf('  truncamiento se reduce aproximadamente a la mitad, verificando que el\n');
fprintf('  Metodo de Euler posee un orden de convergencia lineal O(h).\n');
fprintf('- La poblacion tiende asintoticamente a la capacidad de carga (30 habitantes).\n');
fprintf('======================================================================\n');
