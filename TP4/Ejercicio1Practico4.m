clear; clc;

% Asegurar que la carpeta actual este en el path para encontrar gauss y redondear
carpeta = fileparts(mfilename('fullpath'));
if ~isempty(carpeta)
  addpath(carpeta);
endif

% ==============================================================================
% TRABAJO PRACTICO N° 4 - SISTEMAS DE ECUACIONES LINEALES NO HOMOGENEOS
% METODO DE ELIMINACION DE GAUSS CON PIVOTEO PARCIAL
% ==============================================================================

fprintf('======================================================================\n');
fprintf('        TRABAJO PRACTICO N° 4: RESOLUCION DE SISTEMAS LINEALES\n');
fprintf('                   METODO DE ELIMINACION DE GAUSS\n');
fprintf('======================================================================\n\n');

fprintf('Seleccione una opcion:\n');
fprintf('  1) Ejercicio 1: Mezcla de materiales (Requerimiento diario y costos) [Por defecto]\n');
fprintf('  2) Ingresar matriz y vector personalizados por teclado\n\n');

opcion = input('Opcion [1-2, Enter = 1]: ', 's');
opcion = strtrim(opcion);
if isempty(opcion) || strcmp(opcion, '1')
  es_ejercicio1 = true;
else
  es_ejercicio1 = false;
endif

if es_ejercicio1
  % ----------------------------------------------------------------------------
  % MODELADO MATEMATICO - EJERCICIO 1
  % ----------------------------------------------------------------------------
  % Nutrientes por kg de cada ingrediente:
  %                     Maiz  Desp. Alfalfa Cebada
  A = [ 80   15    35    60;   % Nutriente 1
        28   72    57    25;   % Nutriente 2
        20   20    12    20;   % Nutriente 3
        50   10    20    60 ]; % Nutriente 4

  % Requerimiento diario de cada nutriente:
  b = [ 230; 180; 80; 160 ];

  % Costo por kg de cada material ($/kg):
  % [Maíz, Desperdicios, Alfalfa, Cebada]
  c = [ 18, 5, 7, 20 ];
  nombres = {'Maiz', 'Desperdicios', 'Alfalfa', 'Cebada'};

  fprintf('\n----------------------------------------------------------------------\n');
  fprintf('PLANTEO DEL PROBLEMA - EJERCICIO 1 (MODELADO):\n');
  fprintf('----------------------------------------------------------------------\n');
  fprintf('Variables de decision (incognitas a determinar):\n');
  fprintf('  x1: Cantidad de Maiz (kg)\n');
  fprintf('  x2: Cantidad de Desperdicios (kg)\n');
  fprintf('  x3: Cantidad de Alfalfa (kg)\n');
  fprintf('  x4: Cantidad de Cebada (kg)\n\n');
  fprintf('Costos unitarios por material:\n');
  fprintf('  Maiz: $18.00/kg  |  Desperdicios: $5.00/kg  |  Alfalfa: $7.00/kg  |  Cebada: $20.00/kg\n\n');
  fprintf('Requerimientos diarios a satisfacer:\n');
  fprintf('  Nutriente 1: 230 unidades\n');
  fprintf('  Nutriente 2: 180 unidades\n');
  fprintf('  Nutriente 3:  80 unidades\n');
  fprintf('  Nutriente 4: 160 unidades\n\n');
  fprintf('Sistema planteado: A * x = b\n');
  fprintf('----------------------------------------------------------------------\n\n');

  % Pregunta por el uso de aritmetica de 3 digitos (pedido en la guia)
  resp_dig = input('¿Desea usar aritmetica de 3 cifras significativas (segun consigna)? [S/n]: ', 's');
  resp_dig = strtrim(resp_dig);
  if isempty(resp_dig) || strcmpi(resp_dig, 's')
    dig = 3;
    fprintf('-> Se utilizara aritmetica acotada a %d cifras significativas.\n\n', dig);
  else
    dig = 0;
    fprintf('-> Se utilizara precision completa de maquina.\n\n');
  endif

