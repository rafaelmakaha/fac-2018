	.data

	.text
	
	ori $1, $0, 0x01 	#seta $1
	
	li $2, 0x0020

	li $3, 0x0300

	li $4, 0x4000

	li $5, 0x5000
	sll $5, $5, 4

	li $6, 0x6000
	sll $6, $6, 8

	li $7, 0x7000
	sll $7, $7, 12