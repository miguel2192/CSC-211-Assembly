###############quadraticPlot.asm################################
# Author:  Miguel Rodriguez
# Description: This program solves a quadratic
#    problem and it plots (graph) it on the screen for the user.
#    f(x) = (Ax + B)x + C 
# Date: 3/3/2016
# Pseudo code
# 1.)  Get input from user (A, B, C)
# 2.)  Get input from user (x1 and x2)
# 3.)  Get input from user (ymax and ymin)
# 4.)  y = ymax
# 5.)  x = x1
# 6.)  f(x) = (Ax + B)x + C
# 7.)  if (y==f(x)) display '*' and goto 11
# 8.)  if (x==0) display '|' and goto 11
# 9.)  if (y==0) display '-' and goto 11
# 10.) display ' '
# 11.) if (x == x2) display '\n' and goto 13
# 12.) x++ and goto 6
# 13.) if (y == ymin) goto 15 (End program)
# 14.) y-- and goto 5
# 15.) EOP
#
# Register assignments
#	t0 = A
#	t1 = B
#	t2 = C
#	t3 = x1 (lowx) (xmin)
#	t4 = x2 (upx) (xmax)
#	t5 = value of f(x)
#	t6 = ymin
#	t7 = ymax
#	t8 = y counter, starts at ymax and decrements till it's ymin
#	t9 = x counter, starts at xmin and goes to xmax
#
###################################################################

	.text
	.globl __start
__start:
step1:
     
	la $a0, prompta			#Prompts for 'A'
	li $v0, 4
	syscall

	li $v0, 5	                #t0 = A
	syscall
	move $t0, $v0

	la $a0, promptb			#Prompts for 'B'
	li $v0, 4
	syscall

	li $v0, 5		        #t1 = B
	syscall
	move $t1, $v0

	la $a0, promptc			#Prompts for 'C'
	li $v0, 4
	syscall

	li $v0, 5		        #t2 = C
	syscall
	move $t2, $v0
step2:
	la $a0, promptlx		#Prompts for the lower bound for X
	li $v0, 4
	syscall

	li $v0, 5			#t3 = LowX
	syscall
	move $t3, $v0

	la $a0, promptux		#Prompts for the upper bound of X
	li $v0, 4
	syscall

	li $v0, 5			#t4 = UpperX
	syscall
	move $t4, $v0
step3:
	la $a0, promptly		#Prompts for the lower bound of Y
	li $v0, 4
	syscall

	li $v0, 5			#t6 = LowY
	syscall
	move $t6, $v0

	la $a0, promptuy		#Prompts for the upper bound of Y
	li $v0, 4
	syscall

	li $v0, 5			#t7 = UpperY
	syscall
	move $t7, $v0
	
step4:
	move $t8, $t7			#y = Ymax
step5:
	move $t9, $t6			#x =x x1
step6:
	mul $t5, $t9, $t0		#t5 = f(x)
	add $t5, $t5, $t1
	mul $t5, $t5, $t9
	add $t5, $t5, $t2
step7:
	bne $t8, $t5, step8		#goto 8 if t8 != t5

	la $a0, point			#display '*' if t8 == t5
	li $v0, 4
	syscall

	j step11			#goto step11 if t8 == t5
step8:
	bne $t9, 0, step9		#branch to step9 if t9!=0
	
	la $a0, yaxis			#Display '|' if t9==0
	li $v0, 4
	syscall

	j step11			#jump to step11
step9:
	bne $t8, 0, step10		#branch to step10 if t8 != 0

	la $a0, xaxis			#display '-' if t8 == 0
	li $v0, 4
	syscall

	j step11			#jump to step11 if t8 == 0
step10:
	la $a0, space			#display ' '
	li $v0, 4
	syscall
step11:
	bne $t9, $t4, step12	        #branch to step 12 if t9 != t4

	la $a0, nl			#display '/n' if t9 == t4
	li $v0, 4
	syscall

	j step13			#jump to step 13 if t9 == t4

step12:
	addi $t9, $t9, 1		#t9++

	j step6				#jump to step6
step13:
	bne $t8, $t6, step14	        #branch to step 14 if t8 != t6

	j step15			#jump to step15 (EOP) if t8 == t6
step14:
	addi $t8, $t8, -1		#t8--

	j step5				#jump to step5
step15:
	la $a0, nl			#display '\n'
	li $v0, 4
	syscall

	li $v0, 10			#EOP
	syscall
	.data	
prompta:  .asciiz "Enter a value for A: "
promptb:  .asciiz "Enter a value for B: "
promptc:  .asciiz "Enter a value for C: "
promptlx: .asciiz "Enter a lower bound for X: "
promptux: .asciiz "Enter an upper bound for X: "
promptly: .asciiz "Enter a lower bound for Y: "
promptuy: .asciiz "Enter an upper bound for Y: "
nl:       .asciiz "\n"
yaxis:    .asciiz "|"
xaxis:    .asciiz "-"
point:    .asciiz "*"
space:    .asciiz " "
##################################################
# -------------------OUTPUT~~~~~~~~------------- #
##################################################
#Enter a value for A: 1
#Enter a value for B: 1
#Enter a value for C: 1
#Enter a lower bound for X: -10
#Enter an upper bound for X: 10
#Enter a lower bound for Y: -10
#Enter an upper bound for Y: 10
#          |          
#          |          
#          |          
#       *  | *        
#          |          
#          |          
#          |          
#        * |*         
#          |          
#         **          
#----------|----------
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#
#Enter a value for A: 0
#Enter a value for B: 0
#Enter a value for C: 0
#Enter a lower bound for X: -10
#Enter an upper bound for X: 10
#Enter a lower bound for Y: -10
#Enter an upper bound for Y: 10
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#*********************
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
#          |          
###################################################
###################################################