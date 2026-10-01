%{
  3.  Para vender x unidades de su producto semanalmente, una compañía debe
      gastar A pesos semanales en publicidad, donde A = 200ln(400/500-x).
      Los objetos se venden a $5 cada uno. La utilidad neta es entonces R(x) =5x-A.
      Calcular el número de unidades x que debe de vender para tener una utilidad neta
      de R(x)= $1000 pesos. En un entorno de x=200:
      a.  Resolver el ejercicio anterior a aplicando el algoritmo del Método de
          Iteración con E<10-4. Aplicar el método conjuntamente con la Aceleración de
          Aitken con E<10-4.
%}

function MetodoIteracion()
  clc;

  f = @(x) 40 * log(400 / (500 - x)) + 200;

  opcion = input("Desea aplicar la aceleracion de Aitken? (1. Sí/2. No): ");

  x0 = 200;
  tolerancia = 10^-4;
  max_iter = 100;

  x = zeros(max_iter, 1);
  x(1) = x0;


  if opcion ==1
    % Método de punto fijo con aceleración de Aitken %
    i = 1;
    while i <= max_iter - 2
      x(i+1) = f(x(i));
      x(i+2) = f(x(i+1));

      den = x(i+2) - 2*x(i+1) + x(i);
      if abs(den) < 1e-12
        break;
      endif
      x_aitken = x(i) - ((x(i+1) - x(i))^2) / den;

      printf("Iteracion %d: x_aitken = %.6f\n", i, x_aitken);

      if i > 1 && abs(x_aitken - x_prev) < tolerancia
        x_final = x_aitken;
        break;
      endif
      x_prev = x_aitken;
      i = i + 1;
    end
  else
    % Método de iteración simple de punto fijo %
    i = 1;
    while i < max_iter
      x(i+1) = f(x(i));
      printf("Iteracion %d: x = %.6f\n", i, x(i+1));

      if abs(x(i+1) - x(i)) < tolerancia
        x_final = x(i+1);
        break;
      endif
      i = i + 1;
    endwhile
  endif

  printf("Resultado aproximado: x = %.6f\n", x_final);

  % Gráfico de las funciones %
  opcion = input("Graficar las raices?(1. Si/2. No)");
  if opcion == 1
    figure;
    x_vals = linspace(180, 220, 400);
    y_vals = arrayfun(f, x_vals);

    plot(x_vals, x_vals, 'r--', 'LineWidth', 1.5); hold on;
    plot(x_vals, y_vals, 'b-', 'LineWidth', 2);
    plot(x_final, x_final, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

    xlabel('x');
    ylabel('y');
    title("Método de Iteracion de Punto Fijo y Aceleración de Aitken");
  endif
endfunction


