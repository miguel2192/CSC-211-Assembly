########### hello.asm on p. 26-27 #############
# Miguel Rodriguez                            #
# hello.asm                                   #
# Description                                 #
#     Program which displays a message        #
# Program Logic                               #
# 1.  Ask for a message                       #
# 2.  input the message                       #
# 3.  display a message from the data area    #
# 4.  return to operating system              #
###############################################

        .text
        .globl __start
__start:

        la $a0,str  # Display the message below
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4 indicates to display a string

        li $v0,10   # End Of Program	
        syscall     # Call to system

        .data
str:    .asciiz "\nMy Name is Miguel Rodriguez\nMy address is 33 Fennaway Green Cazenovia, NY\nMy Mobile phone is (315)418-6694\nMy email address is miguelrdrgz47@gmail.com\n"

#################################################
############## Output ###########################
#                                               #
# My Name is Miguel Rodriguez                   #
# My address is 33 Fennaway Green Cazenovia, NY #
# My Mobile phone is (315)418-6694              #
# My email address is miguelrdrgz47@gmail.com   #
#                                               #
#################################################
#################################################