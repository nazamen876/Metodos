clc; clear;

A = [ 18.72, 8.2, 8.76;
      6.4, 15.9, 7.18;
      5.22, 6.4, 14.31];
b = [121.280; 126.321; 118.522];

tol = 0.0001;
maxIter = 10;

x = 1; y = 1; z = 1; %Valores iniciales arbitrarios

for k = 1:maxIter
  xp = x; yp = y; zp = z;

  x = (b(1) - A(1,2)*y - A(1,3)*z / A(1,1));
  y = (b(2) - A(2,1)*x - A(2,3)*z / A(2,2));
  z = (b(3) - A(3,1)*x - A(3,2)*y / A(3,3));

  printf("Iteracion %2d: x = %.6f y =%.6f z=%.6f\n", k, x, y, z);

  if abs(x - xp) < tol && abs(y - yp) < tol && abs(z - zp) < tol
    break;
  end
end

printf("\nSolucion: x = %.6f, y = %.6f, z = %.6f (%d iteraciones)\n", x, y, z, k);

