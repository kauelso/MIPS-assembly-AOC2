#1) Escreva um programa que leia 10 números da entrada padrão e os salve em um array.
#A seguir o programa deve calcular a média dos números lidos e encaminhar uma mensagem com o resultado para a saída padrão.

# Kaue Lucas Silverio Oliveira
# 11821BCC007
# Semana 3 - Exercicios E2

.data
arr: .word 0,0,0,0,0,0,0,0,0,0
sz:  .word 9
str1: .asciiz "Digite um numero: \n"
str2: .asciiz "A media eh: "

.text
main:
la 	$s0, sz #carrega tamanho do array
lw 	$s0, 0($s0)

la	$s1, arr # coloca o endereco do array em s1

add	$s5, $zero, $zero
add	$t1, $zero, $s1
add	$s2, $zero, $zero #inicia contador para o indice do array
add	$s3, $zero, $zero

loop:
bgt	$s2, $s0, loop_soma 

li	$v0, 4
la	$a0, str1
syscall

li	$v0, 5
syscall

sll	$t0, $s2, 2
add	$t0, $t0, $s1

sw	$v0, 0($t0)

addi	$s2, $s2, 1
j	loop

loop_soma:
bgt	$s3, $s0, sai

lw 	$s4, 0($t1)
add	$s5, $s5, $s4
addi	$t1, $t1, 4
addi	$s3, $s3, 1
j	loop_soma

sai:
addi	$s0, $s0, 1
div	$s5, $s0

mflo	$s0

li	$v0, 4
la	$a0, str2
syscall
li	$v0, 1
add	$a0, $zero, $s0
syscall