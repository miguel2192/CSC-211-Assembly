########### max.asm ##############################
# Miguel Rodriguez                               #
# max.asm                                        #
# Description                                    #
#     Determines the max of two floating numbers #
# Program Logic                                  #
# 1.  Ask for A                                  #
# 2.  Ask for B                                  #
# 3.  Compare values                             #
# 4.  Display the greater value                  #
# 5.  reapeats the program using a while loop    #
# 5.  return to operating system                 #
##################################################
        .text
        .globl __start

__start:   # get the values into registers


        la      $a0,promptA      # prompt user for A
        li      $v0,4            # print string
        syscall
        
        li     $v0,6             # read single
	syscall                  # $f0 <-- x
        mov.s  $f4,$f0           #move f0 to f4
        
        
        la      $a0,promptB      # prompt user for A
	li      $v0,4            # print string
	syscall

	li     $v0,6             # read single
	syscall                  # $f0 <-- x
        mov.s  $f6,$f0           #move f0 to f4
       
 
        c.lt.s  $f4,$f6          # is A < B?
        bc1t    printA           # yes -- print A
        
        c.lt.s  $f6,$f4          # is B < A?
        bc1t    printB           # yes -- print B
        
      
        la      $a0,EQmsg        # otherwise
        li      $v0,4            # they are equal
        syscall
        
        mov.s   $f12,$f4         # print one of them
        b       prtnum
        
printA: la      $a0,Amsg         # message for A
        li      $v0,4
        syscall
        mov.s   $f12,$f6         # print A
        b       prtnum
        
printB: la      $a0,Bmsg         # message for B
        li      $v0,4
        syscall
        mov.s   $f12,$f4         # print B
        
prtnum: li      $v0,2            # print single precision
                                 # value in $f12
        syscall
        la      $a0,newl
        li      $v0,4            # print new line
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

        .data

promptA: .asciiz "Enter A: "
promptB: .asciiz "Enter B: "
Amsg:    .asciiz "B is Larger: "
Bmsg:    .asciiz "A is Larger: "
EQmsg:   .asciiz "They are equal: "
newl:    .asciiz "\n"
p4:	 .asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"

############## Output ###########################################################
#   Console
# =========================
# Enter A: 4.5
# Enter B: 8.7
# B is Larger: 8.69999981
# 
# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter A: 3.3
# Enter B: 7.7
# B is Larger: 7.69999981
# 
# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter A: 8.8
# Enter B: 1.1
# A is Larger: 8.80000019
# 
# Would you like to repeat the program:   (1-yes, 0-no)0                             
#    
#                                  
##################################################################################