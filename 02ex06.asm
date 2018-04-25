	.data	
	.text
	
	lui $1, 0x1234
	or $1, $1, 0x5678
	
	lui $t0, 0xF000		#mascaras para capturas individuais
	lui $t1, 0x0F00
	lui $t2, 0x00F0
	lui $t3, 0x000F
	li $t4, 0xF000
	li $t5, 0x0F00
	li $t6, 0x00F0
	li $t7, 0x000F
	
	and $t0, $1, $t0
	and $t1, $1, $t1
	and $t2, $1, $t2
	and $t3, $1, $t3
	and $t4, $1, $t4
	and $t5, $1, $t5
	and $t6, $1, $t6
	and $t7, $1, $t7
	
	srl $t0, $t0, 28
	srl $t1, $t1, 20
	srl $t2, $t2, 12
	srl $t3, $t3, 4
	sll $t4, $t4, 4
	sll $t5, $t5, 12
	sll $t6, $t6, 20
	sll $t7, $t7, 28
	
	or $2, $2, $t0
	or $2, $2, $t1
	or $2, $2, $t2
	or $2, $2, $t3
	or $2, $2, $t4
	or $2, $2, $t5
	or $2, $2, $t6
	or $2, $2, $t7
	
	