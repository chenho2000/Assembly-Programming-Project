
.data
	displayAddress:	.word	0x10008000
.text
init:
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 16 		# x index for doodle
	li $t2, 32 		# y index for doodle
	li $t3, 15		# x index for platform 1
	li $t4, 32		# y index for platform 1
	li $t5, 10		# x index for platform 2
	li $t6, 17		# y index for platform 2
	li $t7, 20		# x index for platform 3
	li $t8, 2		# y index for platform 3
	li $s0, 0xcb0c59	# doodle color
	li $s1, 0x0c4383	# background color
	li $s2, 0x00ff9f	# platform color
	li $s3, -1		#curr rising/falling
	li $s5, -10		# position of next platform
	
	
main:
	jal action
	jal addElements
	jal addDoodle
	jal currHeight
	jal onPlatform
	jal sleep
	j main

conitnue:
	jr $ra	
	
action:
	lw $s6, 0xffff0000
	beq $s6, 0, conitnue
	move $s7, $ra
	lw $s6, 0xffff0004
	beq $s6, 0x6A, goLeft
	beq $s6, 0x6B, goRight
	move $ra, $s7
	jr $ra
	
goLeft:
	addi $t1, $t1, -1
	move $ra, $s7
	jr $ra
	
goRight:
	addi $t1, $t1, 1
	move $ra, $s7
	jr $ra

resetDA:
	lw $t0, displayAddress
	jr $ra
	
addBackground:
	sw $s1, 0($t0)		
	addi $t0, $t0, 4
	bgt $t0, 0x10008ffc, resetDA	# = 4092
	j addBackground

resetPos:
	li $t2, 32
	
addOnePlatform:
	move $t9, $k1
	lw $t0, displayAddress
	sll $k0, $a2, 2		
	sll $k1, $k1, 7
	add $t0, $t0, $k0
	add $t0, $t0, $k1
	addi $t0, $t0, -4
	sw $s2, 0($t0)
	addi $s6, $s6, 1	
	addi $a2, $a2, 1	
	move $k1, $t9
	bne $s6, $s7, addOnePlatform	
	jr $ra
		
addElements:
	blt $t2, $zero, resetPos
	move $v1, $ra
	move $a2, $t3	
	jal addBackground	
	li $s6, 0
	li $s7, 5 # the length of the platform
	li $a3, 4
	lw $t0, displayAddress
	addi $k1, $t4, -1
	jal addOnePlatform		
	move $a2, $t5		
	li $s6, 0
	li $s7, 5 # the length of the platform
	li $a3, 4
	addi $k1, $t6, -1
	lw $t0, displayAddress
	jal addOnePlatform
	move $a2, $t7		
	li $s6, 0
	li $s7, 5 # the length of the platform
	li $a3, 4
	lw $t0, displayAddress
	addi $k1, $t8, -1
	jal addOnePlatform	
	lw $t0, displayAddress
	move $ra, $v1
	jr $ra
	

addDoodle:
	lw $t0, displayAddress
	sll $k0, $t1, 2		
	addi $k1, $t2, -1
	sll $k1, $k1, 7
	add $t0, $t0, $k0
	add $t0, $t0, $k1
	addi $t0, $t0, -4
	sw $s0, 0($t0)
	addi $t0, $t0, -136
	sw $s0, 0($t0)
	addi $t0, $t0, 4
	sw $s0, 0($t0)	
	addi $t0, $t0, 8
	sw $s0, 0($t0)	
	addi $t0, $t0, 4
	sw $s0, 0($t0)
	addi $t0, $t0, -136
	sw $s0, 0($t0)
	lw $t0, displayAddress
	add $t2, $t2, $s3
	jr $ra	
	

onPlatform:
	move $v0, $t3
	move $v1, $ra
	lw $t0, displayAddress
	sll $k0, $t1, 2		
	addi $k1, $t2, -1
	sll $k1, $k1, 7
	add $t0, $t0, $k0
	add $t0, $t0, $k1
	addi $t0, $t0, -4
	lw $t3, 0($t0)
	lw $t0, displayAddress
	beq $t3, $s2, on
	move $t3,$v0
	move $ra, $v1
	lw $t0, displayAddress
	jr $ra
	
on:
	lw $t0, displayAddress
	jal addDoodle
	li $s3, -1
	li $s4, 0	
	move $t3,$v0
	move $ra, $v1
	lw $t0, displayAddress
	##########################################animation start here #####################################
	bgt $t6,$t2, movement
	jr $ra


movement:
	li $v0, 1
	move $a0, $t6
	syscall
	move $t3, $t5
	move $t4, $t6
	move $t5, $t7
	move $t6, $t8
	add $t7,$t7, $s5
	sub $s5, $zero, $s5
	j movePlat

movePlat:

	li $t2, 32
	addi $t4,$t4,1	
	addi $t6,$t6,1
	jal addElements
	jal sleep
	bne $t4, $t2, movePlat
	j main
					
																
currHeight:
	beq $s4, 18, fall
	beq $s3, -1, addCurr
	bgt $t2, 32,exit	
	jr $ra
	
addCurr:
	addi $s4, $s4, 1	
	jr $ra

fall:
	li $s3, 1
	addi $s4, $s4, -1		
	jr $ra
	

sleep:
	li $v0, 32
	li $a0, 60		# sleep
 	syscall
 	jr $ra
	
exit:	
	li $v0, 10 
	syscall
