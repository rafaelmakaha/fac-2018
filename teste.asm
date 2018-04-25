	.data
str:
	.text
	
	li $v0, 8
	la $a0, str
	li $a1, 80
	syscall
	
	la $s0, ($a0)
	
loop:
	lb $t1, 0($s0)
	beq $t1, $zero, fim
	beq $t1, ' ', incrementa
	add $s0, $s0, 1
	j loop
	
incrementa:
	add $t2, $t2, 1
	add $s0, $s0, 1
	j loop
	
fim:
	li $v0, 1
	la $a0, ($t2)
	syscall