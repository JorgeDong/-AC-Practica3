.data 
.text

addi $t3,$zero,4

jal prueba #saltar a prueba
addi $t2,$t2,5 #si jal funciona, esta instrucción se hace hasta que regresas de prueba con jr
j exit

prueba:
addi $t2,$zero,5 #si el jal funciona $t2 debe de ser 5
jr $ra

exit: # si el jr funciono, al final $t2 debería de ser 10