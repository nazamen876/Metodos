% ==============================================================================
% EJEMPLOS PARA COPIAR Y PEGAR:
%
% 1) Problema del tanque esferico (TP3 Ejercicio 1):
%    f = @(h) pi * h.^2 .* (9 - h) / 3 - 30;
%
% 2) Problema de produccion (TP3 Ejercicio 2):
%    f = @(x) 8*x + 0.3*x.^2 - 0.0013*x.^3 - 372;
% ==============================================================================

clear; clc; close all;

% Rutas para dependencias
carpeta = fileparts(mfilename('fullpath'));
addpath(carpeta);
addpath(fullfile(carpeta, '..'));
addpath(fullfile(carpeta, 'Interpolacion Lineal'));

fprintf('Interpolacion Lineal\n\n');

% ------------------------------------------------------------------------------
% SELECCION O INGRESO DE LA FUNCION
% ------------------------------------------------------------------------------
fprintf('Seleccione la funcion a analizar:\n');
fprintf('  1) Tanque esferico [TP3 Ej. 1]: f(h) = pi*h^2*(9-h)/3 - 30\n');
fprintf('  2) Produccion [TP3 Ej. 2]:      f(x) = 8*x + 0.3*x^2 - 0.0013*x^3 - 372\n');
fprintf('  3) Ingresar funcion personalizada por teclado\n\n');

opc_f = input('Opcion [1-3, por defecto 1]: ');
if isempty(opc_f)
  opc_f = 1;
endif

switch opc_f
  case 1
    f = @(h) pi * h.^2 .* (9 - h) / 3 - 30;
    nombre_var = 'h';
    x_min_def = -3;
    x_max_def = 10;
    dx_def = 1;
    es_tanque = true;
  case 2
    f = @(x) 8*x + 0.3*x.^2 - 0.0013*x.^3 - 372;
    nombre_var = 'x';
    x_min_def = 0;
    x_max_def = 300;
    dx_def = 25;
    es_tanque = false;
  case 3
    fprintf('\n');
    str_in = input('Ingrese f(x) (ej: 8*x + 0.3*x^2 - 372): ', 's');
    if isempty(str_in)
      f = @(h) pi * h.^2 .* (9 - h) / 3 - 30;
      nombre_var = 'h';
      x_min_def = -3;
      x_max_def = 10;
      dx_def = 1;
      es_tanque = true;
    else
      if ~strncmp(strtrim(str_in), '@', 1)
        str_in = regexprep(str_in, '(?<!\.)\^', '.^');
        str_in = regexprep(str_in, '(?<!\.)\*', '.*');
        str_in = regexprep(str_in, '(?<!\.)\/', './');
        str_in = ['@(x) ' str_in];
      endif
      f = str2func(str_in);
      nombre_var = 'x';
      x_min_def = -10;
      x_max_def = 10;
      dx_def = 1;
      es_tanque = false;
    endif
  otherwise
    error('Opcion no valida.');
endswitch

% ------------------------------------------------------------------------------
% PASO 1: GRAFICO DE LA FUNCION
% ------------------------------------------------------------------------------
fprintf('\n------------------------------------------------------------\n');
fprintf('PASO 1: GRAFICO DE LA FUNCION\n');
fprintf('------------------------------------------------------------\n');

prompt_xmin = sprintf('Extremo inferior para el grafico [%g]: ', x_min_def);
xmin_in = input(prompt_xmin);
if isempty(xmin_in), x_min = x_min_def; else, x_min = xmin_in; endif

prompt_xmax = sprintf('Extremo superior para el grafico [%g]: ', x_max_def);
xmax_in = input(prompt_xmax);
if isempty(xmax_in), x_max = x_max_def; else, x_max = xmax_in; endif

raices_graf = graficar_raices(f, x_min, x_max);
if ~isempty(raices_graf)
  fprintf('Raices aproximadas en el grafico: ');
  fprintf('%.4f  ', raices_graf);
  fprintf('\n');
endif

