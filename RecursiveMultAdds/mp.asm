#########################################
# Author: Miguel Rodriguez              #
# mp.asm - mp(a,b)                      #
# Example of a recursive program that   #
#   uses addition to create multiplica  #
#  // Java Version:  mp.java            #
#  public static int fact(int a,b)      #
#  {                                    #
#    if (b == 1) return 1;              #
#    else return (a*mp(a,b-1));         #
#  }                                    #
#########################################

        .text
        .globl __start
__start:
        la $a0,prompt  # display "Enter 1 number: "
        li $v0,4
        syscall	
	
        li $v0,5       # enter the 1 number
        syscall 
	
        move $a0,$v0   # call 1 method
        
         
        li $v0,5       # enter the 2 number
	syscall 
		
        move $a1,$v0   # call 2 method
        
      
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

        li $v0,10      # EOP
        syscall

################ fact method ####################
# a0 - holds a                                  #
# a1 - holds b                                  #
# v0 - holds the returned result, a x b         #
#################################################

mp:   sub $sp,$sp,12  # push registers onto stack
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

######### Sample Output##########
#                               #
# Enter factorial number: 5     #
# n! = 120                      #
#                               #
# Enter factorial number: 6     #
# n! = 720                      #
#                               #
#################################
