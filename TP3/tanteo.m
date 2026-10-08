function intervalos = tanteo(f, a, b, dx)
  % Devuelve una matriz Nx2: cada fila es un [x1 x2] con cambio de signo
  intervalos = [];
  
  fprintf('\n>>> BUSQUEDA DE RAICES POR TANTEO <<<\n');
  fprintf('%-10s | %-10s | %-15s | %-15s\n', 'x1', 'x2', 'f(x1)', 'f(x2)');
  fprintf('----------------------------------------------------------\n');

  x1 = a;
  while x1 < b
    x2 = min(x1 + dx, b);          % Evita pasarse
    
    fx1 = f(x1);
    fx2 = f(x2);
    
    % Determinamos el string del signo para f(x1)
    if fx1 > 0
        s1 = '(+)';
    elseif fx1 < 0
        s1 = '(-)';
    else
        s1 = '(0)';
    end
    
    % Determinamos el string del signo para f(x2)
    if fx2 > 0
        s2 = '(+)';
    elseif fx2 < 0
        s2 = '(-)';
    else
        s2 = '(0)';
    end
    
    str_f1 = sprintf('%8.2e %s', fx1, s1);
    str_f2 = sprintf('%8.2e %s', fx2, s2);
    
    if fx1 * fx2 < 0
      intervalos = [intervalos; x1 x2];
    end
    
    fprintf('%10.4f | %10.4f | %15s | %15s\n', x1, x2, str_f1, str_f2);
    
    x1 = x2;
  end
  fprintf('----------------------------------------------------------\n');
end
