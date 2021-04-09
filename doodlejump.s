
.data
	displayAddress:	.word	0x10008000
	music: .byte 60,60,67,67,69,69,67,65,65,64,64,62,62,60,0
.text
init:
	# Free registers (Need double check):
	# v1, a1, a2, a3,s7
	# Other resigters not in below is free to use, but need to be careful to not conflict with mine
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
	li $s4, 0        	# init height   
	li $s5, -10		# position of next platform
	la $v1, music
	li $s7 ,-10
	
	
main:	
	
	beq $s7, 0, play
	addi $s7,$s7,1
	jal action
	jal addElements
	jal onPlatform
	jal sleep
	j main

	
play:
	li $s7,-10
	li $v0,31
	lb $a0,  0($v1)
	beqz $a0,replay
	li $a1, 10000
	li $a3,100
	addi $v1,$v1,1
	syscall
	j main	
replay:
	la $v1, music
	j main

conitnue:
	jr $ra	
	
action:
	lw $s6, 0xffff0000
	beq $s6, 0, conitnue
	add $sp, $sp, -4
	sw $ra, 0($sp)
	lw $s6, 0xffff0004
	beq $s6, 0x6A, goLeft
	beq $s6, 0x6B, goRight
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
	
goLeft:
	addi $t1, $t1, -1
	beqz $t1, goOpRight
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra

goOpLeft:
	li $t1,1
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
	
goOpRight:
	li $t1,32
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
		
goRight:
	addi $t1, $t1, 1
	li $t9, 33
	beq $t9,$t1,goOpLeft
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra

resetDA:
	lw $t0, displayAddress
	jr $ra
	
addBackground:
	sw $s1, 0($t0)		
	addi $t0, $t0, 4
	bgt $t0, 0x10008ffc, resetDA	# = 4092
	j addBackground


addDumbCloud:
	li $t9,0xfcb708
	li $v0, 41       
	li $a0, 0          
	syscall 
	bgez $a0, cloudMove
	lw $t0, displayAddress
	addi $t0,$t0,116
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	addi $t0,$t0,128
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	addi $t0,$t0,128
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	lw $t0, displayAddress
	li $t9,0xffffff
	addi $t0,$t0,1052
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0, $t0, 124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	sw $t9, 16($t0)
	sw $t9, 20($t0)
	addi $t0, $t0, 132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	lw $t0, displayAddress  
	addi $t0,$t0,1104
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0, $t0, 124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	sw $t9, 16($t0)
	sw $t9, 20($t0)
	addi $t0, $t0, 132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	lw $t0, displayAddress
	addi $t0,$t0,2840
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0, $t0, 124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	sw $t9, 16($t0)
	sw $t9, 20($t0)
	addi $t0, $t0, 132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	lw $t0, displayAddress
	jr $ra

cloudMove:
	lw $t0, displayAddress
	addi $t0,$t0,112
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0,$t0,132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	addi $t0,$t0,124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0,$t0,132	
	sw $t9, 0($t0)
	sw $t9, 8($t0)
	lw $t0, displayAddress
	li $t9,0xffffff
	addi $t0,$t0,1044
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0, $t0, 124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	sw $t9, 16($t0)
	sw $t9, 20($t0)
	addi $t0, $t0, 132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	lw $t0, displayAddress
	addi $t0,$t0,1112
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0, $t0, 124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	sw $t9, 16($t0)
	sw $t9, 20($t0)
	addi $t0, $t0, 132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	lw $t0, displayAddress
	addi $t0,$t0,2832
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	addi $t0, $t0, 124
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	sw $t9, 16($t0)
	sw $t9, 20($t0)
	addi $t0, $t0, 132
	sw $t9, 0($t0)		
	sw $t9, 4($t0)
	sw $t9, 8($t0)
	sw $t9, 12($t0)
	lw $t0, displayAddress
	jr $ra
	
resetPos:
	li $t2, 32
	
addOnePlatform:
	move $t9, $k1
	lw $t0, displayAddress
	sll $k0, $a0, 2		
	sll $k1, $k1, 7
	add $t0, $t0, $k0
	add $t0, $t0, $k1
	addi $t0, $t0, -4
	sw $s2, 0($t0)
	addi $s6, $s6, -1	
	addi $a0, $a0, 1	
	move $k1, $t9
	bnez $s6, addOnePlatform	
	jr $ra
		
addElements:
	blt $t2, $zero, resetPos
	addi $sp, $sp, -4
	sw $ra, 0($sp)	
	jal addBackground	
	jal addDumbCloud
	move $a0, $t3	
	li $s6, 10 # the length of the platform
	lw $t0, displayAddress
	addi $k1, $t4, -1
	jal addOnePlatform		
	move $a0, $t5		
	li $s6, 0
	li $s6, 10 # the length of the platform
	addi $k1, $t6, -1
	lw $t0, displayAddress
	jal addOnePlatform
	move $a0, $t7		
	li $s6, 10 # the length of the platform
	lw $t0, displayAddress
	addi $k1, $t8, -1
	jal addOnePlatform	
	lw $t0, displayAddress
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	j addDoodle
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
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $t3, 4($sp)
	jal currHeight
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
	lw $ra, 0($sp)
	lw $t3,4($sp)
	addi $sp,$sp,8
	lw $t0, displayAddress
	jr $ra
	
on:	
	lw $t0, displayAddress
	jal addDoodle
	bltz $s3, noJ
	li $s3, -1
	li $s4, 0	
	lw $ra, 0($sp)
	lw $t3,4($sp)
	addi $sp,$sp,8
	lw $t0, displayAddress
	##########################################animation start here #####################################
	bgt $t4,$t2, movement
	jr $ra
	
noJ:
	lw $ra, 0($sp)
	lw $t3,4($sp)
	addi $sp,$sp,8
	lw $t0, displayAddress
	jr $ra
	
movement:
	move $t3, $t5
	move $t4, $t6
	move $t5, $t7
	move $t6, $t8
	li $t8, -13
	add $t7,$t7, $s5
	bgez $s5, randomNext
	sub $s5, $zero, $s5
	j movePlat

randomNext:
	li $a1, 17
	li $v0, 42   #random
	syscall
	add $a0, $a0, -17
	move $s5,$a0
	j movePlat
	
movePlat:

	li $v0, 32
	addi $t4,$t4,1	
	addi $t6,$t6,1
	addi $t8,$t8,1
	move $t2, $t4
	jal addElements
	jal sleep
	bne $t4, $v0, movePlat
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
