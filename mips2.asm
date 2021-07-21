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
	la $t0, StringBuffer # get StringBuffer to a worker var

t2_logger_word:  # this loop will remember odd words
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word # if char == ' ' go to next word
	beq $t1, 10, finish_long # if new line end count
	addi $t2, $t2, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t2_logger_word

next_word:
	addi $t0, $t0, 1 # check next char, continue from space
	bgt $t2, $t3, reset_t3 # if t2 > t3 reset t2
	add $t2, $0, $0 # reset t2 because t3 > t2
	j t2_logger_word

reset_t3:
	add $t3, $0, $0 

t3_logger_word:  # this loop will remember even words
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word # if char == ' ' go to next word
	beq $t1, 10, finish_long # if new line end count
	addi $t3, $t3, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t3_logger_word

finish_long:
	la $a0, LongestWord # load text LongestWord
	li $v0, 4 # print null terminated string "The longest word = "
	syscall

	bgt $t2, $t3, print_odd # if t2 > t3 print odd
	add $t6, $t3, $t0 # Store longest word, for future purposes, t2
	la $a0, ($t3) # print letter count
	li $v0, 1 # service 1 is print integer
	syscall
	j end_task2 # goto end if printed# Title: Maman12 Filename: Question3
# Author: Ido Ziv Date: 20/07/2021
# Description: Question 3 - get string from user and count number of words, largest word and smallest word
# Input:
# Output:String contain 1 word or more
################# Data segment #####################
.data
	StringBuffer: .space 80 # space for user string
	GetString: .ascii "Please enter some words:"
	WordNumber:  .asciiz "Number of words = "
	Diff: .asciiz "Difference = "
	LongestWord: .ascii "The longest word = "
	ShortestWord: .ascii "The shortest word = "
	NewLine: .asciiz "\n"
	# "Letters in longest word = "
	# "Letters in shortest word = "
	# "Total number of letters = "
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
	la $t0, StringBuffer # get StringBuffer to a worker var

t2_logger_word:  # this loop will remember odd words
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word # if char == ' ' go to next word
	beq $t1, 10, finish_long # if new line end count
	addi $t2, $t2, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t2_logger_word

next_word:
	addi $t0, $t0, 1 # check next char, continue from space
	bgt $t2, $t3, reset_t3 # if t2 > t3 reset t2
	add $t1, $0, $0 # reset t1 because t3 > t2
	j t2_logger_word

reset_t3:
	add $t3, $0, $0 

t3_logger_word:  # this loop will remember even words
	lb $t1, ($t0) # load to t1 the first character in string
	beq $t1, 32, next_word # if char == ' ' go to next word
	beq $t1, 10, finish_long # if new line end count
	addi $t3, $t3, 1 # count++ for current word
	addi $t0, $t0, 1 # check next char
	j t3_logger_word

finish_long:
	la $a0, LongestWord # load text LongestWord
	li $v0, 4 # print null terminated string "The longest word = "
	syscall

	bgt $t2, $t3, print_odd # if t2 > t3 print odd
	add $t6, $t3, $t0 # Store longest word, for future purposes, t2
	la $a0, ($t3) # print letter count
	li $v0, 1 # service 1 is print integer
	syscall
	j end_task2 # goto end if printed

print_odd:
	add $t6, $t2, $t0 # Store longest word, for future purposes, t3
	la $a0, ($t2) # print letter count
	li $v0, 1 # service 1 is print integer
	syscall
	
# echo finish
end_task2:
	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
	syscall


	#ADD data valiadation
	li $v0, 10 # Exit 
	syscall



print_odd:
	add $t6, $t2, $t0 # Store longest word, for future purposes, t3
	la $a0, ($t2) # print letter count
	li $v0, 1 # service 1 is print integer
	syscall

# echo finish
end_task2:
	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
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


	#ADD data valiadation
	li $v0, 10 # Exit 
	syscall
