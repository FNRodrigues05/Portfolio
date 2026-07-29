#include <stdio.h>
#include <locale.h>


void main() {

    setlocale(LC_ALL,NULL);
    setlocale(LC_ALL,"portuguese");


    float horas;
    horas = 24;
    int resposta, i, inum, dias, resultado;


    printf("\n\n");
    printf(" ---------------------MENU---------------------\n");
    printf("|                                              |\n");
    printf("| 1 - Escreva numeros na tela                  |\n");
    printf("| 2 - Descubra quantos horas tem certos dias   ");
    printf("| \n|                                              |\n");
    printf(" ----------------------------------------------\n");
    printf("\n\nEscreva a sua resposta-- ");
    scanf("%d", &resposta);

if (resposta==1)
{
    printf("\n\nEscreva quantos numeros quer que apareçam na tela---");
    scanf("%d", &inum);
    printf("\n");
    inum = inum + 1;

    for (i= 1; i < inum; ++i)
  {
    printf("%d ", i);
  }
  printf("\n\n");

}

else if (resposta==2)
{
    printf("\nEscreva quantos dias para multiplicar---");
    scanf("%d", &dias);
    printf("\n");
    printf("%d dias", dias);
    printf(" x ");
    printf("%.f horas", horas);
    printf("\n");
    resultado=horas*dias;
    printf("\nO resultado foi de %d horas", resultado);
    printf("\n\n");


}

else
{
    printf("\n");
    printf("Escreva um numero");
    printf("\n");
    return 0;

}



}
