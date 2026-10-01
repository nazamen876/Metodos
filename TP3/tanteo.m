function intervalos = tanteo(f, a, b, dx)
  % Devuelve una matriz Nx2: cada fila es un [x1 x2] con cambio de signo
  intervalos = [];
  x1 = a;
  while x1 < b
    x2 = min(x1 + dx, b);          % Evita pasarse
    if f(x1) * f(x2) < 0
      intervalos = [intervalos; x1 x2];
    end
    x1 = x2;
  end
end
