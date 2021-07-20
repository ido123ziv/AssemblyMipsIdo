# Title: Maman12 Filename: Question3
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
	lb $t1, $t0 # load to t1 the first character in string
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

	la $a0, $t2 # print WordCount
	li $v0, 1 # service 1 is print integer
	syscall

	la $a0, NewLine # load NewLine
	li $v0, 4  # print null terminated string "\n"
	syscall


	#ADD data valiadation
	li $v0, 10 # Exit 
	syscall
