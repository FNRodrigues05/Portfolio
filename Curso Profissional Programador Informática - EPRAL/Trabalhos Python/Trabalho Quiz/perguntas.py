certas=0
print("\n\n<-----Jogo de Perguntas----->\n\n")

print("<--Perguntas sobre Geografia-->")



print("\n\nPor área, qual é o menor país do mundo")
print("A-Granada,   B-Malta,   C-Monaco,   D-Vaticano")
while True:
    resposta1 = input("\nEscreva a resposta-->").upper()
    if resposta1 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta1 =="D":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nOnde fica localizada a cidade Nápoles?")
print("A-Califórnia,   B-França,   C-Itália,   D-Veneza")
while True:
    resposta2 = input("\nEscreva a resposta-->").upper()
    if resposta2 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta2 =="C":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nEm que país se localiza o Cristo Redentor?")
print("A-Colombia,   B-México,   C-Brasil,   D-Guatemala")
while True:
    resposta3 = input("\nEscreva a resposta-->").upper()
    if resposta3 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta3 =="C":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")


print("\n\n<--Perguntas sobre Conhecimento Geral-->")



print("\n\nDe quem é a famosa frase “Penso, logo existo”?")
print("Respostas: A-Platão,   B-Descartes,   C-Galileu Galilei,   D-Sócrates")

while True:
    resposta4 = input("\nEscreva a resposta-->").upper()
    if resposta4 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta4 =="B":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nQual o livro mais vendido no mundo a seguir à Bíblia?")
print("Respostas: A-Dom Quixote,   B-O Pequeno Príncipe,   C-O Senhor dos Anéis,   D-Harry Potter")

while True:
    resposta5 = input("\nEscreva a resposta-->").upper()
    if resposta5 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta5 =="A":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nQuanto tempo a luz do Sol demora para chegar à Terra?")
print("Respostas: A-5 Segundos,   B-12 Horas,   C-1 Dia,   D-8 Minutos")

while True:
    resposta6 = input("\nEscreva a resposta-->").upper()
    if resposta6 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta6 =="D":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")


print("\n\n<--Perguntas sobre Ciências-->")



print("\n\nOs animais omnívoros são aqueles que se alimentam de..")
print("Respostas: A-Apenas de Carnes,   B-Tanto de Animais como Vegetais,   C-Apenas de Ovos,   D-Apenas de Vegetais")

while True:
    resposta7 = input("\nEscreva a resposta-->").upper()
    if resposta7 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta7 =="B":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nqual deles é um osso do corpo humano")
print("Respostas: A-Bíceps,   B-Sóleo,   C-Escápula,   D-Coxa")

while True:
    resposta8 = input("\nEscreva a resposta-->").upper()
    if resposta8 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta8 =="C":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nO osso mais longo e mais volumoso do corpo humano é o..")
print("Respostas: A-Fêmur,   B-Metacarpo,   C-Bigorna,   D-Martelo")

while True:
    resposta9 = input("\nEscreva a resposta-->").upper()
    if resposta9 in ['A','B','C','D']:
        break
    else:
        print("Escreva uma opção válida")
if resposta9 =="A":
    print("\nResposta Correta!!")
    certas+=1
else:
    print("\nResposta Errada!!")

print("\n\nJogo Finalizado!!")

certas= str(certas)

print("Nº de Respostas Corretas--> "+certas)