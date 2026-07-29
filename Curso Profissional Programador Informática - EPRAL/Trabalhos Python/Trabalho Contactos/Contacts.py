import csv
lista = []

while True:
    menu = input("""
    1- Ler Ficheiro
    2- Inserir Dados
    3- Procurar Dados
    4- Eliminar Dados
    5- Listar Dados
    6- Guardar Dados
    7- Editar Dados
    8- Sair
""")

    if menu =="1":
        with open ("lista.csv", newline="", encoding='utf-8') as f:
            lista_csv = csv.reader(f)
            for l in lista_csv:
                lista.append(l)
            print(lista)

    elif menu =="2":
        while True:
            nome = input ("Insira um Nome--> ")
            while True:
                contacto = input("Insira um Contacto--> ")
                if len(contacto)!=9:
                    print("O contacto tem mais ou menos de 9 numeros.")
                else:
                    try:
                        contacto=int(contacto)
                        break
                    except ValueError:
                        print('Só Números')
            email = input ("Insira um Email--> ")
            lista.append([nome.lower(),contacto,email.lower()])
            cont=input("Quer inserir mais dados? S/N--> ")
            if cont.lower()== "n":
                break
                
    elif menu =="3":
        nome = input ("Escreva o nome a procurar--> ")
        c = 0
        for contacto in lista:
            if nome in contacto:
                print("O nome esta na lista")
                print(f'\nNome: {contacto[0]}\nTelemovel: {contacto[1]} \nEmail: {contacto[2]}\n')
                c = 1
        if c == 0:
            print("O nome nao esta na lista")

    elif menu =="4":
        nome = input ("Escreva o nome a eliminar--> ")
        c = 0
        for contacto in lista:
            if nome in contacto:
                print("O nome esta na lista e vai ser apagado")
                lista.remove(contacto)
                c = 1
        if c == 0:
            print("O nome nao existe na lista")

    elif menu=="5":
        for contacto in lista:
            print(f'\nNome: {contacto[0]}\nTelemovel: {contacto[1]} \nEmail: {contacto[2]}\n')
        
    
    elif menu =="6":
        with open("lista.csv",'w', newline="", encoding='utf-8') as f:
            lista_csv = csv.writer(f)
            lista_csv.writerows(lista)
        print("Dados guardados com sucesso")

    elif menu =="7":
        nome = input ("Escreva o nome a procurar--> ")
        c = 0
        ind = 0
        for contacto in lista:
            if nome in contacto:
                print("O nome esta na lista")
                print(f'\nNome: {contacto[0]}\nTelemovel: {contacto[1]} \nEmail: {contacto[2]}\n')
                c = 1
                while True:
                    opcao=input("Escreva o dado a editar-(1-Nome/2-Telemovel/3-Email)")
                    if opcao=="1":
                        novo_dado=input("Escreva o novo dado--> ")
                        lista[ind][0] = novo_dado
                        break
                    elif opcao=="2":
                        novo_dado=input("Escreva o novo dado--> ")
                        lista[ind][1]=novo_dado
                        break
                    elif opcao=="3":
                        novo_dado=input("Escreva o novo dado--> ")
                        lista[ind][2]=novo_dado
                        break
                    else:
                        print("Escreva uma opção válida")
            ind+=1
        if c == 0:
            print("O nome nao esta na lista")


    elif menu =="8":
        break
    
    else:
        print("Escreva uma opção válida")


