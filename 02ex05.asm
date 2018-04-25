	.data	
	.text
	
	li $1, 0xFACE	
	li $t0, 0xF000
	li $t1, 0x00F0
	li $t2, 0x0F0F
	
	and $2, $1, $t2		#captura as vogais
	
	and $3, $1, $t0		#captura o F
	srl $3, $3, 8
	
	and $4, $1, $t1		#captura o C
	sll $4, $4, 8
	
	or $3, $3, $4		#une todos
	or $2, $2, $3