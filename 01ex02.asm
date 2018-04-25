	.data
	
	.text
main:	
	li $v0, 5	#opção para leitura de valor
	syscall		#chamado do syscall para ler valores do terminal
	
	la $a0, ($v0)	#passagem do endereço da variavel lida para #a0
	li $v0, 1	#opção de impressão de inteiro para o syscall
	syscall		#chamada do syscall
	
	li $v0, 10	#opção de finalização de programa
	syscall		#execução do syscall