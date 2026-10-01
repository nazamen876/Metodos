function y = redondear(x, d)
  % Redondea a d cifras significativas
  y = x;
  nz = (x != 0);
  e = floor(log10(abs(x(nz))));
  f = 10 .^ (d - 1 - e);
  y(nz) = round(x(nz) .* f) ./ f;
endfunction
