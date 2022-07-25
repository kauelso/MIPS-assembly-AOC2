# Escreva um programa recursivo que calcule o valor do elemento N da série de Fibonacci.
# Kaue Lucas Silverio Oliveira - 11821BCC007

.data

str1: .asciiz "Digite o N :"
str2: .asciiz "O fibonacci de N eh: "
str3: .asciiz "N inválido"

.text

main:
add	$s0, $zero, $zero
add	$s1, $zero, $zero
addi	$s2, $zero, 1
li	$v0, 4 # Imprime str1
la	$a0, str1
syscall

li	$v0, 5 # Le o valor de N do usuario
syscall
add	$a0, $v0, $zero
ble 	$a0, -1, fibo_erro
ble 	$a0, 0, fibo_0
jal fibo1

li	$v0, 4 # Imprime str3
la	$a0, str2
syscall

li	$v0, 1 # Imprime fibo de n
la	$a0, ($s2)
syscall

li	$v0, 10
syscall

fibo1:	# Caso base
bgt	$a0, 1, loop1
sw	$a0, -4($sp)
sw	$t0, -12($sp)
addi	$sp, $sp, -12
jr	$ra

loop1:
sw	$ra, 0($sp)	# Desce na pilha ate o caso base
sw	$a0, -4($sp)
addi	$sp, $sp, -8
addi	$a0, $a0, -1
jal	fibo1
lw	$ra, 20($sp) # Le os valores na pilha, calcula o fibo, guarda o resultado e recupera o contexto
lw	$a0, 16($sp)
lw	$s0, 8($sp)
lw	$s1, 0($sp)
add	$s2, $s1, $s0
sw	$s2, 16($sp)
addi	$sp, $sp, 8
jr	$ra


fibo_erro:
li	$v0, 4 # Imprime str3
la	$a0, str3
syscall

li	$v0, 10
syscall

fibo_0:
li	$v0, 4 # Imprime str3
la	$a0, str2
syscall

li	$v0, 1 # Imprime fibo de n
la	$a0, 0
syscall

li	$v0, 10
syscall

