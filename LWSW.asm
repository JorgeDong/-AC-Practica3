.data 
.text
addi $t0,$zero,0x1001	#base for all pointers
sll  $t0,$t0, 16	#shift left logical

addi $t3,$zero,4 
addi $t4,$zero,0 #asegurar que esta en 0 

sw $t3,0($t0) #guardar un 4 en memoria
lw $t4,0($t0) #tomar el dato en memoria y cargarlo en el registro



