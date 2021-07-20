# Title: Maman12 Filename: Question3
# Author: Ido Ziv Date: 20/07/2021
# Description: Question 3 - get string from user and count number of words, largest word and smallest word
# Input:
# Output:String contain 1 word or more
################# Data segment #####################
.data
	StringBuffer: .space 80 # space for user string
	GetString: .ascii "Please enter some words:"
	StringBuffer: .space 80 # space for user string
################# Code segment #####################
.text
.globl main
main: # main program entry
	la $a0, str # $a0 = address of str
	li $a1, 10 # $a1 = max string length
	li $v0, 8 # read string
	syscall
	li $v0, 8 # print str
	syscall
	li $v0,10 # exit
	syscall
li $v0, 10 # Exi
