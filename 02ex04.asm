	.data
	
	.text
	
	lui $1, 0x5555
	or $1, 0x5555
	
	sll $2, $1, 1
	
	or $3, $1, $2
	and $4, $1, $2
	xor $5, $1, $2
	