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
	move $s1, $t0
	move $s2, $t1
	move $s3, $t2	
	j exp

exp:
    li $s4, 1  #começando s4 com 1 registrador que vai comparar o numero 
    and $t3, $s4, $s2   #comparando bit a bit se s4  vai ser 0
    li $s6, 1  #começando s6 com 1 registrdor que ira multipicar todos os restos
    li $t2, 2 #carregando 2 em t2
    div $s1,$s3   #divide o expoente pelo modulo pela primeira vez
    mfhi $s5    #guarda o resto em S5
    mult $s5, $s6	# multiplicando o resto com o anterior
    mflo $s6
    bne $s2, $zero, calc_exp #caso o expoente for  diferente zero ele vai para calc_exp
    
calc_exp:
    slt $t1, $s4, $s2  #se o numero na posição do expoente for menor que o expoente recebe 1
    beq $t1, $zero, fim  # se o expoente na posição for maior que o dado vai pra continue
    mult $t2, $s4	#multiplicando para voltar a contagem
    mflo $s4		#salvando o resutado em S4
    mult $s5, $s5
    mflo $s5
    div $s5,$s3		#dividindo os restos anteriormente pelo modulo
    mfhi $s5		#colocando o resto em S5
    and $t3, $s4, $s2   #comparando bit a bit se s4  vai ser 0
    beq $t3, $zero, calc_exp
    mult $s5, $s6	# multiplicando o resto com o anterior
    mflo $s6
    j calc_exp    #voltar para o loop
    
fim:
	div $s6, $s3
	mfhi $s6

	li $v0, 10
	syscall
