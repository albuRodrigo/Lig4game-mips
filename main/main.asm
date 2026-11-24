
# Lig-4-em-Assembly-Mips
.data
matriz: .word 0:64 #--crio uma matriz [8] [8] cheia de 0
jogada_invalida: .asciiz "\n Jogada inválida, escolha outro valor\n"
empatou: .asciiz "Toda as colunas foram prenchidas, EMPATE " 
jogador: .asciiz "\n Jogador, esecolha uma coluna!\n"

.text



la $a0, matriz #----Salvo endere?o da matriz

li $s0, 0x00FF0000 #--vermelho

li $s1, 0x00000000 #--preto

li $s2, 0xFFFFFFFF #--- branco

li $a1, 0x10010000#---endere?o tela mars

li $a3,0

main:

inicio_main:

la $t1,jogador
move $a0,$t1
li $v0,4
syscall

li $v0,5
syscall
move $a2,$v0
addi $a2,$a2,-1 # correção
bgt $a2,7,acabou


la $a0, matriz #----Salvo endere?o da matriz

jal funcão_local_disponivel





j inicio_main


#---pintar um quadrado-----

funcão_local_disponivel: #---procurar o 0(zero) mais baixo
#---- $a1 ----- tela mars
#---- $a2 ----- ? a coluna que o usuairo que colocar
#---- $a3 ----- ? par ou impar, pra ver quem ? o jogador
#---- $a0 ----- ? a matriz, pro calculo base
li $t1, 7 #--ultima linha



procura:
#-------------- achar endere?o
mul $t2, $t1,8
add $t2,$t2,$a2
mul $t2,$t2,4
add $t2,$t2, $a0
#--------------
lw $t3,0($t2) #----salvo em $t3 o valor correspondete ao espa?o 

beq $t3,$zero,prencher #---- se tiver vazio
addi $t1,$t1,-1 #---subo uma coluna
bltz  $t1,acabou  #---se a coluna ta toda cheia
j procura#--se n?o prencheu nem acabou eu continuo procurando

prencher:
#------------ calcular resto se par = jogador 1, se impar jogador 2
rem $t5,$a3,2 
#-------------

#-----------procurar endere?o correspondete ao do bitmap

#---------------

sub $t4,$t2,$a0 # salvo em $t4, a diiferen?a do valor base da matriz e do encontrado
add $t4,$t4,$a1 # $t4, tem a diferen?a mas o valor do bitmap


beq $t5,0,par
beq $t5,1,impar




par:
sw $s0,0 ($t4)#-----pinto no bit map
sw $s0,0 ($t2)#---pinto na matriz----OPICIONAL------
addi $a3,$a3,1 #---- se a jogada deu certo, somo, para na proxima vez ser outro jogador
jr $ra


impar:
sw $s2,0($t4)
sw $s2, 0($t2)
addi $a3,$a3,1 #---- se a jogada deu certo, somo, para na proxima vez ser outro jogador
jr $ra

acabou:
la $t5,jogada_invalida
move $a0,$t5
li $v0,4 #----imprime mensagem
syscall
j inicio_main


empate:#todas as 8 colunas acabaram
la $a0, matriz #pego o endereço da matriz
li $t7,0
while_empate:
lw $t5,0($a0)
beq $t5,$zero,continua
addi $a0,$a0,4
addi $t7,$t7,1
blt $t7,64,while_empate

la $a0,empatou

li $v0,4
syscall

j fim

fim:
li $v0,10
syscall

continua:
j inicio_main
