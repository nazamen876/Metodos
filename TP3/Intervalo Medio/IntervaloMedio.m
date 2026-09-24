clc;
clear;

disp('=======================================');
disp('           INTERVALOR MEDIO            ');
disp('=======================================');

str_f = input('Ingresa la función f(x) (ej. x^3 - 2*x - 5): ', 's');
f = str2func(['@(x) ' str_f]);

extremoInf = input('Ingresa el extremo inferior');
extremoSup = input('Ingresa el extremo superior');

tolerancia = input('Ingresar tolerancia(No ingresar nada para una tolerancia de 1e-5)');
if isempty(tolerancia)
  tol = 1e-5;
endif

iteracionesMaximas = input('Ingresar maximo de iteraciones(No ingresar nada para un max de iteraciones de 100)');
if isempty(iteracionesMaximas)
  tol = 100;
endif

try
  [raiz, iter] = biseccion(f, extremoInf, extremoSup, tolerancia, iteracionesMaximas);

  fprintf('\n---------------------------------------\n');
  fprintf(' Raíz aproximada = %.6f\n', raiz);
  fprintf(' Iteraciones realizadas = %d\n', iter);
  fprintf('---------------------------------------\n');
catch err
  fprintf('\nError: %s\n', err.message);
end_try_catch
