########### math2.asm ###########################
# Miguel Rodriguez                              #
# hello.asm                                     #
# Description                                   #
#     Solves a math problem for the user        #
# Program Logic                                 #
# 1.  Ask for A,B,C,D                           #
# 2.  Conmputes (A+B)-(C-D)                     #
# 3.  Displays the answer to the user           #
# 4.  display a new line                        #
# 5.  reapeats the program using a while loop   #
# 5.  return to operating system                #
#################################################

	.text
	.globl main
main:
        la $a0,welcome          #Welcomes the user
        li $v0,4
        syscall

        la $a0,math             #Prints the math problem to be solve
        li $v0,4
        syscall
        
	la $a0,prompt		#prompts the user to enter the values
	li $v0,4
	syscall
        

	li $v0,5	        #Take in the Input such that
	syscall				
		
	move $t0,$v0		#$t0 = A
	li $v0,5			
	syscall	
			
	move $t1,$v0            #$t1 = B
	li $v0,5
	syscall

	move $t2,$v0            #$t2 = C
	li $v0,5
	syscall

	move $t3,$v0            #$t3 = D

#############################################################
# Performs the calculations
#############################################################
	add $t4,$t0,$t1		#t0+t1 = t4
	sub $t5,$t2,$t3  	#t2-t3 = t5
	sub $t5,$t4,$t5		#t4-t5 = ANS

#############################################################
#############################################################

	la $a0,endl		#Prints the new line
	li $v0,4
	syscall

	la $a0,openp		#Prints openp
	li $v0,4
	syscall

 	move $a0,$t0		#Print A
	li $v0,1
	syscall

	la $a0,plus	        #Print plus
	li $v0,4
	syscall

	move $a0,$t1		#Print B
	li $v0,1
	syscall

	la $a0,closep		#Print closep
	li $v0,4
	syscall

	la $a0,minus		#Print minus
	li $v0,4
	syscall

	la $a0,openp		#Print openp
	li $v0,4
	syscall

	move $a0,$t2		#Print C
	li $v0,1
	syscall

	la $a0,minus		#Print minus
	li $v0,4
	syscall

	move $a0,$t3		#Print D
	li $v0,1
	syscall

	la $a0,closep		#Print closep
	li $v0,4
	syscall

	la $a0,equal		#Print equal
	li $v0,4
	syscall

	move $a0,$t5		#Print the answer
	li $v0,1
	syscall

	la $a0,endl	       #Print the new line
	li $v0,4
	syscall
###############################################################################
#             WHILE LOOP
#             CREATES REPETITION
###############################################################################      
        
#   	Ask the user if that user wishes to repeat this program:   1-yes, 0-no
	la $a0,p4
	li $v0,4
	syscall

#	Enter an integer (1 or 0)
	la $v0,5  # Load address of the message area
        syscall
        
#       Compare input to 1
        beqz $v0,eop


#       if it is 1 repeat
        j __start



eop:    li $v0,10   # End Of Program	
        syscall     # Call to system

#################################################################################
	.data
welcome: .asciiz "Welcome to Miguel's math problem!\n"
math:   .asciiz "Math Problem to be solve (A+B)-(C-D)\n"
prompt:	.asciiz	"Please enter A, B, C, D: \n"
endl:	.asciiz "\n"
openp:	.asciiz	"("
closep:	.asciiz	")"
minus:	.asciiz	" - "
plus:	.asciiz	" + "
equal:	.asciiz	" = "
p4:	.asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"
space:  .asciiz ""


############## Output ###########################################################
#                                
# Welcome to Miguel's math problem!
# Math Problem to be solve (A+B)-(C-D)
# Please enter A, B, C, D: 
# 1
# 2
# 3
# 4
#
# (1 + 2) - (3 - 4) = 4
#
# Would you like to repeat the program:   (1-yes, 0-no)1
# Welcome to Miguel's math problem!
# Math Problem to be solve (A+B)-(C-D)
# Please enter A, B, C, D: 
# 4
# 5
# 6
# 7
#
# (4 + 5) - (6 - 7) = 10
#
# Would you like to repeat the program:   (1-yes, 0-no)0     
#                                  
##################################################################################