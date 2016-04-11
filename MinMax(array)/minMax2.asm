############ minMax.asm on p. 65-66 ##############
# Author: Miguel Rodriguez                       #
# Illustrates Base Addressing                    #
#                                                #
# Enter an array of numbers and find the         #
# minimum and maximum of the array               #
#                                                #
# t1 = count, t2 = min, t3 = max                 #
# t0 = counter, t4 = array element               #
# t5 = address of array element, t6 = temp       #
#                                                #
##################################################
#                                                #
#  Project - to add an input and output methods  #
#                                                #
#  jal input - jump and link to a subprogram     #
#              to input an array of numbers      #
#                                                #
#  input - a subprogram or method to:            #
#  1. input the number of entries in an array    #
#  2. input those numbers                        #
#                                                #
#  jal output - jump and link to a subprogram    #
#               to display an array of numbers   #
#                                                #
#  output - a subprogram or method to:           #
#  1. display the entries in an array            #
#                                                #
##################################################   
   

        .text
        .globl __start
__start:

        jal input           # jump and link to method input

        jal output          # jump and link to method output



        la $t0,array        # t0 = address of array
        lw $t1,count        # t1 = count, exit loop when it goes to 0
        lw $t2,($t0)        # t2 = min = a[0] (initialization)
        lw $t3,($t0)        # t3 = max = a[0] (initialization)
        add $t0,$t0,4       # move pointer ahead to next array element a[1]
        add $t1,$t1,-1      # decrement counter to keep in step with array


loop:   lw $t4,($t0)        # t4 = next element in array
        bge $t4,$t2,notMin  # if array element is  >= min goto notMin

        move $t2,$t4        # min = a[i]
        j notMax

notMin: ble $t4,$t3,notMax  # if array element is <= max goto notMax

        move $t3,$t4        # max = a[i]
notMax: add $t1,$t1,-1      # t1 --  ->  counter --
        add $t0,$t0,4       # increment counter to point to next word
        bnez $t1,loop

        la $a0,p1           # Display "The minimum number is "
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string    

        move $a0,$t2        # Display the minimum number 
        li $v0,1
        syscall

        la $a0,p2           # Display "The maximum number is "
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string

        move $a0,$t3        # Display the maximum number 
        li $v0,1
        syscall

        la $a0,crlf         # Display "cr/lf"
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string

        li $v0,10           # End Of Program
        syscall


input:  la $a0,p3           # ask for how many numbers you want to enter 
        li $v0,4            # 4 means displaying a number
        syscall             

        li $v0,5            # input the number of numbers and place it in count
        syscall             #5 means inputting a number
        
        sw $v0,count        #count is the number of numbers                         
                            
        la $t0,array        # initialize t0 and t1  
        lw $t1,count        #load the address of the array t0 = array & t1 = count                  
 

inloop: li $v0,5            # use a loop to enter the actual numbers in array
        syscall
        sw $v0,($t0)        # store elemets in the array
        add $t0,$t0,4
        sub $t1,$t1,1
        beqz $t1,endInLoop  #if is equal to zero loop back
        j inloop

endInLoop:
        jr $ra              # go back to where you came from
        
                            # output method for student to create. 
                            
output: la $t0,array        # initialize t0 and t1  
        lw $t1,count                 

outloop:                    # use a loop to enter the actual numbers in array
                   
        lw $t6,($t0)        # load a number from the array into $t6
                            
        move $a0,$t6        # display that number with spacing (either new line or space)
        li $v0,1
        syscall             
                            # displays the new line
        la $a0,crlf         # new line
        li $v0,4            # print string
        syscall                  
                            
        add $t0,$t0,4       
        sub $t1,$t1,1
        bnez $t1,outloop    #if is equal to zero loop back
                            # repeat this again until all the numbers have been display
                            
        #jr $ra             # return to where you came from
        
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
array:  .space 100
count:  .word 0
p1:     .asciiz "The minimum number is "
p2:     .asciiz "\nThe maximum number is "
p3:     .asciiz "Enter the count of numbers to be read in: "
crlf:   .asciiz "\n"
p4:	.asciiz	"\nWould you like to repeat the program:   (1-yes, 0-no)"


################ Output ############################################################
# Console
# =========================
# Enter the count of numbers to be read in: 5
# 1
# 2
# 3
# 4
# 5
# 1
# 2
# 3
# 4
# 5

# Would you like to repeat the program:   (1-yes, 0-no)1
# Enter the count of numbers to be read in: 8
# 3
# 2
# 4
# 5
# 6
# 7
# 8
# 9
# 3
# 2
# 4
# 5
# 6
# 7
# 8
# 9
# Would you like to repeat the program:   (1-yes, 0-no)1
# Console
# =========================
# Enter the count of numbers to be read in: 5
# -3
# -30
# -29
# 0
# 10
# -3
# -30
# -29
# 0
# 10

# Would you like to repeat the program:   (1-yes, 0-no)1111
# Enter the count of numbers to be read in: 10
# 25
# -1
# 20
# -45
# 23
# 11
# -22
# -77
# -90
# 5
# 25
# -1
# 20
# -45
# 23
# 11
# -22
# -77
# -90
# 5

# Would you like to repeat the program:   (1-yes, 0-no)0

#                                       
#########################################################################################