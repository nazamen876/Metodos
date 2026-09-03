clc

x = 0;
x1Real = -0.01610723;
x2Real = -62.08390;

function y = redon(x)
  if x == 0
    y = 0;
  else
    y = str2double(sprintf("%.3e", x));
  endif
endfunction

a = redon(1);
b = redon(62.10);
c = redon(1);
b2 = redon(b^2);
AC4 = redon(4 * a * c);
discriminante = redon(b2 - AC4);
a2 = redon(2 * a);
raizDisc = redon(sqrt(discriminante));

% x1(+ raíz)
printf("X1 con redondeo a 4 cifras significativas\n");
dividendo1 = redon(-b + raizDisc);
x1 = redon(dividendo1 / a2)

% x2(- raíz)
printf("X2 con redondeo a 4 cifras significativas\n");
dividendo2 = redon(-b - raizDisc);
x2 = redon(dividendo2 / a2)

% Errores
printf("Errores absolutos y relativos\n");
errorAbsolutox1 = abs(x1Real - x1)
errorAbsolutox2 = abs(x2Real - x2)

errorRelativox1 = abs(x1Real - x1) / abs(x1Real)
errorRelativox2 = abs(x2Real - x2) / abs(x2Real)

printf("Final item a\n");

c2 = redon(-2 * c);

% Denominadores con b positivo
denRacion1 = redon(b + raizDisc);
denRacion2 = redon(b - raizDisc);

printf("X1 y X2 con redondeo a 4 cifras utilizando la formula racionalizada\n");
x1Racionalizada = redon(c2 / denRacion1)
x2Racionalizada = redon(c2 / denRacion2)

% Errores
printf("Errores absolutos y relativos con formula racionalizada\n");
errorAbsolutox1 = abs(x1Real - x1Racionalizada)
errorAbsolutox2 = abs(x2Real - x2Racionalizada)

errorRelativox1 = abs(x1Real - x1Racionalizada) / abs(x1Real)
errorRelativox2 = abs(x2Real - x2Racionalizada) / abs(x2Real)


%{
Para x1, al utilizar la formula tradicional, esta sufre una cancelacion enorme
mientras que al utilziar la formula racionalizada se elimina la resta del numerador,
reduciendo de forma drastica el error.
Para x2, al utilizar la formula tradicional es muy precisa debido a que suma cantidades del mismo signo,
pero al cambiar a la formula racionalizada la cancelacion se traslada al denominador haciendo que el error se dispare
%}

































