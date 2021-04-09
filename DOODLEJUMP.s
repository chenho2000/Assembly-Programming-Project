
.data
	displayAddress:	.word	0x10008000                         # address for displaying stuff
	music: .byte 60,60,67,67,69,69,67,65,65,64,64,62,62,60,0   #Musial sequence of tones
	
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
	
	beq $s7, 0, play       #branching to play if s7 is zero
	addi $s7,$s7,1         # adding 1 to s7 to increment
	jal action             # going to action
	jal addElements        # going to add elements
	jal onPlatform         # going to onPlatform
	jal sleep              # going to sleep
	j main

	
play:
	li $s7,-10             # loading immediate to -10 in s7
	li $v0,31              # setting v0 to 31
	lb $a0,  0($v1)        #loading a byte to a0 from 0th byte at v1
	beqz $a0,replay        # branching to replay if a0 is zero
	li $a1, 10000          # loading immediate of 10000 to a1
	li $a3,100             # loading immediate of 100 to a3
	addi $v1,$v1,1         # adding 1 to v1, increment
	syscall                #syscalling 31 to play sound
	j main	               #jumping to main
replay:
	la $v1, music          #loading address to v1 from music
	j main                 #jumping to main

conitnue:
	jr $ra	               #jumping to register RA
	
action:
	lw $s6, 0xffff0000     # loading a word to s6
	beq $s6, 0, conitnue   # branch to conitnue if s6 is 0
	add $sp, $sp, -4       # adding -4 to sp
	sw $ra, 0($sp)         # storing ra in 0th of sp
	lw $s6, 0xffff0004     
	beq $s6, 0x6A, goLeft
	beq $s6, 0x6B, goRight
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
	
goLeft:
	addi $t1, $t1, -1
	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra
	
goRight:
	addi $t1, $t1, 1
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
	li $t9,0xfcb708         #storing color in t9
	li $v0, 41              # putting 41 on v0 for syscall
	li $a0, 0               # setting a0 to 0 (why?)
	syscall              
	bgez $a0, cloudMove     # branching to cloudMove if greater/eq to zero 
	lw $t0, displayAddress  # loading displayaddress to t0
	addi $t0,$t0,116        # 
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

dumbWow:
        li $a2,0xe7de0c
	li $v0, 41       
	li $a0, 0          
	syscall 
	
	lw $t0, displayAddress
	sw $a2, 648($t0)
	sw $a2, 776($t0)
	sw $a2, 904($t0)
	sw $a2, 1032($t0)
	sw $a2, 1036($t0)
	sw $a2, 1040($t0)
	sw $a2, 912($t0)
	sw $a2, 784($t0)
	sw $a2, 1044($t0)
	sw $a2, 1048($t0)
	sw $a2, 920($t0)
	sw $a2, 792($t0)
	sw $a2, 664($t0)
	sw $a2, 928($t0)
	sw $a2, 1060($t0)
	sw $a2, 1064($t0)
	sw $a2, 800($t0)
	sw $a2, 676($t0)
	sw $a2, 680($t0)
	sw $a2, 812($t0)
	sw $a2, 940($t0)
	sw $a2, 1080($t0)
	sw $a2, 948($t0)
	sw $a2, 820($t0)
	sw $a2, 692($t0)
	sw $a2, 1084($t0)
	sw $a2, 1088($t0)
	sw $a2, 956($t0)
	sw $a2, 828($t0)
	sw $a2, 964($t0)
	sw $a2, 836($t0)
	sw $a2, 708($t0)
	jr $ra
	
dumbNice:
       li $a2,0xe7de0c
	li $v0, 41       
	li $a0, 0          
	syscall 
	
	lw $t0, displayAddress
	sw $a2, 1032($t0)
	sw $a2, 904($t0)	
	sw $a2, 776($t0)
	sw $a2, 648($t0)
	sw $a2, 780($t0)
	sw $a2, 912($t0)
	sw $a2, 1044($t0)
	sw $a2, 916($t0)
	sw $a2, 788($t0)
	sw $a2, 660($t0)
	
	sw $a2, 1052($t0)
	sw $a2, 924($t0)
	sw $a2, 668($t0)
	
	sw $a2, 932($t0)
	sw $a2, 804($t0)
	sw $a2, 680($t0)
	sw $a2, 684($t0)
	sw $a2, 1064($t0)
	sw $a2, 1068($t0)
	
	sw $a2, 948($t0)
	sw $a2, 820($t0)
	sw $a2, 696($t0)
	sw $a2, 700($t0)
	sw $a2, 824($t0)
	sw $a2, 828($t0)
	sw $a2, 1080($t0)
	sw $a2, 1084($t0)
	jr $ra
	
dumbCool:
        li $a2,0xe7de0c
	li $v0, 41       
	li $a0, 0          
	syscall 
	
	lw $t0, displayAddress
	sw $a2, 904($t0)	
	sw $a2, 776($t0)
	sw $a2, 652($t0)
	sw $a2, 656($t0)
	sw $a2, 1036($t0)
	sw $a2, 1040($t0)
	sw $a2, 1052($t0)
	sw $a2, 1056($t0)
	sw $a2, 932($t0)
	sw $a2, 804($t0)
	sw $a2, 672($t0)
	sw $a2, 668($t0)
	sw $a2, 792($t0)
	sw $a2, 920($t0)

	sw $a2, 1072($t0)
	sw $a2, 1076($t0)
	sw $a2, 952($t0)
	sw $a2, 824($t0)
	sw $a2, 692($t0)
	sw $a2, 688($t0)
	sw $a2, 812($t0)
	sw $a2, 940($t0)

	sw $a2, 1088($t0)
	sw $a2, 960($t0)
	sw $a2, 832($t0)
	sw $a2, 704($t0)
	sw $a2, 1092($t0)
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
	li $s3, -1
	li $s4, 0	
	lw $ra, 0($sp)
	lw $t3,4($sp)
	addi $sp,$sp,8
	lw $t0, displayAddress
	##########################################animation start here #####################################
	bgt $t6,$t2, movement
	j dumbCool
	jr $ra
	
movement:
	li $v0, 1
	move $a0, $t6
	syscall
	move $t3, $t5
	move $t4, $t6
	move $t5, $t7
	move $t6, $t8
	li $t8, -13
	add $t7,$t7, $s5
	sub $s5, $zero, $s5
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
	bgt $t2, 32, exit	
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
