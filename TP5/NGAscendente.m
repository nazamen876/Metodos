x0 = 0.35;
h = 0.3;

x = [0.2 0.5 0.8 1.1 1.4];
y = [0.258 2.535 4.902 6.722 10.704];

dif = tablaDiferencias(x, y);

display(x(1));
function P = NGAscendente(x, h, dif)
  u = (x0 - x(1)) / h;
  P = 0;

  producto = 1;
  for i = 1 : length(dif) - 1
    % hay flaquezas aca
    producto = producto * (u - (k-1));
    P = P + producto / factorial(k) * dif(k+1);
  end
endfunction
