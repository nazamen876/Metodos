% 1. Calcule el error absoluto y relativo en las aproximaciones de p por p*

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


fprintf("a. Error absoluto: %.7f\tError relativo: %.7f\n", ErrorAbsoluto(pi, 22/7), ErrorRelativo(pi, 22/7));
fprintf("b. Error absoluto: %.7f\tError relativo: %.7f\n", ErrorAbsoluto(pi, 3.1416), ErrorRelativo(pi, 3.1416));
fprintf("c. Error absoluto: %.7f\tError relativo: %.7f\n", ErrorAbsoluto(e, 2.718), ErrorRelativo(e, 2.718));
fprintf("d. Error absoluto: %.7f\tError relativo: %.7f\n", ErrorAbsoluto(power(2, 1/2), 1.414), ErrorRelativo(power(2, 1/2), 1.414));
fprintf("e. Error absoluto: %.7f\tError relativo: %.7f\n", ErrorAbsoluto(power(e, 10), 22000), ErrorRelativo(power(e, 10), 22000));
fprintf("f. Error absoluto: %.7f\tError relativo: %.7f\n", ErrorAbsoluto(factorial(8), 39900), ErrorRelativo(factorial(8), 22000));

