%{
  2. Usando aritmética con redondeo a 3dígitos, realice los siguientes cálculos.
     Considerando como valor exacto el resultado con 5 dígitos decimales, obtenga el
     error absoluto y error relativo. Trabajar con los valores normalizados.
%}

a = 0;
b = 0;

function error_abs = ErrorAbsoluto (a, b)
  error_abs = abs(a - b);
  return;
endfunction


function error_rel = ErrorRelativo (a, b)
  error_rel = ErrorAbsoluto(a,b) / abs(a);
  return;
endfunction

fprintf(  "a. Valor exacto: 0.13392 * 10^3 | Valor aproximado: 0.134 * 10^3 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.13392 * 10^3, 0.134 * 10^3),
          ErrorRelativo(0.13392 * 10^3, 0.134 * 10^3));

fprintf(  "b. Valor exacto: 0.13250 * 10^3 | Valor aproximado: 0.133 * 10^3 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.13250 * 10^3, 0.133 * 10^3),
          ErrorRelativo(0.13250 * 10^3, 0.133 * 10^3));

fprintf(  "c. Valor exacto: 0.1673 * 10 | Valor aproximado: 0.167 * 10 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.1673 * 10, 0.167 * 10),
          ErrorRelativo(0.1673 * 10, 0.167 * 10));

fprintf(  "d. Valor exacto: 0.1673 * 10^3 | Valor aproximado: 0.167 * 10^3 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.1673 * 10, 0.167 * 10),
          ErrorRelativo(0.1673 * 10, 0.167 * 10));

fprintf(  "e. Valor exacto: 0.28751 | Valor aproximado: 0.288 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.28571, 0.286),
          ErrorRelativo(0.28571, 0.286));

