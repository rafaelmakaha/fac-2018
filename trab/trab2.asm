	.data
	.word
valor1:		.asciiz "Insira um valor para a base: "
valor2: 	.asciiz "Insira um valor para o expoente: "
valor3: 	.asciiz "Insira um valora supostamente primo: "
naoPrimo:	.asciiz "O valor inserido não é primo."
sucesso1:	.asciiz "A exponencial modular "
sucesso2:	.asciiz " elevado a "
sucesso3:	.asciiz " (mod "
sucesso4:	.asciiz ") eh "

	.text
	
le_inteiro:
	la $a0, valor1		# Imprime mensagem de inserção
	li $v0, 4
	syscall 
	
	li $v0, 5		#Leitura do primeiro inteiro
	syscall
	move $t0, $v0		# Salva o primeiro inteiro em $t0
	
	la $a0, valor2		# Imprime mensagem de inserção
	li $v0, 4
	syscall 
	
	li $v0, 5
	syscall			# Leitura do segundo inteiro
	move $t1, $v0		# Salva o segundo inteiro em $	t1

	la $a0, valor3		# Imprime mensagem de inserção
	li $v0, 4
	syscall 
	
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
	
fim_checagem:				# Fim da verificação de número primo
	li $t3, 0x02			
	bne $t5, $t3, imprime_erro		# verifica se possui apenas dois divisores
	j continua
	
imprime_erro:
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
	li $t3, 0x01 		# Máscara para varredura dos bits
	j msb

msb:				# encontrando o bit mais significativo
	beq $t3, $zero bit_maximo
	sgt $t4, $t3, $t1	# if ( bit_atual > expoente )
	beq $t4, 1, continua_2	
	sll $t3, $t3, 1		# Avança um bit com a máscara
	j msb

bit_maximo:
	li $t3, 10000000000000000000000000000000
	move $t4, $t0
	srl $t3, $t3, 1
	j exponenciacao

continua_2:
	srl $t3, $t3, 1 	# Posiciona corretamente a máscara com o bit mais significativo
	move $t4, $t0		# Iniciando $t4 para armazenar as multiplicações
	srl $t3, $t3, 1		# shift devido a primeira iteração da exponenciação
	j exponenciacao
	
exponenciacao:
	beq $t3, $zero, imprime_saida		# verifica se ainda há bits a serem utilizados
	and $t5, $t3, $t1		# fazer o and para verificar o bit atual
	bne $t5, $zero, sqr_mult	# If ( $t5 != 0 ) ; square and multiply
	mult $t4, $t4			# Else: square
	mflo $t4
	div $t4, $t2			# divisão do resto atual pelo número primo
	mfhi $t4			# captura o resto da divisão em $t4
	srl $t3, $t3, 1
	j exponenciacao

sqr_mult:
	mult $t4, $t4			# $t4 ** 2
	mflo $t4
	mult $t4, $t0			# $t4 * base
	mflo $t4
	div $t4, $t2			# divisão do resto atual pelo número primo
	mfhi $t4			# captura o resto da divisão em $t4
	srl $t3, $t3, 1			# shift para o próximo bit do expoente
	j exponenciacao

imprime_saida:
	la $a0, sucesso1		# mensagem de sucesso
	li $v0, 4
	syscall 
	
	move $a0, $t0			# impriminto inteiro
	li $v0, 1
	syscall
	
	la $a0, sucesso2		# mensagem de sucesso
	li $v0, 4
	syscall 
	
	move $a0, $t1			# impriminto inteiro
	li $v0, 1
	syscall
	
	la $a0, sucesso3		# mensagem de sucesso
	li $v0, 4
	syscall 
	
	move $a0, $t2			# impriminto inteiro
	li $v0, 1
	syscall
	
	la $a0, sucesso4		# mensagem de sucesso
	li $v0, 4
	syscall 
	
	move $a0, $t4			# impriminto inteiro
	li $v0, 1
	syscall

	li $v0, 10
	syscall
