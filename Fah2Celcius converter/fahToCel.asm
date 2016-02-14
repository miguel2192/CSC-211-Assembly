########### fahToCel.asm#########################
# Miguel Rodriguez                              #
# fahToCel.asm                                  #
# Description                                   #
#     Program which displays a message          #
# Program Logic                                 #
# 1.  Ask for a temperature in fahrenheit       #
# 2.  Stores the temperature                    #
# 3.  Converts the temperature to celsius       #
# 4.  displays the temperature                  #
# 5.  returns to operating system               #
#################################################

        .text
        .globl __start
__start:

     

        la $a0,prompt    #Display the message below
        li $v0,4         #a0 = address of string
        syscall          #v0 = indicates display a string

        li $v0,5         #returns the value     
        syscall
             
        sub $t0, $v0, 32 #substracts the values
        mul $t0, $t0, 5  #Multiplies the values
        div $t0, $t0, 9  #divides the values

        la $a0, ans1     #Stores the value
        li $v0,4         #Returns the value
        syscall

        move $a0,$t0       
        li  $v0,1       
        syscall

        la $a0,endl      
        li $v0,4
        syscall
        
	
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

#########################################################################


        .data
prompt: .asciiz "Enter temperature in Fahrenheit: "
ans1:   .asciiz "The temperature in Celsius is "
endl:   .asciiz "\n"
p4:	.asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"


############## Output ##################
#Console
#=========================
# Enter temperature in Fahrenheit: 30
# The temperature in Celsius is -1

# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter temperature in Fahrenheit: -40
# The temperature in Celsius is -40

# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter temperature in Fahrenheit: 32
# The temperature in Celsius is 0

# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter temperature in Fahrenheit: 212
# The temperature in Celsius is 100

# Would you like to repeat the program:   (1-yes, 0-no)0                
#                                      
########################################