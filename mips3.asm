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