clear; clc;

% ==============================================================================
% TRABAJO PRACTICO N° 7 - EJERCICIO 4 (COMPLEMENTARIO)
% Vaciado de un tanque cilindrico vertical
% EDO: dy/dt = -k * sqrt(y),  con k = 0.06, y(0) = 3 m, h = 0.5 min
% ==============================================================================

carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

fprintf('======================================================================\n');
fprintf('           TRABAJO PRACTICO N° 7 - EJERCICIO 4 (COMPLEMENTARIO)\n');
fprintf('                 VACIADO DE UN TANQUE POR METODO DE EULER\n');
fprintf('======================================================================\n\n');

k = 0.06;
y0 = 3.0;
t0 = 0.0;
h = 0.5;   % minutos

f = @(t, y) -k * sqrt(max(y, 0));

% Solucion analitica exacta (separando variables):
% dy / sqrt(y) = -k dt  =>  2*sqrt(y) - 2*sqrt(y0) = -k*t
% sqrt(y) = sqrt(y0) - (k/2)*t
% y(t) = (sqrt(y0) - (k/2)*t)^2,  para t <= 2*sqrt(y0)/k
t_vacio_exacto = (2 * sqrt(y0)) / k;

fprintf('Modelo matematico:\n');
fprintf('  dy/dt = -0.06 * sqrt(y)\n');
fprintf('  Condicion inicial: y(0) = 3.00 m\n');
fprintf('  Paso h = %.2f minutos\n', h);
fprintf('  Tiempo teorico exacto para vaciar el tanque: t = %.4f minutos\n\n', t_vacio_exacto);

% Aplicar Euler paso a paso hasta que y <= 0
t_actual = t0;
y_actual = y0;
paso = 0;

T_hist = [t_actual];
Y_hist = [y_actual];

fprintf('Iteraciones del vaciado (Euler, h = %.1f min):\n', h);
fprintf('  %-4s | %-10s | %-12s | %-12s | %-12s\n', 'Paso', 't (min)', 'y (m)', 'dy/dt', 'y_exacta (m)');
fprintf('  -----|------------|--------------|--------------|--------------\n');

while y_actual > 0 && t_actual < 100
  dy = f(t_actual, y_actual);

  % Solucion exacta en este instante
  if t_actual <= t_vacio_exacto
    y_ex = (sqrt(y0) - (k / 2) * t_actual)^2;
  else
    y_ex = 0.0;
  endif

  if mod(paso, 5) == 0 || y_actual <= 0.1
    fprintf('  %4d | %10.2f | %12.6f | %12.6f | %12.6f\n', ...
            paso, t_actual, y_actual, dy, y_ex);
  endif

  y_siguiente = y_actual + h * dy;
  t_actual = t_actual + h;
  paso = paso + 1;

  if y_siguiente < 0
    % Interpolacion lineal en el ultimo paso para determinar tiempo exacto de vaciado
    t_vacio_euler = (t_actual - h) + (0 - y_actual) / dy;
    y_actual = 0;
    T_hist(end + 1) = t_vacio_euler;
    Y_hist(end + 1) = 0;
    fprintf('  %4d | %10.2f | %12.6f | %12.6f | %12.6f (Tanque vacio)\n', ...
            paso, t_vacio_euler, 0.0, 0.0, 0.0);
    break;
  else
    y_actual = y_siguiente;
    T_hist(end + 1) = t_actual;
    Y_hist(end + 1) = y_actual;
  endif
endwhile

fprintf('======================================================================\n');
fprintf('                      RESULTADOS DEL VACIADO\n');
fprintf('======================================================================\n');
fprintf('  Tiempo de vaciado aproximado por Euler: t = %8.4f minutos\n', t_vacio_euler);
fprintf('  Tiempo de vaciado analitico exacto:     t = %8.4f minutos\n', t_vacio_exacto);
fprintf('  Error absoluto:                         Err = %8.4f minutos\n', abs(t_vacio_euler - t_vacio_exacto));
fprintf('  Error relativo porcentual:              Err%% = %6.2f %%\n', ...
        abs(t_vacio_euler - t_vacio_exacto) / t_vacio_exacto * 100);
fprintf('======================================================================\n');
