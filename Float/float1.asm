########### float1.asm ##########################
# Miguel Rodriguez                              #
# float1.asm                                    #
# Description                                   #
#     A program using float.                    # 
#     return to operating system                #
#################################################


## float1.asm -- compute ax^2 + bx + c for user-input x 
##
## SPIM settings: pseudoinstructions: ON, branch delays: OFF,
##                load delays: OFF

        .text
        .globl __start

        # Register Use Chart
        # $f0 -- x                  #register f0 is use for inputting
        # $f2 -- sum of terms       

__start:   # read input
        la      $a0,prompt          # prompt user for x
        li      $v0,4               # print string
        syscall
        
        li      $v0,6               # read single
        syscall                     # $f0 <-- x
        
        # evaluate the quadratic
        l.s     $f2,a               # sum = a
        mul.s   $f2,$f2,$f0         # sum = ax
        l.s     $f4,bb              # get b
        add.s   $f2,$f2,$f4         # sum = ax + b
        mul.s   $f2,$f2,$f0         # sum = (ax+b)x = ax^2 +bx
        l.s     $f4,c               # get c
        add.s   $f2,$f2,$f4         # sum = ax^2 + bx + c
        
        # print the result
        mov.s   $f12,$f2            # $f12 = argument
        li      $v0,2               # print single
        syscall

        la      $a0,newl            # new line
        li      $v0,4               # print string
        syscall

        #li      $v0,10              # code 10 == exit
        #syscall                     # Return to OS.
        
        
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
        
##
##  Data Segment  
##
        .data
a:      .float  1.0
bb:     .float  1.0
c:      .float  1.0

prompt: .asciiz "Enter x: "
blank:  .asciiz " "
newl:   .asciiz "\n"
p4:	.asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"

############## Output ###########################################################
#      Enter x: -5
# 21.00000000
# 
# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter x: -1
# 1.00000000
# 
# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter x: 0.5
# 1.75000000

# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter x: 0
# 1.00000000
# 
# Would you like to repeat the program:   (1-yes, 0-no).1
# Enter x: 0.125
# 1.14062500
# 
# Would you like to repeat the program:   (1-yes, 0-no)0
#                           
# 
#                                  
##################################################################################
