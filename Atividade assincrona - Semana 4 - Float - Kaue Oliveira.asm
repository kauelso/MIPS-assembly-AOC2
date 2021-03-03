# Somar 10 valores e divide pelo numero informado

# Kaue Lucas Silverio Oliveira
# 11821BCC007
# Semana 4 - Atv Assincrona 1

.data

str1: .asciiz "Digite o valor: "
str2: .asciiz "Dividir por: "
str3: .asciiz "Media da soma: "

.text
main:

mtc1	$zero, $f2
cvt.s.w	$f2, $f2
mtc1	$zero, $f8
cvt.s.w	$f8, $f8
add	$s0, $zero, $zero

loop:
beq	$s0, 10, end
li	$v0,4
la	$a0, str1
syscall

li	$v0, 6
syscall

add.s	$f2, $f2, $f0
addi	$s0, $s0, 1
j	loop

end:
li	$v0, 4
la	$a0, str2
syscall

li	$v0, 6
syscall

cvt.s.w	$f4, $f4
div.s	$f6, $f2, $f0

li	$v0, 4
la	$a0, str3
syscall

li	$v0, 2
add.s	$f12, $f8, $f6
syscall