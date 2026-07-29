#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    int opcao,num1,num2,num3,num4,resultado;
    float result,num5;
    double num6,resulta;

    label:
    cout<< "\n-----------Love matematica-----------";
    cout<<"\n\n      ---------MENU---------";
    cout<< "\n";
    cout<< "\n1 - Somar dois numeros";
    cout<< "\n2 - Escrever dois numeros e ver o maior deles";
    cout<< "\n3 - Escrever um numero para calcular a raiz quadrada";
    cout<< "\n4 - Calcular o sin de um numero\n\n";
    cout<< "Escolha uma opcao--";
    cin>>opcao;

    switch(opcao)
    {
        case 1:

        cout<<"\n\n\nEscreva o primeiro numero--";
        cin>>num1;
        cout<<"\nEscreva o segundo numero--";
        cin>>num2;
        (resultado=(num1)+(num2));
        cout<<"\nO resultado foi"<<resultado;
        cout<<"\n\n\n";
        goto label1;
        break;


        case 2:

        label1:
        cout<<"\n\n\nEscreva o primeiro numero--";
        cin>>num3;
        cout<<"\nEscreva o segundo numero--";
        cin>>num4;
        if (num3<num4)
        {
            cout<<"\n\nO numero "<<num3<<" e maior que o numero"<<num4;
            cout<<"\n\n\n";
            goto label1;
        }

        else if(num4>num3)
        {
            cout<<"\n\nO numero "<<num4<<" e maior que o numero"<<num3;
        }

        else if(num4==num3)
        {
            cout<<"\n\nO numero "<<num4<<" e igual ao numero"<<num3;
        }

        else
        {
            cout<<"\n\nnNumero invalido";
            goto label1;
        }
        break;


        case 3:

        cout<<"\n\nEscreva um numero--";
        cin>>num5;
        result=sqrt(num5);
        cout<<"\nA raiz quadrada de "<<num5<<" e "<<result;
        break;

        case 4:

        cout<<"\n\nEscreva um numero--";
        cin>>num6;
        resulta = sin (num6);
        cout<<"\nO seno de "<<num6<<" e "<<resulta;
        break;

    }
    return 0;
}
