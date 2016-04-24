#########################################
<<<<<<< HEAD
# Author: Miguel Rodriguez              #
# division.asm - div(a,b)               #
# Example of a recursive program that   #
#   uses addition to create division    #
=======
#                                       #
# mp.asm - mp(a,b)                      #
# Example of a recursive program that   #
#   uses addition to create multiplica  #
>>>>>>> origin/master
#  // Java Version:  mp.java            #
#     if(a<b) return 0;                 #
#                                       #
#   else return (1+div(a-b,b));         #
#########################################

        .text
        .globl __start
__start:
<<<<<<< HEAD
        la $a0,prompt          # display "Enter the first number: "
        li $v0,4
        syscall	
	
        li $v0,5               # enter the first number
        syscall 
	
        move $a0,$v0           # call  method
        
       #############################changes##############################
         
        li $v0,5               # enter the second number
	syscall 
		
        move $a1,$v0           # call  method
=======
        la $a0,prompt       # display "Enter factorial number: "
        li $v0,4
        syscall	
	
        li $v0,5            # enter the factorial number
        syscall 
	
        move $a0,$v0        # call factorial method
        
       #############################changes##############################
         
        li $v0,5            # enter the factorial number
	syscall 
		
        move $a1,$v0        # call factorial method
>>>>>>> origin/master
        
        ##############################changes#############################
        jal dv	
        move $t0,$v0           # save result in t0

<<<<<<< HEAD
        la $a0,ans             # display "a / b = "
=======
        la $a0,ans             # display "a x b = "
>>>>>>> origin/master
        li $v0,4
        syscall	

        move $a0,$t0           # display returned result
        li $v0,1
        syscall

        la $a0,endl            # display crlf
        li $v0,4
        syscall

<<<<<<< HEAD
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
=======
        li $v0,10              # EOP
        syscall
>>>>>>> origin/master

################ fact method ####################
# a0 - holds a                                  #
# a1 - holds b                                  #
# v0 - holds the returned result, a / b         #
#################################################

dv:      sub $sp,$sp,12        # push registers onto stack
         sw $a0,0($sp)
         sw $a1,4($sp)
         sw $ra,8($sp)

         bge $a0,$a1,notZero
<<<<<<< HEAD
         li $v0,0               # mp(0) = 1, mp(1) = 1
         j factret

notZero: #move $s0,$a0          # save n
         sub $a0,$a0,$a1        # parameter = b-1
         jal dv                 # compute div(n-1)
         #sub $v0,$a0,$v0       # substrcts instead of add
         addi $v0,$v0,1
=======
         li $v0,0                 # mp(0) = 1, mp(1) = 1
         j factret

notZero: #move $s0,$a0           # save n
         sub $a0,$a0,$a1         # parameter = b-1
         jal dv                 # compute div(n-1)
         #sub $v0,$a0,$v0       # substrcts instead of add
         addi $v0,1
>>>>>>> origin/master

factret:	
         lw $a0,0($sp)          # restore registers from stack
         lw $a1,4($sp)	 
         lw $ra,8($sp)
         add $sp,$sp,12

         jr $ra                 # return

        .data
prompt: .asciiz "Enter 2 numbers: "
ans:    .asciiz "a / b = "
endl:   .asciiz "\n"
<<<<<<< HEAD
p4:	.asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"

######### Sample Output############################################################
# Enter 2 numbers: **** user input : 100
# **** user input : 4
# a / b = 25
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 1
# Enter 2 numbers: **** user input : 10
# **** user input : 2
# a / b = 5
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 1
# Enter 2 numbers: **** user input : 15
# **** user input : 5
# a / b = 3
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 1
# Enter 2 numbers: **** user input : 25
# **** user input : 5
# a / b = 5
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 0
# 
# -- program is finished running --
#################################################################################
=======

######### Sample Output##########
#                               #
# Enter factorial number: 5     #
# n! = 120                      #
#                               #
# Enter factorial number: 6     #
# n! = 720                      #
#                               #
#################################
>>>>>>> origin/master
