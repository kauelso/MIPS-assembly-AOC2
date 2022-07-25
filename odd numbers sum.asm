#3) Escreva um programa que leia 10 inteiros longos não sinalizados da entrada padrão e some apenas os números impares.
#O teste para números impares deve ser implementado em uma função separada do programa principal.
#Por fim, imprima a soma de todos os números impares.
#
# Kaue Lucas Silverio Oliveira - 11821BCC007

.data

str1: .asciiz "Digite um inteiro: "
str2: .asciiz "A soma dos impares eh: "
arr: .word 0,0,0,0,0,0,0,0,0,0

.text

init:
la	$a1, arr
add	$s1, $zero, $zero
add	$t1, $zero, $zero
addiu	$t2, $zero, 2

main:
li	$v0, 4
la	$a0, str1
syscall

li	$v0, 5
syscall
addu	$s0, $v0, $zero

sw	$s0, 0($a1)
addi	$a1, $a1, 4
addi	$s1, $s1, 1
blt	$s1, 10, main

soma:
addi	$a1, $a1, -4
lw	$s0, 0($a1)
divu	$s0, $t2
mfhi	$t0
addi	$s1, $s1, -1
beq	$t0, 0, par
addu	$s2, $s2, $s0
bne 	$s1, 0, soma

end:
li	$v0, 4
la	$a0, str2
syscall

li	$v0, 1
addu	$a0, $s2, $zero
syscall

li	$v0, 10
syscall

par:
beq 	$s1, 0, end
j	soma