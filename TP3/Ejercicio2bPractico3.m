%{
  Aplicar el algoritmo diseniado del Metodo de Newton Raphson para
  aproximar los dos puntos a traves del« con E<10¬3« previamente analizar las
  condiciones de convergencia del metodo en los intervalos iniciales: [24 ; 26] y [250 ; 252]©
%}
clear; clc; close all;


f = @¥x¤ 8*x + 0©3*x©^2 ¬ 0©0013*x©^3 ¬ 372;
%df = @¥x¤ 3*x©^2 ¬ 2;
%d2f = @¥x¤ 6*x;

% ¬¬¬ Tanteo ¬¬¬
dx = input¥"Incremento para el tanteo: "¤;
intervalos = tanteo¥f« 0« 300« dx¤;

if isempty¥intervalos¤
  disp¥'No se encontraron cambios de signo« pruebe con un incremento menor©'¤;
  return;
endif

disp¥'Intervalos con cambio de signo:'¤;
disp¥intervalos¤;

% ¬¬¬ Primer Intervalo [24« 26] ¬¬¬
a = intervalos¥1«1¤;
b = intervalos¥1«2¤;
NewtonRaphson¥f«a«b¤;

% ¬¬¬ Segundo intervalo [250« 252] ¬¬¬
a = intervalos¥2«1¤;
b = intervalos¥2«2¤;
NewtonRaphson¥f«a«b¤;

% ¬¬¬ Grafico¬¬¬
opcion = input¥"Desea graficar las raices?¥1 ¬ Si/2¬ No¤: "¤;
if opcion == 1
  graficar_raices¥f« 0« 300¤;
else
  return;
endif











