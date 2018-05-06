	.data
	.word
naoPrimo:	.asciiz "O valor inserido não é primo."

	.text
	
	li $v0, 5		#Leitura do primeiro inteiro
	syscall
	move $t0, $v0		# Salva o primeiro inteiro em $t0
	
	li $v0, 5
	syscall			# Leitura do segundo inteiro
	move $t1, $v0		# Salva o segundo inteiro em $	t1

	li $v0, 5
	syscall			# Leitura do terceiro inteiro
	move $t2, $v0		# Passa o inteiro lido para o registrador $t2
	
	li $t3, 1		# $t3 == (cont)
	move $t6, $t2		# $t6 recebe as subtrações (total)
	li $t7, 1		# $t7 será o valor das subtrações (aux)
	jal sqrt
	
	sub $t3, $t3, 1		# remove-se a contagem extra
	move $t7, $t3		# $t7 = sqrt($t2)
	move $t3, $zero		# i = 0
	move $t6, $t2		# copia o conteúdo da terceira entrada para $t6
	add $t6, $t6, 1		# $t6 = $t2 + 1
	j checa_primo

checa_primo:
	beq $t3, $t7, fim_checagem  	# while $t3 < $t7
	div $t2, $t3			# $t2 / $t3
	mfhi $t4			# $t4 = %t2 % $t3
	beq $t4, $zero, incrementa	# if ( $t2 % $t3 == 0 ), faz o incremento da quantidade de divisores
	add $t3, $t3, 1			# i++
	j checa_primo
	
incrementa:
	add $t3, $t3, 1		# i++
	add $t5, $t5, 1		# divisores++
	j checa_primo
	
fim_checagem:
	li $t3, 0x02			
	bne $t5, $t3, nao_primo		#verifica se possui apenas dois divisores
	j continua
	
nao_primo:
	la $a0, naoPrimo		# imprime mensagem de que não é primo
	li $v0, 4
	syscall
	
	li $v0, 10			# finaliza o programa
	syscall
	
sqrt:					#encontrará a parte inteira da raiz quadrada
	slti $t4, $t6, 1		# ( aux < 1 )
	bne $t4, $zero, fim_sqrt		# if not( aux < 1 ), fim
	add $t7, $t7, 2			# aux += 2
	add $t3, $t3, 1			# cont++
	sub $t6, $t6, $t7		# total -= aux
	j sqrt
	
fim_sqrt:
	jr $ra
	
continua:
	li $t3, 0x01			# máscara para captura dos bits
	j captura

captura:
	beq $t3, $zero, fim		# verifica se já foram percorridos todos os bits do expoente
	and $t4, $t3, $t1		# captura do bit
	beq $t4, 1, contabiliza		# se o bit valer 1, faz a exponenciação
	sll $t3, $t3, 1			# shift da máscara
	j captura
	
contabiliza:
	li $t5, 0			# contador de multiplicações
	jal exponenciacao		# chama função de cálculo de exponenciação
	sll $t3, $t3, 1			# shift da máscara
	j captura
	
exponenciacao:
	beq $t5, $t4, retorno_exponenciacao 	# verifica se já terminou de fazer a exponenciação
	
	
retorno_exponenciacao:
	j $ra

fim:
	li $v0, 10
	syscall
