clc
clear
close all

sumaTotal = 0;

for i = 1:200
  if(mod(i,2) == 0)
  sumaTotal += i;
endif
end
fprintf("La suma total es: %.2f\n", sumaTotal);

