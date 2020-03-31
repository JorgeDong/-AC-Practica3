.data 
.text

addi $t3,$zero,4

beq $t3,$t3,prueba #saltar a prueba
addi $t2,$t2,5 #si beq funciona, esta instrucción no se hace
prueba:
addi $t2,$zero,5 #si el beq funciona $t2 debe de ser 5
