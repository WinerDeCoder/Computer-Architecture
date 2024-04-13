.data
	table: .asciiz "321#############################654#############################987#################################################################################################################################"
	mess: .asciiz "Wellcome to the game Tic-Tac-Toe.\n"
	mess1: .asciiz "First player will be X, second one will be O. Each player takes turn to play.\n"
	mess2: .asciiz "X's turn. Input a number : "
	mess3: .asciiz "O's turn. Input a number : "
	new: .asciiz "\n"
	win: .asciiz "Win !!! Congratulation !.\n Reset the program if you want to play again.\n"
	draw: .asciiz "Draw !!! \n Reset the program if you want to play again.\n"
	printX: .asciiz " X "
	printO: .asciiz " O "
	s: .asciiz " | "
	t: .asciiz "\n"
	d: .asciiz "----------- \n "
	made: .asciiz "THIS GAME IS MADE BY: NGUYEN PHUOC NGUYEN PHUC - 2053342.\n"
.text
	li $v0,4
	la $a0,mess   # print mess
	syscall
	
	li $v0,4
	la $a0,made
	syscall
		
	li $v0,4
	la $a0,mess1
	syscall
	
	jal print   # print the table

j main
	Com1:
		beq $t4,$t8,winn	
		j next1
	Com2:
		beq $t4,$t7,winn
		j next2
	Com3:
		beq $t4,$t6,winn
		j next3
	Com4:
		beq $t4,$t5,winn
		j next4
	Com5:
		beq $t3,$t6,winn
		j next5
	Com6:
		beq $t5,$t8,winn
		j next6
	Com7:
		beq $t1,$t2,winn
		j next7
	Com8:
		beq $t7,$t8,winn
		j next8
	Fill:		# move to the square based on whar you input
		beq $v0,1,One	
		beq $v0,2,Two
		beq $v0,3,Three	
		beq $v0,4,Four
		beq $v0,5,Five
		beq $v0,6,Six
		beq $v0,7,Seven
		beq $v0,8,Eight
		beq $v0,9,Nine
		jr $ra
	One:
		li $a0,2	# load index of the string
		jr $ra		
	Two:
		li $a0,1
		jr $ra
	Three:
		li $a0,0
		jr $ra
	Four:
		li $a0,34
		jr $ra
	Five:
		li $a0,33
		jr $ra
	Six:
		li $a0,32
		jr $ra
	Seven:
		li $a0,66
		jr $ra
	Eight:
		li $a0,65
		jr $ra
	Nine:
		li $a0,64
		jr $ra
main:  #main 	
	li $s0,0
	
	X:  #  X turn
	li $v0,4
	la $a0,mess2  
	syscall
	
	li $v0,5
	syscall		# input the move
	
	jal Fill       
	
	li $t0,88  # fill x
	sb $t0,table($a0)
	addi $s0,$s0,1
	jal Check		# check if win or not
	jal print	# print the board
	j O
	
	O: #?i?n O
	li $v0,4
	la $a0,mess3
	syscall
	
	li $v0,5
	syscall
	jal Fill
	
	li $t0,79 		 #	 fill O
	sb $t0,table($a0)
	addi $s0,$s0,1
	jal Check
	jal print
	j X
		
	Check:  # check Win,Lose,Draw , Check each pair
		li $a0,2
		lb $v0,table($a0)	#1		# load each square to compare
		li $a0,1
		lb $t1,table($a0)	#2
		li $a0,0
		lb $t2,table($a0)	#3
		li $a0,34
		lb $t3,table($a0)	#4
		li $a0,33
		lb $t4,table($a0)	#5
		li $a0,32
		lb $t5,table($a0)	#6
		li $a0,66
		lb $t6,table($a0)	#7
		li $a0,65
		lb $t7,table($a0)	#8
		li $a0,64
		lb $t8,table($a0)	#9
		
		beq $t4,$v0,Com1	# if square 1 = 5 , move to compare further
		next1:	
		beq $t4,$t1,Com2	
		next2:
		beq $t4,$t2,Com3
		next3:	
		beq $t4,$t3,Com4	
		next4:
		beq $t3,$v0,Com5	
		next5:
		beq $t5,$t2,Com6
		next6:	
		beq $t1,$v0,Com7
		next7:	
		beq $t7,$t6,Com8	
		next8:
		beq $s0,9,draww
		jr $ra
	winn:	# if win, print
		beq $t0,88,PrintX
		jal print
		li $v0,4
		la $a0,printO
		syscall
		
		li $v0,4
		la $a0,win
		syscall
		
		li $v0,4
		la $a0,made
		syscall
		
		li $v0,10
		syscall
		PrintX:
			jal print
			li $v0,4
			la $a0,printX
			syscall
		
			li $v0,4
			la $a0,win
			syscall
			
			li $v0,4
			la $a0,made
			syscall
		
			li $v0,10
			syscall
			
	draww:	 # Draw case if after 9 turns and no winner
		jal print
		li $v0,4
		la $a0,draw
		syscall
		
		li $v0,4
		la $a0,made
		syscall
		
		li $v0,10
		syscall
		
	print:	# Print out the board
		li $v0,4
		la $a0,d
		syscall
		
		li $v0,11
		li $t0,2
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,s
		syscall
		
		li $v0,11
		li $t0,1
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,s
		syscall
		
		li $v0,11
		li $t0,0
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,t
		syscall
		
		li $v0,4
		la $a0,d
		syscall
		
		li $v0,11
		li $t0,34
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,s
		syscall
		
		li $v0,11
		li $t0,33
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,s
		syscall
		
		li $v0,11
		li $t0,32
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,t
		syscall
		
		li $v0,4
		la $a0,d
		syscall
		
		li $v0,11
		li $t0,66
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,s
		syscall
		
		li $v0,11
		li $t0,65
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,s
		syscall
		
		li $v0,11
		li $t0,64
		lb $a0,table($t0)
		syscall
		
		li $v0,4
		la $a0,t
		syscall
		
		li $v0,4
		la $a0,d
		syscall
		
		jr $ra
		
		
		
	
	
	
	
		
		
		
		
		
	
	
