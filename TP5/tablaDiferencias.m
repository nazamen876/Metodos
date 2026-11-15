function dif = tablaDiferencias(x, y)

  n = length(y);
  h = x(2) - x(1);          % paso (x equiespaciado)

  % Tabla de diferencias avanzadas
  D = zeros(n, n);
  D(:,1) = y(:);
  for k = 2:n
      for i = 1:(n-k+1)
          D(i,k) = D(i+1,k-1) - D(i,k-1);
      end
  end

  % Variable con los valores de la primera fila: [y0 Dy0 D2y0 D3y0 D4y0]
  dif = D(1,:);

endfunction
