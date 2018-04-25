	.data
	
	.text
	
	ori $t0, $0, 0x01
	lui $t1, 0xFFFF
	li $t2, 0xFFFE
	or  $t3, $t1, $t2
	or $t0, $t0, $t3
	#########################
	ori   $1, $zero, 0x01
	move $t0, $1
loop:
	beq $t1, 32, fim
	sll $t0, $t0, 1
	or $1, $1, $t0
	addi $t1, $t1, 1
	j loop
	
fim:
	li $v0, 10
	syscall