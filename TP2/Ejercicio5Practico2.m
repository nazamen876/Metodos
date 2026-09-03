clc

valorRedondeo = 0;
valorTruncamiento = 0;

function y = redon3(valorRedondeo)
  if valorRedondeo == 0
    y = 0;
  else
    y = str2double(sprintf("%.2e", valorRedondeo));
  endif
endfunction
%

function y = trunc3(valorTruncamiento)
  if valorTruncamiento == 0
    y = 0;
    return;
  endif
  % Cantidad de lugares que ocupa la parte entera
  d = floor(log10(abs(valorTruncamiento))) + 1;
  % Corre la coma para dejar 3 dígitos en la parte entera, corta y regresa
  y = fix(valorTruncamiento * 10^(3 - d)) * 10^(d - 3);
endfunction
%

%Calculos sin redondeo o truncamiento.

xlr = 4.71;
x2r = xlr^2;

x3r = xlr^3;

c6x2r = 6*x2r;

c3xr = 3*xlr;

fReal = x3r -c6x2r+c3xr -0.149;
%Calculos con redondeo

x1re = 4.71;
x2re = redon3(xlr^2);

x3re = redon3(x2re*x1re);

c6x2re = redon3(6*x2re);

c3xre = redon3(3*x1re);

paso1_re = redon3(x3re - c6x2re);           % 105 - 133 = -28.0
paso2_re = redon3(paso1_re + c3xre);        % -28.0 + 14.1 = -13.9
fRedondeo = redon3(paso2_re - redon3(0.149)); % -13.9 - 0.149 -> -14.0
%Calculos con truncamiento

x1tr = 4.71;
x2tr = trunc3(x1tr^2);

x3tr = trunc3(x2tr * x1tr);

c6x2tr = trunc3(6*x2tr);

c3xtr = trunc3(3*x1tr);

paso1_tr = trunc3(x3tr - c6x2tr);           % 104 - 132 = -28.0
paso2_tr = trunc3(paso1_tr + c3xtr);        % -28.0 + 14.1 = -13.9
fTruncamiento = trunc3(paso2_tr - trunc3(0.149));

%Valores Finales

filaReal = [xlr, x2r, x3r, c6x2r, c3xr, fReal];
filaRedondeo = [x1re, x2re, x3re, c6x2re, c3xre, fRedondeo];
filaTruncamiento = [x1tr, x2tr, x3tr, c6x2tr, c3xtr, fTruncamiento];

matrizValores = [filaReal; filaRedondeo; filaTruncamiento]

% Errores para redondeo
eAbs_redon = abs(fReal - fRedondeo)
eRel_redon = eAbs_redon / abs(fReal)

% Errores para truncamiento
eAbs_trunc = abs(fReal - fTruncamiento)
eRel_trunc = eAbs_trunc / abs(fReal)

%Calculo en formula anidada f(x) = ((x - 6)x + 3)x - 0.149

fRealA = ((x1re -6)*x1re + 3)*x1re -0.149

p1_re = redon3(x1re - 6);
p2_re = redon3(p1_re * x1re);
p3_re = redon3(p2_re + 3);
p4_re = redon3(p3_re * x1re);
fRedondeoA = redon3(p4_re - redon3(0.149))

p1_tr = trunc3(x1tr - 6);
p2_tr = trunc3(p1_tr * x1tr);
p3_tr = trunc3(p2_tr + 3);
p4_tr = trunc3(p3_tr * x1tr);
fTruncamientoA = trunc3(p4_tr - trunc3(0.149))


%Calculo de errores con funcion anidada
% Errores para redondeo
eAbsA_redon = abs(fRealA - fRedondeoA)
eRelA_redon = eAbsA_redon / abs(fRealA)

% Errores para truncamiento
eAbsA_trunc = abs(fRealA - fTruncamientoA)
eRelA_trunc = eAbsA_trunc/ abs(fRealA)

%{
Por una parte, reescribir el polinomio de forma anidada ocasionó una reducción drástica en los errores
tanto para redondeo como para truncamiento. Esto se debe principalmente a que en la forma polinómica directa
se calculan potencias, las cuales magnifican el error por propagación.
Al anidar reducimos las multiplicaciones totales (de 5 a 2) manteniendo 3 sumas/restas.
En lo que respecta a los métodos utilizados, se aprecia claramente que en el cálculo anidado el redondeo
es ampliamente superior al truncamiento.
%}











