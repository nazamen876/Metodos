/* 
	1. 	Dado N números positivos, hallar la suma de todos los valores de x1 a xN. Probar con N
		comprendido en el siguiente rango de representación de números enteros: 0 a 255.
		Luego probar con N=10000.
*/

#include <stdio.h>
// Variables globales
int x=0, suma=0;


// Función principal
int main() {
	do {
		printf("Ingrese un numero: ");
		scanf("%d", &x);
		if (x!=-1) {
			suma = suma + x;
		}
	}while(x!=-1);
	
	printf("Suma: %d", suma);
	return 1;
}


