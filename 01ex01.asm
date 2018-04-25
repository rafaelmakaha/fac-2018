	.data
str:	.asciiz "\nAlo Mundo!\n" #cria a string na variavel str

	.text
main:				#inicio da função main
	li $v0, 4		#seleciona a opção de print para a syscall
	la $a0, str		#salva o ponteiro da string a ser printada
	syscall			#chamada do syscall
	
	li $v0,10		#opção de finalizar o programa
	syscall			#chamada do syscall para finalizar o programa
	