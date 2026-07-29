#include <stdio.h>
#include <locale.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

int main()
{
    setlocale(LC_ALL, "Portuguese");

    char stop[99];
    int opcao;
    char opcao2, opcao3;
    int num1, num2, resultado;
    char nome[99], apelido[99];
    int hora1;

label:
    printf("\n-------------MENU-------------");
    printf("\n1 - Inserir Nome e Sobrenome");
    printf("\n2 - Inserir 2 números e somar");
    printf("\n3 - Guardar a hora atual");
    printf("\n4 - Sair");
    printf("\n------------------------------");
    printf("\n");
    printf("\nEscolha uma opção--");
    scanf("%i", &opcao);

    if (opcao == 1 || opcao == 2 || opcao == 3 || opcao == 4 || opcao == 5)
    {
        if (opcao == 5)
        {
        label3:
            printf("\nEscreveu um número ou letra inválida");
            printf("\nDeseja continuar? (Escreva S)--");
            scanf("%s", &opcao3);
            printf("\n-------------------------------------");
            system("cls");

            if (opcao3 == 'S')
            {
                printf("\n");
                system("cls");
                goto label;
            }

            else if (opcao3 == 'SAIR')
            {
                return 0;
            }

            else
            {
                goto label3;
            }

            goto label;
        }

        if (opcao == 4)
        {
            printf("Fechando...");
            return 0;
        }

        if (opcao == 3)
        {
            FILE *Hora;
            Hora = fopen("Hora.txt", "w");
            struct timeval usec_time;
            time_t now = time(0);
            gettimeofday(&usec_time, NULL);
            struct tm *current = localtime(&now);

            printf("--------------");
            printf("\n São %d:%d do dia %d do mês %d do ano %d ", current->tm_hour, current->tm_min, current->tm_mday, current->tm_mon + 1, current->tm_year + 1900);
            printf("\n--------------");
            fprintf(Hora, "São às %d:%d do dia %d do mês %d do ano %d ", current->tm_hour, current->tm_min, current->tm_mday, current->tm_mon + 1, current->tm_year + 1900);
            goto label;
        }

        if (opcao == 2)
        {
            printf("Clique numa tecla para continuar-");
            scanf("%s", &stop);

            num1 = 0;
            num2 = 0;
            resultado = 0;

            printf("\n----------------------------");
            printf("\nEscreva o primeiro número--");
            scanf("%i", &num1);

            printf("\n----------------------------");
            printf("\nEscreva o segundo número--");
            scanf("%i", &num2);

            (resultado = (num1) + (num2));
            printf("\n----------------------------");
            printf("\nO resultado é %i", resultado);
            printf("\n----------------------------");
            printf("\n");

            num1 = 0;
            num2 = 0;
            resultado = 0;

            printf("\nVoltar para o menu (Escreva S )--");
            scanf("%s", &opcao2);
            printf("\n-------------------------------------");

            if (opcao2 == 'S')
            {
                printf("\n");
                system("cls");
                goto label;
            }

            else
            {
                system("cls");
                printf("\n-------------------------------------");
                goto label3;
            }
        }

        if (opcao == 1)
        {
            FILE *nome_completo;
            nome_completo = fopen("Nome Completo.txt", "w");

            printf("\n-----------------------------------------");
            printf("\n");
            printf("\nEscreva o seu Primeiro Nome--");
            scanf("%s", &nome);
            fprintf(nome_completo, "%s", nome);
            printf("\n");

            printf("\n-----------------------------------------");
            printf("\n");
            printf("\nEscreva o seu último apelido--");
            scanf("%s", &apelido);
            fprintf(nome_completo, "\n%s", apelido);
            printf("\n-----------------------------------------");
            fclose(nome_completo);
            system("cls");
            goto label;
        }
    }

    else
    {
        goto label3;
    }
}
