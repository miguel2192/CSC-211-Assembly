############ IOSortArray.asm on ##################
# Author: Miguel Rodriguez                       #
# Illustrates Base Addressing                    #
#                                                #
# Enter an array of numbers and                  #
# sorts them and displays them                   #
#                                                #
##################################################
#  output - a subprogram or method to:           #
#  1. sorts the entries in the array             #
#  2.display the entries in an array             #
#                                                #
################################################## 


       .text
       .globl __start
__start:

restart:
	
	jal input			# Call a subprogram to enter an array of numbers
	jal output                      # helps display regular numbers from array
	jal sort
	jal output                      # helps display sorted numbers
	jal restarts

	la $t0,array			# t0 = address of array
	lw $t1,count			# t1 = count, exit loop when it goes to 0
	lw $t2,($t0)			# t2 = min = a[0] (initialization)
	lw $t3,($t0)			# t3 = max = a[0] (initialization)
	add $t0,$t0,4			# move pointer ahead to next array element a[1]
	add $t1,$t1,-1 			# decrement counter to keep in step with array


loop: lw $t4,($t0) 			# t4 = next element in array
	bge $t4,$t2,notMin	        # if array element is  >= min goto notMin

	move $t2,$t4			# min = a[i]
	j notMax

notMin: ble $t4,$t3,notMax			# if array element is <= max goto notMax

	move $t3,$t4			# max = a[i]
notMax: add $t1,$t1,-1			# t1 --  ->  counter --
	add $t0,$t0,4			# increment counter to point to next word
	bnez $t1,loop

	la $a0,min			# Display "The minimum number is "
	li $v0,4				# a0 = address of message
	syscall				# v0 = 4 which indicates display a string	

	move $a0,$t2			# Display the minimum number 
	li $v0,1
	syscall

	la $a0,max			# Display "The maximum number is "
	li $v0,4				# a0 = address of message
	syscall				# v0 = 4 which indicates display a string

	move $a0,$t3			# Display the maximum number 
	li $v0,1
	syscall

	la $a0,nl			# Display "cr/lf"
	li $v0,4				# a0 = address of message
	syscall				# v0 = 4 which indicates display a string

	li $v0,10		        # End Of Program
	syscall

output:                                 

	la $a0, numbers                 #displays the numbers
	li $v0, 4
	syscall

	la $t0, array                   # initialize t0 and t1 
	lw $t1, count

outloop:                                # use a loop to enter the actual numbers in array
	lw $t5, ($t0)                   # load a number from the array into $t5
	move $a0, $t5                   # display that number with spacing (either new line or space)
	li $v0, 1
	syscall

	la $a0, space                   # displays the new line
	li $v0, 4
	syscall

	addi $t0, $t0, 4
	addi $t1, $t1, -1

	bgtz $t1, outloop               
	la $a0, nl
	li $v0, 4
	syscall
	jr $ra                          # go back to where you came from


input:					#Ask for the numbers of numbers in the array
	la $a0, prompt1			#Print "Please enter the number of numbers that you wish to enter: "
	li $v0, 4
	syscall

	li $v0, 5			#Gets input from the user
	syscall
	sw $v0, count

	move $t5, $v0			# t5 = count
	li $t6, 1			# t6 = 1

	la $t0 array


inloop:
	
	la $a0, pound                   #Display #1, #2, #3, etc...
	li $v0, 4
	syscall

	move $a0, $t6
	li $v0, 1
	syscall

	la $a0, spacing
	li $v0, 4
	syscall

	         
	li $v0, 5                         #Enter the array numbers
	syscall
	sw $v0,($t0)

	addi $t0, $t0, 4	          #t0 = t0 + 4
	addi $t6, $t6, 1	          #t6 = t6 + 1

	ble $t6, $t5, inloop


	jr $ra                            # go back to where you came from

sort:
	la $t0, array		          # t0 is a pointer to a[0] (a[i])
	la $t1, array		          # t1 is a pointer to a[0] (a[j])
	addi $t1, $t1, 4	          # t1 += 4 (so t1 is now a pointer to a[1])

	
	lw $t2, count                     # t2 = count    (i counter)
	 
	addi $t2, $t2, -1                 # t2 = count-1
	
	move $t3, $t2                     # t3 = t2       (j counter)

sloop:                      
	
	lw $t4, ($t0)                     # t4 = a[i]       
	
	lw $t5, ($t1)                     # t5 = a[j]
	
	ble $t4, $t5, noswap              # if (a[i] <= a[j]) do not swap
	
swap:
	sw $t5, ($t0)                     # swap a[i] and a[j]
	sw $t4, ($t1)
noswap:                     
	
	addi $t1, $t1, 4                  # t1 = next address of a[j]
	
	addi $t3, $t3, -1                 # j count --
	
	bnez $t3, sloop                   # if j count != 0 go back to sort loop
	
	addi $t0, $t0, 4                  # t0 = next address of a[i]
	
	addi $t2, $t2, -1                 # i count --
	
	move $t3, $t2                     # j count = i count
	
	beqz $t2, endsort                 # if i count = 0 sort is complete
	
	addi $t1, $t0, 4                  # t1 = the next address of a[i]
	
	j sloop                           # jump to sort loop
	endsort:
	jr $ra                            # go back to where you came from
	
restarts:

	la $a0, prompt2                   #prompts the user if they wish to restart program
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	bnez $v0, restart                 #restarts the program

	li $v0, 10
	syscall

        .data
array:	.space	100
count:	.word	0
min:	.asciiz	"The minimum number is "
max:	.asciiz	"\nThe maximium number is "
nl:		.asciiz	"\n"
prompt1:.asciiz	"Please enter the number of numbers that you wish to enter: "
pound:	.asciiz	"#"
spacing:.asciiz ": "
numbers:.asciiz	"Here are your numbers: \n"
space:	.asciiz	" "
prompt2:.asciiz "\nWould you like to repeat the program:   (1-yes, 0-no):  "


################ Output ###############################################################
# Please enter the number of numbers that you wish to enter: **** user input : 5
# #1: **** user input : -11
# #2: **** user input : 5
# #3: **** user input : 9
# #4: **** user input : 9
# #5: **** user input : 2
# Here are your numbers: 
# -11 5 9 9 2 
# Here are your numbers: 
# -11 2 5 9 9 
# 
# Would you like to repeat the program:   (1-yes, 0-no):  **** user input : 1
# Please enter the number of numbers that you wish to enter: **** user input : 5
# #1: **** user input : -100
# #2: **** user input : 9
# #3: **** user input : 6
# #4: **** user input : 3
# #5: **** user input : 55
# Here are your numbers: 
# -100 9 6 3 55 
# Here are your numbers: 
# -100 3 6 9 55 
# 
# Would you like to repeat the program:   (1-yes, 0-no):  **** user input : 1
# Please enter the number of numbers that you wish to enter: **** user input : 9
# #1: **** user input : 88
# #2: **** user input : 33
# #3: **** user input : -66
# #4: **** user input : 4
# #5: **** user input : 99
# #6: **** user input : 33
# #7: **** user input : 54
# #8: **** user input : 77
# #9: **** user input : 23
# Here are your numbers: 
# 88 33 -66 4 99 33 54 77 23 
# Here are your numbers: 
# -66 4 23 33 33 54 77 88 99 
# 
# Would you like to repeat the program:   (1-yes, 0-no):  **** user input : 0
# 
# -- program is finished running --
# 
##############################End Output##################################################