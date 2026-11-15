function P = NGAscendente(x, vectorX, dif)
  h = vectorX(2) - vectorX(1);

  u = (x - vectorX(1)) / h;
  display(u);

  P = 0;
  producto = 1;
  for i = 1 : length(dif)
    % ya no hay flaquezas aca
    display(producto);
      P = P + dif(i) / factorial(i-1) * producto;
      producto = producto * (u - (i-1));

    display(P);
  end


endfunction
