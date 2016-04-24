#########################################
#                                       #
# mp.asm - mp(a,b)                      #
# Example of a recursive program that   #
#   uses addition to create multiplica  #
#  // Java Version:  mp.java            #
#  public static int fact(int a,b)      #
#  {                                    #
#    if (b == 1) return 1;              #
#    else return (a+mp(a,b-1));         #
#  }                                    #
#########################################

        .text
        .globl __start
__start:
        la $a0,prompt  # display "Enter factorial number: "
        li $v0,4
        syscall	
	
        li $v0,5       # enter the factorial number
        syscall 
	
        move $a0,$v0   # call factorial method
        
       #############################changes##############################
         
        li $v0,5       # enter the factorial number
	syscall 
		
        move $a1,$v0   # call factorial method
        
        ##############################changes#############################
        jal mp	
        move $t0,$v0   # save result in t0

        la $a0,ans     # display "a x b = "
        li $v0,4
        syscall	

        move $a0,$t0   # display returned result
        li $v0,1
        syscall

        la $a0,endl    # display crlf
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

################ fact method ####################
# a0 - holds a                                  #
# a1 - holds b                                  #
# v0 - holds the returned result, a x b         #
#################################################

mp:     sub $sp,$sp,12  # push registers onto stack
        sw $a0,0($sp)
        sw $a1,4($sp)
        sw $ra,8($sp)

        bgt $a1,1,notOne
        move $v0,$a0        # mp(0) = 1, mp(1) = 1
        j factret

notOne: move $s0,$a0    # save n
        sub $a1,$a1,1   # parameter = n-1
        jal mp          # compute fact(n-1)
        add $v0,$a0,$v0 # save fact(n-1)

factret:	
        lw $a0,0($sp)   # restore registers from stack
        lw $a1,4($sp)	 
        lw $ra,8($sp)
        add $sp,$sp,12

        jr $ra          # return

        .data
prompt: .asciiz "Enter 2 numbers: "
ans:    .asciiz "a x b = "
endl:   .asciiz "\n"
p4:	.asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"

######### Sample Output########################################################
# Enter 2 numbers: **** user input : 10
# **** user input : 2
# a x b = 20
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 1
# Enter 2 numbers: **** user input : 5
# **** user input : 5
# a x b = 25
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 1
# Enter 2 numbers: **** user input : 15
# **** user input : 3
# a x b = 45
#
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 1
# Enter 2 numbers: **** user input : 7
# **** user input : 6
# a x b = 42
# 
# Would you like to repeat the program:   (1-yes, 0-no)**** user input : 0
# 
# -- program is finished running --
################################################################################### 