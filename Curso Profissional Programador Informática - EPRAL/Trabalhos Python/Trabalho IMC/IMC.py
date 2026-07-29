#Indice de massa corporal
from asyncio.windows_events import NULL
import os

resposta = 'S'

while resposta == 'S' or 's':

    peso = float (input("Escreva o seu peso em KG --> "))
    altura = float (input("Escreva a sua altura em metros e com virgulas --> "))
    imc = peso/(altura*altura)
    print("O seu IMC é ", imc)

    if imc<18.5:
        print ("Abaixo do Peso")
    elif imc>=18.5 and imc<=25:
        print ("Peso Normal")
    elif imc>=25 and imc<=30:
        print("Acima do Peso Normal")
    elif imc>=30 and imc<=35:
        print("Obesidade Grau I")
    elif imc>=35 and imc<=40:
        print("Obesidade Grau II")
    elif imc>=40:
        print("Obesidade Grau III")

    print("Deseja Continuar?")
    resposta = (input("Se deseja continuar escreva S ou N -->"))
    print (resposta)
    if resposta =='N' or resposta =='n':
        exit()
        quit()
        
    elif resposta=='S' or resposta=='s':
        peso = NULL
        altura = NULL
        imc = NULL
        os.system('cls||clear')
    else:
        print("Carácter inválido Encerrando o sistema")
        exit()
        quit()