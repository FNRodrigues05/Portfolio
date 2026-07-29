
palavra = "evora"

print("JOGO DA FORCA \n")

chances = 6
alfabeto = list("abdcefghijklmnopqrstuvwxyz")
tentativas = []

while True:
	print("\n\n")
	print(tentativas)
	print("Chances: ",chances)

	for letra in palavra:
		if letra in tentativas:
			print(letra, end = ' ')
		else:
			print('_', end= ' ')

	palpite = input("\nDigite uma letra ou 'SAIR' para sair do programa!").lower()
	if palpite == "sair":
		break	
	elif palpite not in alfabeto or palpite == '':
		print("Isso não é uma letra!")
		continue	
	elif palpite in tentativas:
		print("Já tentou essa letra. Tente outra!")
		continue
	tentativas.append(palpite)
	if palpite in palavra:
		print("Acertou")
	else:
		print("Errou")
		chances -= 1
	if chances == 0:
		print("Perdeu, Game over!!! >:)")
		break
	elif set(palavra).issubset(set(tentativas)):
		print("Parabéns, acertou!")
		break