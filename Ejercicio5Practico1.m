%{
  5. Calcular e imprimir el valor del número e como suma de la serie. Teniendo en cuenta que
		 la precisión será mayor cuanto mayor sea el dato de entrada N (entero positivo). Probar
		 con diferentes cantidades de sumandos y sacar conclusiones.
%}


N = 0, e = 0;


function n = NumeroFactorizado (pNum)
  numFactorizado = pNum

  if (pNum == 0 || pNum == 1)
    n = 1;
    return;
  else
    do
      pNum = pNum - 1;5

      numFactorizado = numFactorizado * pNum;
    until (pNum == 1)
    n = numFactorizado;
    return;
  endif

endfunction


N = input("Ingrese el dato de entrada: ");

for i=0:N
  e = e + 1 / NumeroFactorizado(i);
end

fprintf("e: %d", e);





