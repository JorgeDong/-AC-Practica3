#Authors: Jorge Alejandro Dong Llauger IS714046 and Kevin Antonio Moreno Melgoza IS714714
#Date: 19/02/20
#Description: Program in assembler MIPS to solve HANOI TOWERS  with N disks. 

.data
.word 
.text

main:
addi $s0,$zero,3	#number of disks N

addi $t8,$zero,1 	#Set register to 1 for future beq

addi $t0,$zero,0x1001	#base for all pointers
sll  $t0,$t0, 16	#shift left logical

addi $t1,$t0,0x0020 	#pointer to  tower B

addi $t2,$t0,0x0040	#pointer to  tower C


add $s1,$zero,$s0 	#counter i

for:		 	# "for" to store all disks in tower A
sw $s1,0($t0)		#store disk in tower A
addi $t0,$t0,4		#update last position of tower A
addi $s1,$s1,-1		# update counter i
bne $s1,$zero,for	#if counter i!=0 continue with for


exit:			#END PROGRAM
