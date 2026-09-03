% Repita el ejercicio 2 utilizando aritmética con truncamiento a tres dígitos.

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

fprintf(  "a. Valor exacto: 0.13392 * 10^3 | Valor aproximado: 0.133 * 10^3 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.13392 * 10^3, 0.133 * 10^3),
          ErrorRelativo(0.13392 * 10^3, 0.133 * 10^3));

fprintf(  "b. Valor exacto: 0.13250 * 10^3 | Valor aproximado: 0.132 * 10^3 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.13250 * 10^3, 0.132 * 10^3),
          ErrorRelativo(0.13250 * 10^3, 0.132 * 10^3));

fprintf(  "c. Valor exacto: 0.1673 * 10 | Valor aproximado: 0.167 * 10 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.1673 * 10, 0.167 * 10),
          ErrorRelativo(0.1673 * 10, 0.167 * 10));

fprintf(  "d. Valor exacto: 0.1673 * 10^3 | Valor aproximado: 0.167 * 10^3 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.1673 * 10, 0.167 * 10),
          ErrorRelativo(0.1673 * 10, 0.167 * 10));

fprintf(  "e. Valor exacto: 0.28751 | Valor aproximado: 0.287 | Error absoluto: %.5f | Error relativo: %.5f\n",
          ErrorAbsoluto(0.28571, 0.287),
          ErrorRelativo(0.28571, 0.287));

