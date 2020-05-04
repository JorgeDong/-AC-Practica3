.text
	addi $s0,$zero,9	#number of disks N
	addi $s2,$zero,1	#number of disks N
	addi $t0,$zero,0x1001	#base for all pointers
	sll  $t0,$t0, 16	#shift left logical
	add $t1,$zero,$zero
	add $s1,$zero,$s0 	#counter i
	add $t7,$zero,$t0	#pointer to first row
	add $v0,$zero,4
	add $v1,$zero,7	
	add $a1,$zero,3

	

	for:		  #"for" to store all disks in tower A
	#Numero Real
	sw $s1,0($t7)		#store disk in tower A
	sw $s2,4($t7)		#store disk in tower A
	
	#prueb
	add $t9,$zero,$s2
	
	sub $s2,$s2,$t9
	sub $s2,$s2,$t9
		
	
	sw $s1,4($sp)
	sw $s2,0($sp) 
	
	add $s2,$zero,$t9
	
	addi $s1,$s1,-1		# update counter i
	addi $s2,$s2,1		# update counter i
	addi $t7,$t7,8		#update last position of tower A
	addi $sp,$sp,-8
	  
	beq $s2,$v0,change
	beq $s2,$v1,change
	
	bne $s1,$zero,for
	j adjust	#if counter i!=0 continue with for	
	change:
	addi $t7,$t7,8
	j for
	adjust:
	addi $t7,$t7,-8	
	trans:
	addi $t1,$t1,1
	addi $sp,$sp,8
	lw $t5,0($sp)
	sw $t5,4($t7)
	lw $t5,4($sp)
	sw $t5,0($t7)

	addi $a1,$a1,-1
	beq $t1,$s0,exit
	beq  $a1,$zero,change2
	addi $t7,$t7,-32
	
	bne $a1,$zero,trans

	change2:
	addi $a1,$zero,3
	addi $t7,$t7,56
	j trans
		
exit:
