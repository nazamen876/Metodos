/* 
	5. 	Calcular e imprimir el valor del número e como suma de la serie. Teniendo en cuenta que
		la precisión será mayor cuanto mayor sea el dato de entrada N (entero positivo). Probar
		con diferentes cantidades de sumandos y sacar conclusiones.
*/

#include <stdio.h>

// Variables globales
int N = 0;
float e = 0;


// Prototipo de las funciones
int NumeroFactorizado(int);


// Bloque principal
int main() {
	printf("Ingrese el dato de entrada: ");
	scanf("%d", &N);
	
	for(int i=0; i <= N; i++) {
		e = e + 1 / (float)NumeroFactorizado(i);
		
	}
	
	printf("e: %.8f", e);
	
	return 1;
}


//Desarrollo de las funciones
int NumeroFactorizado(int pNum) {
	int numFactorizado = pNum;
	
	if (pNum == 0 || pNum == 1) {
		return 1;
	} else {
		do {
			pNum = pNum - 1;
			numFactorizado = numFactorizado * pNum;
		}while(pNum != 1);
		
		return numFactorizado;
	}
}

