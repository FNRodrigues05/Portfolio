import random
tab = [["-","-","-"],["-","-","-"],["-","-","-"]]


def resetar_tab():
    global tab
    tab = [["-","-","-"],["-","-","-"],["-","-","-"]]

def mostrar_tab():
    for l in range(3):
        for c in range(3):
            print(tab[l][c], end=' ')
        print()

def check():
    #3 linhas na horizontal
    if tab[0][0] == tab[0][1] == tab[0][2] == 'X' or tab[0][0] == tab[0][1] == tab[0][2] == 'O':
        print("\nO jogador " + tab[0][0] + " Ganhou\n")
        return 0
    elif tab[1][0] == tab[1][1] == tab[1][2] == 'X' or tab[1][0] == tab[1][1] == tab[1][2] == 'O':
        print("\nO jogador " + tab[1][0] + " Ganhou\n")
        return 0
    elif tab[2][0] == tab[2][1] == tab[2][2] == 'X' or tab[2][0] == tab[2][1] == tab[2][2] == 'O':
        print("\nO jogador " + tab[2][0] + " Ganhou\n")
        return 0
        
    #3 colunas na vertical
    elif tab[0][0] == tab[1][0] == tab[2][0] == 'X' or tab[0][0] == tab[1][0] == tab[2][0] == 'O':
        print("\nO jogador " + tab[0][0] + " Ganhou\n")
        return 0
    elif tab[0][1] == tab[1][1] == tab[2][1] == 'X' or tab[0][1] == tab[1][1] == tab[2][1] == 'O':
        print("\nO jogador " + tab[0][1] + " Ganhou\n")
        return 0
    elif tab[0][2] == tab[1][2] == tab[2][2] == 'X' or tab[0][2] == tab[1][2] == tab[2][2] == 'O':
        print("\nO jogador " + tab[0][2] + " Ganhou\n")
        return 0

    #2 diagonais
    elif tab[0][0] == tab[1][1] == tab[2][2] == 'X' or tab[0][0] == tab[1][1] == tab[2][2] == 'O':
        print("\nO jogador " + tab[0][0] + " Ganhou\n")
        return 0
    elif tab[0][2] == tab[1][1] == tab[2][0] == 'X' or tab[0][2] == tab[1][1] == tab[2][0] == 'O':
        print("\nO jogador " + tab[0][2] + " Ganhou\n")
        return 0

def jogar_PvCPU():
    resetar_tab()
    while True:
        while True:
            resposta = input("\nDesejar jogar como 'X' ou 'O'--> ").lower()

            if (resposta=='x'):
                jogador="X"
                cpu="O"
                break
            elif (resposta=='o'):
                jogador="O"
                cpu="X"
                break
            else:
                print("\nEscreva uma opção válida\n")
        tentativas = 9
        while tentativas > 0:
            mostrar_tab()
            while True:
                if tentativas%2 == 0:
                    vez_jogador = jogador
                else:
                    vez_jogador = cpu
                print("\nÉ a vez do jogador "+vez_jogador+"\n\n")

                if (vez_jogador==jogador):
                    while True:
                        linha = input("Escreva em qual linha deseja jogar -->")
                        if linha in ['1','2','3']:
                            linha = int(linha)-1
                            break
                    while True:
                        coluna = input("Escreva em qual coluna deseja jogar -->")
                        if coluna in ['1','2','3']:
                            coluna = int(coluna)-1
                            break
                    print("\n")

                elif (vez_jogador==cpu):
                    linha = random.choice([0,1,2])
                    coluna = random.choice([0,1,2])

                if tab[linha][coluna] =="-":
                    if vez_jogador =="X":
                        tab[linha][coluna] = "X"
                    else:
                        tab[linha][coluna] = "O"

                    tentativas-=1
                    break
                else:
                    if (vez_jogador==jogador):
                        print("Lugar Ocupado")
                        mostrar_tab()
                        break
                    else:
                        break
            if tentativas == 0:
                mostrar_tab()
                print("Ninguém ganhou, deu um empate\n")
                break
            else:
                c = check()
                if c == 0:
                    mostrar_tab()
                    print("\n")
                    break

        resposta = input("Deseja continuar a jogar?? S ou N -->").lower()
        if resposta == "s":
            resetar_tab()
        elif resposta == "n":
            break
                


def jogar_PvP():
    resetar_tab()
    while True:
        vez_jogador = "X"
        tentativas = 9
        while tentativas > 0:
            mostrar_tab()
            while True:
                if tentativas%2 == 0:
                    vez_jogador="X"
                else:
                    vez_jogador="O"
                print("\nÉ a vez do jogador "+vez_jogador+"\n\n")

                while True:
                    linha = input("Escreva em qual linha deseja jogar -->")
                    if linha in ['1','2','3']:
                        linha = int(linha)-1
                        break
                while True:
                    coluna = input("Escreva em qual coluna deseja jogar -->")
                    if coluna in ['1','2','3']:
                        coluna = int(coluna)-1
                        break
                print("\n")

                if tab[linha][coluna] == "-":
                    if vez_jogador == "X":
                        tab[linha][coluna] = 'X'
                    else:
                        tab[linha][coluna] = 'O'

                    tentativas-=1
                    break
                else:
                    print("Lugar Ocupado")
                    mostrar_tab()
            
            if tentativas == 0:
                mostrar_tab()
                print("Ninguém ganhou, deu um empate\n")
                break
            else:
                c = check()
                if c == 0:
                    mostrar_tab()
                    break

        resposta = input("Deseja continuar a jogar?? S ou N -->").lower()
        if resposta == "s":
            resetar_tab()
        elif resposta == "n":
            break

while True:
    print("\n<----JOGO DO GALO---->")
    print("\n1-Player vs CPU")
    print("2-Player vs Player")
    print("3-Sair")
    resposta = input("\nEscreva o numero de qual deseja jogar--> ")
    if resposta in ['1','2','3']:
        resposta = int(resposta) 
    else:
        print("\nEscreva uma opção válida\n\n")
    if (resposta==1):
        jogar_PvCPU()
    elif (resposta==2):
        jogar_PvP()
    elif (resposta==3):
        print("\n\nSaindo..")
        break

