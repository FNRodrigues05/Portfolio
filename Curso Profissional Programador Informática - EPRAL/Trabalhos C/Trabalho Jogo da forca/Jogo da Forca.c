#include<stdio.h>
#include<locale.h>
#include <stdlib.h>

int main ()

{
    setlocale(LC_ALL,"Portuguese");//Escolhe a linguagem do código neste caso o português
    int vida;//Numerar as vidas
    int score;//Numerar o score
    int opcao;//Opção do menú
    char opcao2;//Opção de resetar o jogo ou não
    char palavra [8] = {'-','-','-','-','-','-','-','-'};//palavra a ser descoberta
    char letra;//letras da palavra
    int i=0;//Cria uma variavel que não deixa colocar a mesma letra duas vezes
    int n=0;//Cria uma variavel que não deixa colocar a mesma letra duas vezes
    int t=0;//Cria uma variavel que não deixa colocar a mesma letra duas vezes
    int e=0;//Cria uma variavel que não deixa colocar a mesma letra duas vezes
    int s=0;//Cria uma variavel que não deixa colocar a mesma letra duas vezes
    int o=0;//Cria uma variavel que não deixa colocar a mesma letra duas vezes



    label://serve como uma função para voltar a esta linha
    printf("                 \t        _____   \n");
    printf("                 \t       |     |  \n");
    printf("                 \t       o     |  \n");
    printf("   JOGO DA FORCA \t      /|\\    |  \n");
    printf("                 \t       |     |  \n");
    printf("  ----------------\t      / \\    |  \n");
    printf("   1-Iniciar jogo\t            _|_ \n");
    printf("   2-instruções  \t      _____|   |\n");
    printf("   3-acabar jogo \t     |         |\n");
    printf("  ----------------\t     |_________|\n");
    (vida=7);//Seleciona o número das vidas
    printf("\nEscolha uma opção--> ");
    scanf("%i",&opcao);//Dá scan na opção que o jogador escolher



    if (opcao == 3)//O if serve como um botão, caso o utilizador escolher 3 o jogo fecha
    {
      return 0;
    }

    if (opcao == 2)//O if serve com um botão, caso o utilizador escolher 2 aparece as instruções do jogo

    {
        printf("\n");
        printf("-------------------------------------------------------------------------------------");
        printf("\n|O jogador tenta adivinhar a palavra dizendo as letras que podem existir na palavra.|\n|Caso a letra não exista nessa palavra o boneco na forca vai perdendo os membros.   |\n");
        printf("-------------------------------------------------------------------------------------");
        printf("\n");
        printf("\n");
        goto label;//Volta até a função na linha 17
    }

    if(opcao == 1)//O if serve com um botão, caso o utilizador escolher 1 o jogo começa
    vida=8;//Número de vidas
    score=0;//Número de pontoss

    while (vida > 0 && score<23)//Enquanto a vida ser maior que 0 e os pontos serem menor que 23 o programa vai pedir uma palavra
    {
        printf("\nA palavra tem 7 espaços: %s", &palavra);
        printf("\n");
        label1://serve como uma função para voltar a esta linha
        printf("\nEscreve uma letra(minuscula e uma letra por vez) --> ");
        scanf("%s",&letra);//Dá scan na letra escrita pelo utilizador



        if(letra == 'i')//Se a letra for i vai fazer oque está dentro das chavetas
        {
            if (i>=1)//Se o utilizador intruduzir a letra t pela segunda vez ele terá que introduzir outra letra.
            {
                printf("\nEsta letra já foi inserida");
                printf("\n------------------------------------");
            }

            else
            {
            palavra[0] = '<';//coloca < na posição 0 da palavra
            palavra[1] = 'I';//coloca I na posição 1 da palavra
            printf("\n ");
            printf("\nAcertaste uma letra no 1º espaço %s", &palavra);
            score = score + 1;//Adiciona 1 aos pontos
            printf("\nPontuação: %i",score);
            printf("\n------------------------------------");
            printf("\n");
            i = i + 1;
            }
        }


        else if(letra == 'n')//Se a letra for n vai fazer oque está dentro das chavetas
        {
            if (n>=1)//Se o utilizador intruduzir a letra t pela segunda vez ele terá que introduzir outra letra.
            {
                printf("\nEsta letra já foi inserida");
                printf("\n------------------------------------");
            }

            else
            {
            palavra[0] = '<';//coloca < na posição 0 da palavra
            palavra[2] = 'n';//coloca n na posição 2 da palavra
            palavra[5] = 'n';//coloca n na posição 5 da palavra
            printf("\n ");
            printf("\nAcertaste uma letra no 2º e 5º espaço %s", &palavra);
            score = score + 10;//Adciona 10 aos pontos
            printf("\nPontuação: %i",score);
            printf("\n------------------------------------");
            printf("\n");
            n = n + 1;
            }
        }


        else if(letra == 't')//Se a letra for t vai fazer oque está dentro das chavetas
        {
            if (t>=1)//Se o utilizador intruduzir a letra t pela segunda vez ele terá que introduzir outra letra.
            {
                printf("\nEsta letra já foi inserida");
                printf("\n------------------------------------");
            }

            else
            {
            palavra[0] = '<';//coloca < na posição 0 da palavra
            palavra[3] = 't';//coloca t na posição 3 da palavra
            printf("\n ");
            printf("\nAcertaste uma letra no 3º espaço %s", &palavra);
            score = score + 5;//Adiciona 5 aos pontos
            printf("\nPontuação: %i",score);
            printf("\n------------------------------------");
            printf("\n");
            t = t + 1;
            }
        }


        else if(letra == 'e')//Se a letra for e vai fazer oque está dentro das chavetas
        {
            if (e>=1)//Se o utilizador intruduzir a letra t pela segunda vez ele terá que introduzir outra letra.
            {
                printf("\nEsta letra já foi inserida");
                printf("\n------------------------------------");
            }

            else
            {
            palavra[0] = '<';//coloca < na posição 0 da palavra
            palavra[4] = 'e';//coloca e na posição 4 da palavra
            printf("\n ");
            printf("\nAcertaste uma letra no 4º espaço %s", &palavra);
            printf("\nPontuação: %i",score);
            score = score + 1;//Adiciona 1 aos pontos
            printf("\n------------------------------------");
            printf("\n");
            e = e + 1;
            }
        }


        else if(letra == 's')//Se a letra for s vai fazer oque está dentro das chavetas
        {
            if (s>=1)//Se o utilizador intruduzir a letra t pela segunda vez ele terá que introduzir outra letra.
            {
                printf("\nEsta letra já foi inserida");
                printf("\n------------------------------------");
            }

            else
            {
            palavra[0] = '<';//coloca < na posição 0 da palavra
            palavra[6] = 's';//coloca s na posição 6 da palavra
            printf("\n ");
            printf("\nAcertaste uma letra no 6º espaço %s", &palavra);
            printf("\nPontuação: %i",score);
            score = score + 5;//Adiciona 5 aos pontos
            printf("\n------------------------------------");
            printf("\n");
            s = s + 1;
            }
        }


        else if(letra == 'o')//Se a letra for o vai fazer oque está dentro das chavetas
        {
            if (o>=1)//Se o utilizador intruduzir a letra t pela segunda vez ele terá que introduzir outra letra.
            {
                printf("\nEsta letra já foi inserida");
                printf("\n------------------------------------");
            }

            else
            {
            palavra[0] = '<';//coloca < na posição 0 da palavra
            palavra[7] = 'o';//coloca o na posição 7 da palavra
            printf("\n ");
            printf("\nAcertaste uma letra no 7º espaço %s", &palavra);
            score = score + 1;//Adiciona 1 aos pontos
            printf("\nPontuação: %i",score);
            printf("\n------------------------------------");
            printf("\n");
            o = o + 1;
            }
        }

            else//Este else serve para quando a letra que o utilizador inseriu estiver errada
                {
                    printf("\n");
                    printf("Erraste e perdeste uma vida\n");
                    (vida=vida-1);//Retira uma vida
                    printf("  Agora só tens %i vidas\n",vida);
                    printf("\nPontuação: %i",score);
                    printf("\n------------------------------------");
                    printf("\n");
                }

    }

            if (vida<=0)//Se a vida for menor ou igual a 0 este if é ativado
            {
                printf("\n ");
                printf("\n----------------------------------------------------------------");
                printf("\n| As tuas vidas acabaram e conseguiste a pontuação de %i pontos |",score);
                printf("\n----------------------------------------------------------------");
                printf("\n");
                printf("\n");
                printf("\nSe queres continuar a jogar escreve um S senão escreve um N (Maiusculo) \n --> ");
                scanf("%s",&opcao2);//Dá scan á opção de resetar o jogo
            }

            else//Este else serve para guando o utilizador ganhar o jogo
            {
                score=score+25;//Adiciona um bónus aos pontos
                printf("\n ");
                printf("\n----------------------------------------");
                printf("\n|Parabéns ganhaste o jogo com %i pontos|",score);
                printf("\n----------------------------------------");
                printf("\n");
                printf("\n");
                printf("\nSe queres continuar a jogar escreve um S senão escreve um N (Maiusculo) \n --> ");
                scanf("%s",&opcao2);//Dá scan á opção de resetar o jogo
            }

        if (opcao2 == 'S')//Se a opção de resetar o jogo for S ele irá correr estes comandos
        {
            printf("\n");
            printf("Jogo Recomeçando");
            printf("\n");
            printf("\n");
            printf("\n");
            vida=8;//Resetar a vida para 8
            score=0;//Resetar o score para 0
            palavra [0] = '<';//Resetar a palavra a ser descoberta
            palavra [1] = '-';//Resetar a palavra a ser descoberta
            palavra [2] = '-';//Resetar a palavra a ser descoberta
            palavra [3] = '-';//Resetar a palavra a ser descoberta
            palavra [4] = '-';//Resetar a palavra a ser descoberta
            palavra [5] = '-';//Resetar a palavra a ser descoberta
            palavra [6] = '-';//Resetar a palavra a ser descoberta
            palavra [7] = '-';//Resetar a palavra a ser descoberta
            palavra [8] = '-';//Resetar a palavra a ser descoberta
            i=0;//Reseta a letra
            n=0;//Reseta a letra
            t=0;//Reseta a letra
            e=0;//Reseta a letra
            s=0;//Reseta a letra
            o=0;//Reseta a letra
            opcao=0;//Resetar a opcao do menu
            system("cls");//Apaga todos os códigos na linha de comandos
            goto label;//Volta até á função da linha 17
        }

        if (opcao2 == 'N')//Se a opção de resetar o jogo for N ele irá correr encerrar o jogo
        {
            printf("\nEncerrando Jogo...\n");
            return 0;
        }
}
