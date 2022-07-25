# Semana 4 - Atividade Assincrona - 2
#
# Kaue Lucas Silverio Oliveira - 11821BCC007

.data

numIter:  .word 100000

str1: .asciiz	"\nA serie para "
str2: .asciiz	" iteracoes, retorna o valor: " 
str3: .asciiz	"\nCom erro de: "
pi: .float 3.14159265359

.text
		li	$s7, 0		#contador de iteracoes
		li	$t2, 100	#Numero de iteracoes onde o pi sera printado com a diferenca
		
		l.s	$f11, pi	# carrega valor de pi para fazer a diferenca
		#termo zero da série
		li	$s0, 0
		mtc1	$s0, $f0
		cvt.s.w	$f0, $f0
		#divisor da fracao
		li	$s1, 1
		mtc1	$s1, $f1
		cvt.s.w	$f1, $f1
		mov.s	$f7, $f1  #cte 1
		
		la	$s6, numIter	#carrega o num de iteracoes
		lw	$s6, 0($s6)
		
FOR:		beq	$s7, $s6, SAI1
		add	$t3, $zero, $s7	#Verifica se a iteracao eh multiplo de 100
		div	$t3, $t2
		mfhi	$t1
		beq	$t1, $zero, ITERACAO # Se for multiplo de 100 vai para a label ITERACAO
FOR2:
		
		#divisor da fracao
		mtc1	$s1, $f1
		cvt.s.w	$f1, $f1

		#computa a fracao
		div.s	$f3, $f7, $f1
		
		#testa se eh uma iteracao par ou impar
		#par -> termo positivo, impar -> termo negativo
		andi	$t0, $s7, 1 #se t0 for 1 eh impar, senao (0) eh par
		beq	$t0, $zero, PAR
		#impar
		sub.s	$f0, $f0, $f3
		j		SAIIF
PAR:	#par
		add.s	$f0, $f0, $f3
		
SAIIF:		addi	$s1, $s1, 2
		addi	$s7, $s7, 1
		j		FOR
SAI1:
		#primeira parte da resposta
		li		$v0, 4
		la		$a0, str1
		syscall
		#numero de iteracoes
		li	$v0, 1
		move	$a0, $s6
		syscall
		#segunda parte da resposta
		li		$v0, 4
		la		$a0, str2
		syscall
		#aprox. de pi
		
		li	$s5, 4
		mtc1	$s5, $f5
		cvt.s.w	$f5, $f5
		
		mul.s	$f0, $f0, $f5
		li	$v0, 2
		mov.s	$f12, $f0
		syscall

		# print str3
		li	$v0, 4
		la	$a0, str3
		syscall
		
		#print diferenca dos pi
		li	$v0, 2
		sub.s	$f12, $f11, $f9
		syscall
		 	
		#return 0
		li	$v0, 10
		syscall

ITERACAO:
		#primeira parte da resposta
		li	$v0, 4
		la	$a0, str1
		syscall
		#numero de iteracoes
		li	$v0, 1
		move	$a0, $s7
		syscall
		#segunda parte da resposta
		li	$v0, 4
		la	$a0, str2
		syscall
		#aprox. de pi
		
		li	$s5, 4
		mtc1	$s5, $f5
		cvt.s.w	$f5, $f5
		
		mul.s	$f9, $f0, $f5
		li	$v0, 2
		mov.s	$f12, $f9
		syscall
		
		#Terceira parte da resposta
		li	$v0, 4
		la	$a0, str3
		syscall
		
		# calculo erro
		li	$v0, 2
		sub.s	$f12, $f11, $f9
		syscall
		
		j FOR2