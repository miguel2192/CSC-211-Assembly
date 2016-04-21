#########################################
#                                       #
# mp.asm - mp(a,b)                      #
# Example of a recursive program that   #
#   uses addition to create multiplica  #
#  // Java Version:  mp.java            #
#     if(a<b) return 0;                 #
#                                       #
#   else return (1+div(a-b,b));         #
#########################################

        .text
        .globl __start
__start:
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
        
        ##############################changes#############################
        jal dv	
        move $t0,$v0           # save result in t0

        la $a0,ans             # display "a x b = "
        li $v0,4
        syscall	

        move $a0,$t0           # display returned result
        li $v0,1
        syscall

        la $a0,endl            # display crlf
        li $v0,4
        syscall

        li $v0,10              # EOP
        syscall

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
         li $v0,0                 # mp(0) = 1, mp(1) = 1
         j factret

notZero: #move $s0,$a0           # save n
         sub $a0,$a0,$a1         # parameter = b-1
         jal dv                 # compute div(n-1)
         #sub $v0,$a0,$v0       # substrcts instead of add
         addi $v0,1

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

######### Sample Output##########
#                               #
# Enter factorial number: 5     #
# n! = 120                      #
#                               #
# Enter factorial number: 6     #
# n! = 720                      #
#                               #
#################################
