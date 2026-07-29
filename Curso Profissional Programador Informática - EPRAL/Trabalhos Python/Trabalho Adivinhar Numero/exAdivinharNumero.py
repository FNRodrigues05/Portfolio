import random
import csv

def guardar_ficheiro (tent, num_limite):
    with open("AdivinharNumero.csv","w",newline="",encoding="UTF-8") as f:
        ficheiro=csv.writer(f)
        ficheiro.writerow([tent,num_limite])

def ler_ficheiro ():
    with open("AdivinharNumero.csv","r",newline="",encoding="UTF-8") as f:
        ficheiro=csv.reader(f)
        for a in ficheiro:
            tent = a[0]
            num_limite = a[1]

        return tent, num_limite



vitoria = "s"
lista = []



nome = input("Escreva o seu nome--> ")

while True:
    lista = []
    vitoria = "n"
    menu = input("""
    <--------------Menu-------------->
    1-Fácil(Números entre 0 e 10)
    2-Médio(Números entre 0 e 50)
    3-Dificil(Números entre 0 e 100)
    4-Personalizado
    5-Sair

    Escreva um número--> """)

    if menu=="1":
        num_gerado_facil = random.randint(0,10)
        tentativas1=3
        while True:
            try:
                while tentativas1>0 and vitoria!="s":
                    print("Tem ", tentativas1," tentativas")
                    resp1=int(input("Escreva um número entre 0 e 10--> "))
                    
                    if resp1>10 or resp1<0:
                        print("Escreva só números entre 0 e 10.")
                    else:
                        lista.append(resp1)
                        if resp1 == num_gerado_facil:
                            print("\nParabéns ",nome," acertou no número ",num_gerado_facil,"\n")
                            print("As suas tentativas foram-->",lista)
                            vitoria="s"
                            
                        elif resp1 > num_gerado_facil:
                            tentativas1=tentativas1-1
                            print("<<--O número é menor-->>")
                        elif resp1 < num_gerado_facil:
                            tentativas1=tentativas1-1
                            print("<<--O número é maior-->>")

                if tentativas1==0:
                    print("Acabaram as suas tentativas e o número era ",num_gerado_facil)
                    print("Tentativas falhadas --> ",lista)
                    break
            except ValueError:
                print("Escreva só números")
            break


    elif menu=="2":
        num_gerado_medio = random.randint(0,50)
        tentativas2=5
        while True:
            try:
                while tentativas2>0 and vitoria!="s":
                    print("Tem ", tentativas2," tentativas")
                    resp2=int(input("Escreva um número entre 0 e 50--> "))

                    if resp2>50 or resp2<0:
                        print("Escreva só números entre 0 e 50.")
                    else:
                        lista.append(resp2)
                        if resp2 == num_gerado_medio:
                            print("\nParabéns ",nome," acertou no número ",num_gerado_medio,"\n")
                            print("As suas tentativas foram-->",lista)
                            vitoria="s"
                            
                        elif resp2 > num_gerado_medio:
                            tentativas2=tentativas2-1
                            print("<<--O número é menor-->>")
                        elif resp2 < num_gerado_medio:
                            tentativas2=tentativas2-1
                            print("<<--O número é maior-->>")

                if tentativas2==0:
                    print("Acabaram as suas tentativas e o número era ",num_gerado_medio)
                    print("Tentativas falhadas --> ",lista)
                    break
            except ValueError:
                print("Escreva só números")
            break

    
    elif menu=="3":
        num_gerado_dificil = random.randint(0,100)
        tentativas3=5
        while True:
            try:
                while tentativas3>0 and vitoria!="s":
                    print("Tem ", tentativas3," tentativas")
                    resp3=int(input("Escreva um número entre 0 e 100--> "))

                    if resp3>100 or resp3<0:
                        print("Escreva só números entre 0 e 100.")
                    else:
                        lista.append(resp3)
                        if resp3 == num_gerado_dificil:
                            print("\nParabéns",nome," acertou no número ",num_gerado_dificil,"\n")
                            print("As suas tentativas foram-->",lista)
                            vitoria="s"
                            
                        elif resp3 > num_gerado_dificil:
                            tentativas3=tentativas3-1
                            print("<<--O número é menor-->>")
                        elif resp3 < num_gerado_dificil:
                            print("<<--O número é maior-->>")
                            tentativas3=tentativas3-1

                if tentativas3==0:
                    print("Acabaram as suas tentativas e o número era ",num_gerado_dificil)
                    print("Tentativas falhadas --> ",lista)
                    break
            except ValueError:
                print("Escreva só números")
            break


    elif menu=="4":
        tent, num_limite = ler_ficheiro()
        while True:
            print("A configuração anterior é de ", tent, "tentativas e",num_limite," de numero limite")
            resposta=input("Deseja utilizar a configuração anterior? (sim/nao)-->")
            resposta=resposta.lower()

            if resposta=="sim":
                tentativas4 = int(tent)
                num = int(num_limite)
                break
            elif resposta=="nao":
                while True:
                    try:
                        tentativas4=int(input("Quantas tentativas deseja ter--> "))
                        break
                    except ValueError:
                        print("Escreva um número de tentativas provável\n\n")
                while True:
                    try:
                        num=int(input("Escreva o número mais alto a aparecer--> "))
                        break
                    except ValueError:
                        print("Escreva um número provável\n\n")
                break
            else:
                print("Escreva sim ou nao")

        guardar_ficheiro(tentativas4,num)
        num_gerado_personalizado = random.randint(0,num)
        while True:
            try:
                while tentativas4>0 and vitoria!="s":
                    print("Tem ", tentativas4," tentativas")
                    while True:
                        try:
                            resp4 = int(input(f"Escreva um número entre 0 e {num}--> "))
                            break
                        except ValueError:
                            print("Escreva um número provável")

                    if resp4>num or resp4<0:
                        print(f"Escreva só números entre 0 e {num}.")
                    else:
                        lista.append(resp4)
                        if resp4 == num_gerado_personalizado:
                            print("Parabéns ",nome," acertou no número ",num_gerado_personalizado)
                            print("As suas tentativas foram-->",lista)
                            vitoria="s"
                            
                        elif resp4 > num_gerado_personalizado:
                            tentativas4=tentativas4-1
                            print("<<--O número é menor-->>")
                        elif resp4 < num_gerado_personalizado:
                            tentativas4=tentativas4-1
                            print("<<--O número é maior-->>")

                if tentativas4==0:
                    print("Acabaram as suas tentativas e o número era ",num_gerado_personalizado)
                    print("Tentativas falhadas --> ",lista)
                    break
            except ValueError:
                print("Escreva só números")
            break

    elif menu=="5":
        break
    else:
        print("Escreva uma opção válida")