

.data

.text
addi $t3,$t3,4


addi $t3,$t3,8
jal prueba
addi $t7,$t7,5
j exit


prueba:
addi $t2,$t2,10
add $t5,$zero,$ra

jr $ra

exit:

