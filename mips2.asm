 # Title: Maman12 Filename: Question3
# Author: Ido Ziv Date: 20/07/2021
# Description: Question 3 - get string from user and count number of words, largest word and smallest word
# Input:
# Output:String contain 1 word or more
################# Data segment #####################
.data
	StringBuffer: .space 80 # space for user string
	GetString: .asciiz "Please enter some words:"
	WordNumber:  .asciiz "Number of words = "
	Diff: .asciiz "Difference = "
	LongestWord: .asciiz "The longest word = "
	ShortestWord: .asciiz "The shortest word = "
	NewLine: .asciiz "\n"
	# "Letters in longest word = "
	# "Letters in shortest word = "
	# "Total number of letters = "
	LettersCount: .asciiz "Total number of letters = "
	InputOk: .asciiz "Input is Ok"
	InputNotOk: .asciiz "Input is Not Ok"
################# Code segment #####################
.text
.globl main
main: # main program entry
	la $a0, GetString # $a0 = address of str, set $a0 to GetString label
	li $v0, 4 # read string
	syscall

	la $a0, StringBuffer # enter the input string to string buffer
	li $a1, 81 # Maximum String size is 80
	li $v0, 8 # service 8 is print str
	syscall

# input validation
# small or capital letter 65-90 capital, 97-122 ascii
# no two spaces together
# not ending in space
# at least one letter

	la $t0, StringBuffer # get StringBuffer to a worker var
	li $t1, 0 # reset counter t1
	li $t2, 0 # reset counter t2

# ############### print t1 ################# #
# la $a0, ($t1) # print WordCount
# li $v0, 1 # service 1 is print integer
# syscall
# ############### print t2 ################# #
# la $a0, ($t2) # print WordCount
# li $v0, 1 # service 1 is print integer
# syscall
# ############### print newline ################# #
# la $a0, NewLine 
# li $v0, 4
# syscall
# ################################ #


input_validation:
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 10, check_new_line # if new line end count
	beq $t1, 32, check_spaces # if char == ' ' go to next word
	bgt $t1, 122, input # bigger than z
	blt $t1, 65, input # lower than A
	bgt $t1, 90, check_for_letters # check betweem Z to a
	move $t2, $t1 # set the counter t2 to t1
	addi $t0, $t0, 1 # check next char
	j input_validation
	
check_new_line:
	beq $t2, 32, input # if last char is space
	j end_validation

check_spaces:
	beq $t2, 32, input # if two spaces
	move $t2, $t1 # if not, continue
	addi $t0, $t0, 1 
	j input_validation
	
check_for_letters:
	blt $t1, 97, input # if betweem 90-97
	move $t2, $t1 # if not, continue
	addi $t0, $t0, 1 
	j input_validation
	
input:
	la $a0, InputNotOk # input is not ok
	li $v0, 4 # print null terminated string "Number of words = "
	syscall
	la $a0, NewLine 
	li $v0, 4
	syscall
	la $a0, GetString # $a0 = address of str, set $a0 to GetString label
	li $v0, 4 # read string
	syscall

	la $a0, StringBuffer # enter the input string to string buffer
	li $a1, 81 # Maximum String size is 80
	li $v0, 8 # service 8 is print str
	syscall
	la $a0, StringBuffer # enter the input string to string buffer
	li $a1, 81 # Maximum String size is 80
	li $v0, 8 # service 8 is print str
	syscall
	
	li $t1, 0 # reset counter t1
	li $t2, 0 # reset counter t2
	la $t0, StringBuffer # get StringBuffer to a worker var
	j input_validation #check again

end_validation: # Finish validation check
	la $a0, InputOk # input is ok
	li $v0, 4 # print null terminated string "Number of words = "
	syscall
	la $a0, NewLine 
	li $v0, 4
	syscall

# Mission 1 - Count how many words in the string	
	addi $t2, $0, 1 # $t2 will store the word count which is minimum 1
	la $t0, StringBuffer # get StringBuffer to a worker var
how_many_words:
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, add_word # if char == ' ' add a word to count
	beq $t1, 10, finish_word # if new line end count
	addi $t0, $t0, 1 # check next char
j how_many_words

add_word:
	addi $t2, $t2, 1 # add a word
	addi $t0, $t0, 1 # check next char
	j how_many_words

finish_word:
	la $a0, WordNumber # load wordCount
	li $v0, 4 # print null terminated string "Number of words = "
	syscall

	la $a0, ($t2) # print WordCount
	li $v0, 1 # service 1 is print integer
	syscall

	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
	syscall

# Mission 2 - Count how many letters in longest word
# t0 -> the word t1 -> current letter t2- > odd buffer t3 -> even buffer
	add $t2, $0, $0 # reset t2
	la $t0, StringBuffer
	
t2_logger_word: # this loop will remember odd words
	lb $t1, ($t0) # load character (check if space)
	beq $t1, 32, next_word # if char == ' ' go to next word
	beq $t1,10, finish_long # if new line than it is the last word, finish mission
	addi $t2, $t2, 1 # count ++ to the word
	addi $t0, $t0, 1 # check next char
	j t2_logger_word
	
next_word:
	addi $t0, $t0, 1 # check next char, continue from space
	bgt $t2, $t3, reset_t3 # if t2 > t3 reset t2
	add $t2, $0, $0 # Reset t2 to check next word
	j t2_logger_word
	
reset_t3:
	add $t3, $0, $0 #Reset t3 to check new word
t3_word:
	lb $t1, ($t0) # load character (check if space)
	beq $t1, 32, next_word # if char == ' ' go to next word
	beq $t1,10, finish_long # if new line than it is the last word, finish mission
	addi $t3, $t3, 1 # count ++ to the word
	addi $t0, $t0, 1 # check next char
	j t3_word	

finish_long:
	la $a0, LongestWord # "Letters in longest word = " text
	li $v0, 4
	syscall
	
	bgt $t2, $t3, print_t2
	add $t6, $t3, $t0 # Store longest word, for future purposes, t3
	la $a0, ($t3)
	li $v0, 1
	syscall
	j end_task2
	
print_t2:
	add $t6, $t2, $t0 # Store longest word, for future purposes, t2
	la $a0, ($t2)
	li $v0, 1
	syscall
	# echo finish
end_task2: # Finish mission 2		
	la $a0, NewLine 
	li $v0, 4
	syscall


    # Mission 3 - Count how many letters in shortest word
# t0 -> the word t1 -> current letter t4- > odd buffer t5 -> even buffer
#	add $t4, $0, $0 # reset t4
	la $t0, StringBuffer # get StringBuffer to a worker var

t4_logger_word:  # this loop will remember odd words
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word_short # if char == ' ' go to next word
	beq $t1, 10, finish_short # if new line end count
	addi $t4, $t4, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t4_logger_word

next_word_short:
	addi $t0, $t0, 1 # check next char, continue from space
	beqz $t5, t5_logger_word # if t5 is zero, assign a word to it
	bgt $t5, $t4, reset_t5 # if t5 > t4 reset t5
	add $t4, $0, $0 # reset t4 because t4 > t5
	j t4_logger_word 

reset_t5:
	add $t5, $0, $0  # reset t5 

t5_logger_word:  # this loop will remember even words
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word_short # if char == ' ' go to next word
	beq $t1, 10, finish_short # if new line end count
	addi $t5, $t5, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t5_logger_word

finish_short:
	la $a0, ShortestWord # load text ShortestWord
	li $v0, 4 # print null terminated string "The Shortest word = "
	syscall

	blt $t4, $t5, print_odd_short # if t2 > t3 print odd
	add $t7, $t5, $t0 # Store longest word, for future purposes
	la $a0, ($t5) # print letter count
	li $v0, 1 # service 1 is print integer
	syscall
	j end_task3 # goto end if printed

print_odd_short:
	add $t7, $t4, $t0 # Store longest word, for future purposes
	la $a0, ($t4) # print letter count
	li $v0, 1 # service 1 is print integer
	syscall

# echo finish
end_task3:
	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
	syscall

# Mission 4 - diff between long to short
# t6 -> longest , t7 -> shortest

end_task4:
	la $a0, Diff # load text Diff
	li $v0, 4 # print null terminated string "Difference = "
	syscall

	sub $t6, $t6, $t7 # subtract t7 from t6 (long - short)
	la $a0, ($t6) # print diff
	li $v0, 1 # service 1 is print integer
	syscall

	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
	syscall

# Mission 5 - Count Letters
	la $t0, StringBuffer # get StringBuffer to a worker var
	
	# t0 -> current word t1 -> current char, t8 counter
t8_logger_word:
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word_count # if char == ' ' go to next word
	beq $t1, 10, finish_count # if new line end count
	addi $t8, $t8, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t8_logger_word

next_word_count:
	# addi $t8, $t8, 1 # add a word
	addi $t0, $t0, 1 # check next char
	j t8_logger_word

finish_count:
	la $a0, LettersCount # load LettersCount
	li $v0, 4 # print null terminated string "Total number of letters = "
	syscall

	la $a0, ($t8) # print LettersCount
	li $v0, 1 # service 1 is print integer
	syscall

	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
	syscall
	
	#ADD data valiadation
	li $v0, 10 # Exit 
	syscall


