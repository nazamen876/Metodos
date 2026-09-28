clear; clc; close all;

% --- Rutas relativas a la ubicación de este script (carpeta TP3) ---
carpeta = fileparts(mfilename('fullpath'));
addpath(fullfile(carpeta, 'Intervalo Medio'));
addpath(fullfile(carpeta, 'Interpolacion Lineal'));

% --- Datos del problema ---
R  = 3;      % radio (m)
V0 = 30;     % volumen buscado (m^3)
f  = @(h) pi * h.^2 .* (3*R - h) / 3 - V0;

E = input('Tolerancia E (ej: 0.001): ');
max_iter = 100;

% --- a) Gráfico ---
graficar_raices(f, -3, 10);

% --- b) Tanteo ---
dx = input('Incremento: ');
intervalos = tanteo(f, -3, 10, dx);

if isempty(intervalos)
  disp('No se encontraron cambios de signo, probá con un incremento menor.');
  return;
endif

disp('Intervalos con cambio de signo:');
disp(intervalos);

ok = intervalos(:,1) >= 0 & intervalos(:,2) <= 2*R;
fisicos = intervalos(ok, :);

if isempty(fisicos)
  disp('Ningún intervalo cumple las condiciones físicas.');
  return;
endif

a = fisicos(1,1);
b = fisicos(1,2);
printf('\nIntervalo elegido: [%.4f, %.4f]\n\n', a, b);

% --- c) Métodos, con medición de tiempo ---
tic; c0 = cputime;
[h_bis, it_bis] = biseccion(f, a, b, E, max_iter);
t_bis = toc; c_bis = cputime - c0;

tic; c0 = cputime;
[h_fp, it_fp] = interpolacionLineal(f, a, b, E, max_iter);
t_fp = toc; c_fp = cputime - c0;

% --- Resultados ---
printf('\n%-22s %-12s %-8s %-14s %-14s\n', 'Metodo', 'Raiz', 'Iter', 'tic/toc (s)', 'cputime (s)');
printf('%-22s %-12.6f %-8d %-14.3e %-14.3e\n', 'Intervalo medio', h_bis, it_bis, t_bis, c_bis);
printf('%-22s %-12.6f %-8d %-14.3e %-14.3e\n', 'Interpolacion lineal', h_fp, it_fp, t_fp, c_fp);


#{

Se puede concluir que la convergencia por interpolación lineal es mucho más rápida que por intervalo medio (bisección): mientras que el primero necesitó 3 iteraciones, el segundo necesitó
9 para cumplir la misma tolerancia (E = 0.001). Esto se debe principalmente a que el método de bisección ignora los valores de la función y solo mira el signo, por lo que siempre
corta el intervalo por la mitad, sin importar qué tan lejos del cero esté cada extremo. Interpolación lineal, en cambio, tiene en cuenta el valor de f en ambos extremos, de modo que el
nuevo punto queda más cerca del extremo donde f está más próxima a cero, y eso lo acerca a la raíz mucho más rápido.

En cuanto al tiempo de ejecución, al tratarse de pocas iteraciones, ambos métodos tardaron muy poco.
En una única corrida, interpolación lineal demoró 3.08·10⁻⁴ s contra 4.25·10⁻⁴ s de intervalo medio, algo menos, lo cual es coherente con la menor cantidad de iteraciones.
Cabe aclarar que con cputime se obtuvo 0 en ambos casos, debido a que su resolución es demasiado gruesa para tiempos menores a un milisegundo, y que al ser una sola medición,
la diferencia obtenida con tic/toc es solo orientativa.

Por último, cabe destacar que ambos métodos convergen siempre que exista cambio de signo en el intervalo, pero bisección presenta la ventaja de
tener un ritmo predecible, ya que el intervalo se reduce a la mitad en cada iteración. Interpolación lineal, a diferencia de este, puede ser más
lento si la función presenta una curvatura pronunciada, debido a que uno de los extremos tiende a quedarse fijo.
#}
