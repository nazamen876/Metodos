n = 4;
tolerancia = 10^(-n);

pi_aprox = 0;
k = 0; %Terminos

t_inicio = cputime(); % Inicio de medición de tiempo

while abs(pi_aprox - pi) >= tolerancia
    termino = 4 * ((-1)^k / (2*k + 1));
    pi_aprox = pi_aprox + termino;
    k = k + 1;
endwhile

tiempo_total = cputime() - t_inicio;

printf("Decimales: %d | Términos: %d | Pi aprox: %.6f | Tiempo: %.4f s\n", ...
       n, k, pi_aprox, tiempo_total);
