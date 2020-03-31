.data 
.text

addi $t3,$zero,4
addi $t4,$zero,5

bne $t3,$t4,prueba #saltar a prueba
addi $t2,$t2,5 #si bne funciona, esta instrucción no se hace
prueba:
addi $t2,$zero,5 #si el bne funciona $t2 debe de ser 5

