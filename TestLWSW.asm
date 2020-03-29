.data
.word 
.text

main:
addi $s0,$zero,8	#number of disks N

addi $t8,$zero,1 	#Set register to 1 for future beq

addi $t0,$zero,0x1001	#base for all pointers
sll  $t0,$t0, 16	#shift left logical

addi $t1,$t0,0x0020 	#pointer to  tower B

addi $t2,$t0,0x0040	#pointer to  tower C


add $s1,$zero,$s0 	#counter i

sw $s1,0($t0)		#store disk in tower A

lw $t3,0($t0)   	#get disk from origin tower

sw $t3,4($t0)		#store disk in tower A

addi $t3,$t3,4
