# Title: Maman12 Filename: Question4
# Author: Ido Ziv Date: 20/07/2021
# Description: Question 4 - Bullseye game
# Input: chars
# Output:String contain 1 word or more

############ data ###############
.data
	bool: .space 4 # 4 bytes of a char, null terminated
	InputMessage: .asciiz "Please Enter a chat between '0' to '9': "
	InputGuess: .asciiz "Enter your guess: "
	Error: .asciiz "\n  Wrong Input \n"
	NumberOk: .asciiz "\ninput ok, number is: "
	NewLine: .asciiz "\n"
	guess: .space 4 
	show_b: .asciiz "b"
	show_p: .asciiz "p"
	show_n: .asciiz "n"
	
################# Code segment #####################
.text
.globl main
main: # main program entry

#get_number:
	la $a0, bool # get char to bool array
	jal get_number # calling get_number function
call_get_guess:	
	la $a0, InputGuess 
	li $v0, 4
	syscall
	jal get_guess
	bne $v0, -1, call_get_guess # Call another guess if player didn't guess the right number
###### mission 1 #########
get_number:
	move $t0, $a0 # set t0 to the address of bool
	li $t1, 0 # set t1 to first legal char
	li $t2, 0 # set t2 to first legal char
	li $t3, 0 # set t3 to first legal char
# print to user  
	la $a0, InputMessage
	li $v0, 4
	syscall
	
# legal input:
# '0' <= char <= '9'
# c1 != c2 != c3

read_digit:
	la $a0, NewLine
	li $v0, 4 # service 8 is print str
	syscall 
	li $v0, 12 # service 12 is read char
	syscall
	blt $v0, '0', input_not_ok # less than '0'	
	bgt $v0, '9', input_not_ok # great than '9'
	j check_input

input_not_ok:
	la $a0, Error 
	li $v0, 4
	syscall
	j read_digit

check_input:
	bne $t1, $0, validate_different # t1 is not 0 anymore
	move $t1, $v0 # store in t1 the first input
	j save_number

validate_different:
	beq $t1, $v0, input_not_ok # t1 == v0 (not diff)
	bne $t2, $0, check_last_digit # t2 is not empty
	move $t2, $v0 # store input in t2

save_number:
	sb $v0, 0($t0) # get v0 byte to t0  - address in bool
	addi $t0, $t0, 1 # move index to next digit
	j read_digit

check_last_digit:
	beq $t2, $v0, input_not_ok # t2 == v0 (not diff)
	sb $v0, 0($t0) # store v0 in t0
	move $t3, $v0 # Store third char in t3
	jr $ra

################# mission 2 ####################
## Error handling message and a new guess
error_guess:
	la $a0, Error 
	li $v0, 4
	syscall
new_guess:
	la $a0, InputGuess  
	li $v0, 4
	syscall
print_new_line:
	la $a0, NewLine
	li $v0, 4
	syscall
get_guess:
	la $a0, bool # load bool to a0
	la $a1, guess # load guess to a1
	move $t0, $a0 # get t0 to bool address
	move $t1, $a1 # get t1 to guess addres
	la $a0, NewLine
	li $v0, 4
	syscall
	la $a0, bool # load bool to a0
	li $v0, 4
	syscall
	
	j start_guess
	
start_guess:
	la $a0, InputGuess # print inpuy guess
	li $v0, 4
	syscall
### Read string	
	li $v0, 8 
	move $a0, $t1 # get to a0 the adddress of guess
	li $a1, 4 # read input
	syscall
	
## Save the 3 chars in registers 
	lb $t5, 0($t1) # get first guess char to t5
	lb $t6, 1($t1) # get second guess char to t6
	lb $t7, 2($t1) # get third guess char to t7
## Validate guess values
	blt $t7, '0', error_guess
	bgt $t7, '9', error_guess
	blt $t5, '0', error_guess
	bgt $t5, '9', error_guess
	blt $t6, '0', error_guess
	bgt $t6, '9', error_guess 
## Check if different values
	beq $t7, $t5, error_guess # t7 == t5
	beq $t7, $t6, error_guess # t7 == t6
	beq $t6, $t5, error_guess # t6 == t5
#### get bool chars to t1-t3
	lb $t2, 0($t0) # get first bool char to t2
	lb $t3, 1($t0) # get second bool char to t3
	lb $t4, 2($t0) # get third bool char to t4

# t1 -t3: bool, $t4-$t6 guess
	move $t8, $0 # "b" counter
	move $t9, $0 # "p" counter
#	print space
	la $a0, delimete
	li $v0, 4
	syscall
## Check for "b" 's , if 3 "b" then game is finished ($v0 = -1)
check_first_b:
	bne $t2, $t5, check_second_b # t2 != $t5 not a 'b'
	addi $t8, $t8, 1 # counter ++
	la $a0, show_b  # print b
	li $v0, 4 # print str
	syscall
check_second_b:
	bne $t3, $t6, check_third_b  # t3 != t6 not a 'b'
	addi $t8, $t8, 1 # counter ++
	la $a0, show_b  # print b
	li $v0, 4 # print str
	syscall
check_third_b:
	bne $t4, $t7, echo_failed # t3 != t6 not a 'b'
	addi $t8, $t8, 1 # counter ++
	la $a0, show_b  # print b
	li $v0, 4 # print str
	syscall
	bne $t8, 3,echo_failed # not 3 'b' so check for 'p'
	li $v0, -1 # game finished
	jr $ra # Return to main

		
echo_failed:
	la $a0, NewLine
	li $v0, 4
	syscall
	move $t8, $0 # reset t8
	jr $ra

	li $v0, 10 # Exit 
	syscall
	