else
  % ----------------------------------------------------------------------------
  % SISTEMA PERSONALIZADO INGRESADO POR EL USUARIO
  % ----------------------------------------------------------------------------
  fprintf('\nIngrese los datos del sistema Ax = b:\n');
  A = input('Matriz de coeficientes A, ej [2 1 -1; -3 -1 2; -2 1 2]: ');
  b = input('Columna de términos independientes b, ej [8; -11; -3]: ');
  b = b(:);

  n = size(A, 1);
  if size(A, 2) != n
    error('La matriz A debe ser cuadrada (n x n).');
  endif
  if numel(b) != n
    error('El vector b debe tener la misma cantidad de filas que A.');
  endif

  dig_in = input('Cantidad de cifras significativas para el calculo (0 = precision completa): ');
  if isempty(dig_in)
    dig = 0;
  else
    dig = dig_in;
  endif
  c = [];
  nombres = {};
endif

n = size(A, 1);
M = [A b];

% ------------------------------------------------------------------------------
% RESOLUCION MEDIANTE EL METODO DE GAUSS
% (La funcion gauss imprime paso a paso toda la triangulacion y sustitucion)
% ------------------------------------------------------------------------------
  [x, M_triang] = gauss(M, dig);

% ------------------------------------------------------------------------------
% RESPUESTAS A LAS CONSIGNAS (SI ES EL EJERCICIO 1)
% ------------------------------------------------------------------------------
if es_ejercicio1
  fprintf('======================================================================\n');
  fprintf('                 RESPUESTAS A LAS CONSIGNAS (EJ. 1)\n');
  fprintf('======================================================================\n\n');

  fprintf('1) Kilogramos necesarios de cada material para satisfacer la dieta diaria:\n');
  for i = 1:n
    fprintf('   - %-12s (x%d): %8.4f kg\n', nombres{i}, i, x(i));
  endfor
  fprintf('   -----------------------------------------\n');
  fprintf('   Peso total de la racion diaria: %8.4f kg\n\n', sum(x));

  fprintf('2) Determinacion del costo de la mezcla:\n');
  costos_parciales = c(:) .* x(:);
  for i = 1:n
    fprintf('   - Costo de %-12s: %8.4f kg x $%5.2f/kg = $%8.2f\n', ...
            nombres{i}, x(i), c(i), costos_parciales(i));
  endfor
  costo_total = sum(costos_parciales);
  fprintf('   ---------------------------------------------------------\n');
  fprintf('   COSTO TOTAL DE LA MEZCLA: $ %.2f\n\n', costo_total);
endif

% ------------------------------------------------------------------------------
% VERIFICACION CON METODO PROPIO DE OCTAVE (A\b)
% ------------------------------------------------------------------------------
fprintf('======================================================================\n');
fprintf('                 VERIFICACION CON OCTAVE (A\\b)\n');
fprintf('======================================================================\n');
x_ref = A \ b;

if dig > 0
  fprintf('\nComparacion: Gauss con %d digitos vs. Solucion de referencia (A\\b):\n\n', dig);
  fprintf('  Incognita | Sol. Gauss (%d dig) | Sol. Octave (A\\b) | Diferencia\n', dig);
  fprintf('  -------------------------------------------------------------------\n');
  for i = 1:n
    dif = abs(x(i) - x_ref(i));
    fprintf('     x%-5d |        %10.4f  |       %10.4f  |   %10.4f\n', ...
            i, x(i), x_ref(i), dif);
  endfor

  if es_ejercicio1
    costo_ref = sum(c(:) .* x_ref(:));
    fprintf('  -------------------------------------------------------------------\n');
    fprintf('  Costo con %d digitos: $ %.2f  |  Costo exacto (A\\b): $ %.2f\n', ...
            dig, costo_total, costo_ref);
  endif
else
  fprintf('\nSolucion de referencia con Octave (A\\b):\n');
  for i = 1:n
    fprintf('  x%d = %.4f\n', i, x_ref(i));
  endfor
endif
fprintf('======================================================================\n');