% ------------------------------------------------------------------------------
% PASO 2: METODO DE TANTEO
% ------------------------------------------------------------------------------
fprintf('\n------------------------------------------------------------\n');
fprintf('PASO 2: METODO DE TANTEO\n');
fprintf('------------------------------------------------------------\n');

prompt_dx = sprintf('Incremento dx para el tanteo [%g]: ', dx_def);
dx_in = input(prompt_dx);
if isempty(dx_in), dx = dx_def; else, dx = dx_in; endif

intervalos = tanteo(f, x_min, x_max, dx);

if isempty(intervalos)
  fprintf('\nNo se detectaron intervalos con cambio de signo en [%g, %g].\n', x_min, x_max);
  fprintf('Pruebe con un rango mayor o un paso dx menor.\n');
  return;
endif

% ------------------------------------------------------------------------------
% PASO 3: SELECCION DE INTERVALO
% ------------------------------------------------------------------------------
num_int = size(intervalos, 1);
fprintf('\n------------------------------------------------------------\n');
fprintf('PASO 3: SELECCION DE INTERVALO\n');
fprintf('------------------------------------------------------------\n');

if es_tanque
  fprintf('Condicion fisica (Tanque R=3): 0 <= h <= 6 (2*R)\n\n');
endif

fprintf('Intervalos con cambio de signo encontrados:\n');
for i = 1:num_int
  fprintf('  [%d]  [%.4f, %.4f]\n', i, intervalos(i, 1), intervalos(i, 2));
endfor
fprintf('  [0]  Ingresar intervalo manual [a, b]\n\n');

prompt_sel = sprintf('Seleccione que intervalo utilizar [1-%d o 0]: ', num_int);
opc_sel = input(prompt_sel);
if isempty(opc_sel)
  opc_sel = 1;
endif

if opc_sel == 0
  a = input('Ingrese extremo a: ');
  b = input('Ingrese extremo b: ');
elseif opc_sel >= 1 && opc_sel <= num_int
  a = intervalos(opc_sel, 1);
  b = intervalos(opc_sel, 2);
else
  error('Seleccion no valida.');
endif

fprintf('\nIntervalo seleccionado: [%.4f, %.4f]\n', a, b);

% ------------------------------------------------------------------------------
% PASO 4: INTERPOLACION LINEAL
% ------------------------------------------------------------------------------
fprintf('\n------------------------------------------------------------\n');
fprintf('PASO 4: INTERPOLACION LINEAL\n');
fprintf('------------------------------------------------------------\n');

tol_in = input('Tolerancia de error [default 1e-4]: ');
if isempty(tol_in), tol = 1e-4; else, tol = tol_in; endif

max_iter_in = input('Maximo de iteraciones [default 100]: ');
if isempty(max_iter_in), max_iter = 100; else, max_iter = max_iter_in; endif

% Medicion de tiempo con tic/toc y cputime
tic;
c0 = cputime;

[raiz, iter] = interpolacionLineal(f, a, b, tol, max_iter);

tiempo_toc = toc;
tiempo_cpu = cputime - c0;

% ------------------------------------------------------------------------------
% RESULTADOS Y MEDICION DE TIEMPOS
% ------------------------------------------------------------------------------
fprintf('\n------------------------------------------------------------\n');
fprintf('RESULTADOS FINALES\n');
fprintf('------------------------------------------------------------\n');
fprintf('%-22s %-12s %-8s %-14s %-14s\n', 'Metodo', 'Raiz', 'Iter', 'tic/toc (s)', 'cputime (s)');
fprintf('%-22s %-12.6f %-8d %-14.3e %-14.3e\n', 'Interpolacion lineal', raiz, iter, tiempo_toc, tiempo_cpu);
fprintf('\nDetalle:\n');
fprintf('  Variable    : %s\n', nombre_var);
fprintf('  Intervalo   : [%.4f, %.4f]\n', a, b);
fprintf('  Tolerancia  : %.1e\n', tol);
fprintf('  Residuo     : f(%.6f) = %.2e\n', raiz, f(raiz));
fprintf('------------------------------------------------------------\n');
