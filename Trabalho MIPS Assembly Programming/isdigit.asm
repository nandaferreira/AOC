.data
prompt: .asciiz "Enter a character: \n "
newline: .asciiz "\n"
result: .space 2  # Space to store "1" or "0"

.text
.globl main

main:
  # Prompt user for input
  li $v0, 4
  la $a0, prompt
  syscall

  # Read character using syscall
  jal getchar

  # Check if it's a digit (0-9)
  blt $v0, '0', not_digit  # less than '0'
  bgt $v0, '9', not_digit  # greater than '9'

  # It's a digit
  li $t0, '1'
  sb $t0, result
  j print_result

not_digit:
  li $t0, '0'
  sb $t0, result

print_result:
  # Print the result using syscall
  li $v0, 4       # Código syscall para imprimir string
  la $a0, result  # Carrega o endereço da string result
  syscall

  # Exit the program
  li $v0, 10
  syscall


# getchar function using syscall
getchar:
  li $v0, 12  # Código de chamada de sistema para ler um caractere
  syscall
  jr $ra
