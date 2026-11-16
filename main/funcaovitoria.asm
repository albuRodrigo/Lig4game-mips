#função vitório
.data
.text
#argumentos int vitoria (int ** matriz($a0))
verifvitoria:
	addu $sp, $sp, -36 #----reservando na pilha 16 bytes ou 4 words

	sw $ra 4($sp) #---------Aqui serão utilizados $s0, $s1, $s2 e $ra para poder retornar ao main
	sw $t0 8($sp)
	sw $t1 12($sp)
	sw $t2 16($sp)
	sw $t3 20($sp)
	sw $t4 24($sp)
	sw $t5 28($sp)
	sw $t6 32($sp)
	sw $t7 36($sp)
	
	
#-----COMPARAR LINHAS-----#
	compararlinhas:
		move $t6, $a0 #------ $t6 será a linha atual a ser verificada
		move $t0, $a0 #------ $t0 será um ponteiro que auxilia na verificação de 4 em 4 da linha atual
		li $t4, 0 #------ equivalente ao i em c
		li $t5, 0 #------ equivalente ao j em c
			looplinha:
				lw $t1, 0($t0) #--carrego 4 espaços consecutivos
				lw $t2, 4($t0)
				lw $t3, 8($t0)
				lw $t7, 12($t0)
				
				bne $t1, $t2, difflinhas #--comparo os 4 espaços se são iguais
				bne $t2, $t3, difflinhas
				bne $t3, $t7, difflinhas
				beqz $t7, difflinhas
				j igualdade
				
				difflinhas:
				beq $t4, 4, fimcomplinhaatual
				addi $t4, $t4, 1
				addi $t0, $t0, 4
				j looplinha
				
				fimcomplinhaatual:
				beq $t5, 7, fimcomplinhas
				addi $t5, $t5, 1
				addi $t6, $t6, 32
				move $t0, $t6
				li $t4, 0
				j looplinha
				
			fimcomplinhas:
	
		li $v0, 0
		j fimfuncaovitoria
			
			
	igualdade:
		move $v0, $t1 #------------- a função retorna a paridade do jogador vencedor
		j fimfuncaovitoria

	fimfuncaovitoria:
		lw $ra 4($sp) #----------------- Liberando a pilha
		lw $t0 8($sp)
		lw $t1 12($sp)
		lw $t2 16($sp)
		lw $t3 20($sp)
		lw $t4 24($sp)
		lw $t5 28($sp)
		lw $t6 32($sp)
		lw $t7 36($sp)
		addu $sp, $sp, 36
		jr $ra
  





