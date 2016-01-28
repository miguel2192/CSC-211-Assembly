########### helloIO.asm on p. 26-27 #############
# Miguel Rodriguez                              #
# helloIO.asm                                     #
# Description                                   #
#     Program which displays a message          #
# Program Logic                                 #
# 1.  Ask for a message                         #
# 2.  input the message                         #
# 3.  display a message from the data area      #
# 4.  display a new line                        #
# 5.  return to operating system                #
#################################################

        .text
        .globl __start
__start:

        la $a0,p1   # Display the message below "Enter your message"
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string


        la $a0,str  #Loads the address of the message area
        li $a1,80   #Loads the number of characters available for the message
          
        

        li $v0,8    #inputs the message
        syscall     #calls to do the command above

        la $a0,str  #displays the Message
        li $v0,4
        syscall
       
        la $a0,p2   #displays the new line
        li $v0,4
        syscall
    
          

        li $v0,10   # End Of Program	
        syscall     # Call to system

        .data
str:    .space      80
p1:     .asciiz     "Enter Your Message: "
p2:     .asciiz     "\n"
 
############## Output ##################
# Console                              #
#=========================             #
# Enter Your Message: Miguel Rodriguez #
# Miguel Rodriguez                     #
#                                      #
########################################