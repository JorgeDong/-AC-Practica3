.data 
.text

addi $t3,$zero,4

j prueba #saltar a prueba
addi $t2,$t2,5 #si j funciona, esta instrucción no se hace

prueba:
addi $t2,$zero,5 #si el j funciona $t2 debe de ser 5

