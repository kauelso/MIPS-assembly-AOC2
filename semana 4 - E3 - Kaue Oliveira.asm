# Semana 4 - Exercicio de programacao E3 - seno e cosseno
# Kaue Lucas Silverio Oliveira - 11821BCC007

.data
angulo: .asciiz "Insira o angulo: "
str1: .asciiz "O sen de "
str2: .asciiz "\nO coss de "
str3: .asciiz "\nA tan de "
str4: .asciiz " eh: "
n: .asciiz "\n"
pi: .float 3.14159265359
precisao: .word 10
.text
main:
mtc1	$zero, $f0 # Inicializa registrador 0
cvt.d.w	$f0, $f0

l.s	$f7,pi # Carrega pi

la	$s5, precisao # Numero de vezes que a funcao sera executada, define a precisao
lw	$s5, 0($s5)

li	$v0,4
la	$a0, angulo
syscall

li	$v0,5
syscall

# Converte grau em radiano
mtc1	$v0, $f8
cvt.s.w	$f8, $f8
mul.s	$f7, $f7, $f8
addi	$t1, $zero, 180
mtc1	$t1, $f8
cvt.s.w	$f8, $f8
div.s	$f7, $f7, $f8
jal	seno

li	$v0, 4
la	$a0, str1
syscall

li	$v0, 1
add	$a0, $zero, $a1
syscall

li	$v0, 4
la	$a0, str4
syscall

li	$v0, 2
add.s	$f12, $f0, $f6
syscall

jal	cos

li	$v0, 4
la	$a0, str2
syscall

li	$v0, 1
add	$a0, $zero, $a1
syscall

li	$v0, 4
la	$a0, str4
syscall

li	$v0, 2
add.s	$f12, $f0, $f9
syscall

# Tangente = sen/cos
li	$v0, 4
la	$a0, str3
syscall

li	$v0, 1
add	$a0, $zero, $a1
syscall

li	$v0, 4
la	$a0, str4
syscall

li	$v0, 2
div.s	$f12, $f6, $f9
syscall

li	$v0, 10
syscall

seno:
# sen(x) = somatorio de x a infinito de ((-1)^n/(2n+1)!)*x^(2n+1)
sw	$ra, 0($sp) #Salva o contexto na pilha

add	$s4, $zero, $zero # Inicializa contador
add.s	$f6, $f0, $f0

seno_loop:
# Calcula (-1)^n
addi	$s0, $zero, -1 # Calcula -1^n
mtc1	$s0, $f2
cvt.s.w	$f2, $f2
add	$s3, $zero, $s4
jal	potencia

add.s	$f1, $f0, $f4 # Guarda resultado da potencia em $f1

# Faz (2n + 1)!
mul	$t0, $s4, 2
addi	$t0, $t0, 1
add	$s0, $zero, $t0
jal 	fatorial
add.s	$f3, $f0, $f4 # Guarda resultado do fatorial em $f3

# Faz x^(2n+1)
add.s	$f2, $f0, $f7
add	$s3, $zero, $t0
jal 	potencia
add.s	$f5, $f0, $f4 # Guarda resultado da potencia em $f5

# Calcula o seno
div.s	$f1, $f1, $f3 
mul.s	$f1, $f1, $f5
add.s	$f6, $f1, $f6

# fim do loop
addi	$s4, $s4, 1

bne	$s4, $s5, seno_loop
lw	$ra, 0($sp) # Restaura o contexto na pilha
jr	$ra

cos:
# cos(x) = somatorio de x a infinito de ((-1)^n/(2n)!)*x^(2n)
sw	$ra, 0($sp) #Salva o contexto na pilha

add	$s4, $zero, $zero # Inicializa contador
add.s	$f9, $f0, $f0

cos_loop:
# Calcula (-1)^n
addi	$s0, $zero, -1 # Calcula -1^n
mtc1	$s0, $f2
cvt.s.w	$f2, $f2
add	$s3, $zero, $s4
jal	potencia

add.s	$f1, $f0, $f4 # Guarda resultado da potencia em $f1

# Faz (2n)!
mul	$t0, $s4, 2
add	$s0, $zero, $t0
jal 	fatorial
add.s	$f3, $f0, $f4 # Guarda resultado do fatorial em $f3

# Faz x^(2n)
add.s	$f2, $f0, $f7
add	$s3, $zero, $t0
jal 	potencia
add.s	$f5, $f0, $f4 # Guarda resultado da potencia em $f5

# Calcula o cos
div.s	$f1, $f1, $f3 
mul.s	$f1, $f1, $f5
add.s	$f9, $f1, $f9

# fim do loop
addi	$s4, $s4, 1

bne	$s4, $s5, cos_loop
lw	$ra, 0($sp) # Restaura o contexto na pilha
jr	$ra


fatorial:
addi	$s1, $zero, 1 # Coloca 1 no registrador da multiplicacao
mtc1	$s1, $f4
cvt.s.w	$f4, $f4

addi	$s2, $zero, 1 # Contador que vai de 1 a n

loop_fatorial:
mtc1	$s2, $f2
cvt.s.w	$f2, $f2

mul.s	$f4, $f4, $f2 # Multiplica o valor atual com os anteriores
addi	$s2, $s2, 1 # Incrementa o contador

bge	$s0, $s2, loop_fatorial
jr	$ra

potencia:
addi	$s1, $zero, 1 # Coloca 1 no registrador da multiplicacao
mtc1	$s1, $f4
cvt.s.w	$f4, $f4

add	$s2, $zero, $zero # Contador que vai de 0 a n

loop_potencia:
bge	$s2, $s3, loop_potencia_sai
mul.s	$f4, $f4, $f2 # Multiplica o valor atual com os anteriores
addi	$s2, $s2, 1 # Incrementa o contador
j	loop_potencia

loop_potencia_sai:
jr	$ra