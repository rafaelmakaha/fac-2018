	.data
espaco: .ascii " "
str:
	.text
	
main:	
	li $v0, 8	#configuração para ler uma string
	la $a0, str	#passa o endereço de str para salvar a string
	li $a1, 80	#passa o valor máximo de chars para a string
	syscall

	la $s1, str	#passagem do endereço de str para $s1
	lw $t1, espaco	#passagem do valor de espaco para o registrador $t1
	
	j checa
checa:
	lb $t0, 0($s1)			#passagem do valor da posição atual para $t0
	beq $t0, $zero, fim		#verifica se é o final da string
	beq $t0, ' ', incrementa	#verifica se a posição atual é um espaço
	addi $s1, $s1, 1		#incrementa a posição
	j checa
	
	incrementa:
		addi $s2, $s2, 1	#incrementa o contador
		addi $s1, $s1, 1	#incrementa a posição
		j checa
	
fim:
	li $v0, 1	
	move $a0, $s2	#imprime o contador
	syscall