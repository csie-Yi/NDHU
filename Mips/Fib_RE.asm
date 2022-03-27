# int F(int i)
# {
#     if (i <= 1)
#         return i;
#     return F(i - 1) + F(i - 2);
# }
# int main()
# {
#     int n;
#     cin >> n;
#     for (int i = 0; i <= n; i++)
#         cout << F(i) << ' ';
# }
        .data
SPACE:  .asciiz " "
str:	.asciiz "\nPlease Enter Fibonacci sequence F(n) with n . \nn = "
	.globl main
        .text
main:	jal Print_Scan                  # Read
	move $s6 , $v0                  # save input to s6
    	li $a0 , 0                      # set i = 0
LOOP:	
        bgt $a0 , $s6 , Exit            # if i > input EXIT
    	jal fib                         # else jump to fib
	jal Print                       # Print return val
    	addi $a0 , $a0 , 1              # i++
	    jal LOOP
fib:
    	bgt $a0 , 1 , fib_RE            # if n > 1 jump to recursive function
	move $v0 , $a0                  # else return n
    	jr $ra

fib_RE:
    
        subi    $sp,$sp,12              
        sw      $ra,4($sp)
        sw      $a0,8($sp)

        subi    $a0,$a0,1               # call fib(n-1)
        jal     fib                     # recursive
        sw      $v0,0($sp)              # save result in v0

        subi    $a0,$a0,1               # call for fibo(n-2)
        jal     fib                     # recursive

        lw      $t0,0($sp)              # restore fibo(n-1) to (t0)
        add     $v0,$t0,$v0             # result is: fibo(n-1) + fibo(n-2)


        lw      $ra,4($sp)              # recover data and stack
        lw      $a0,8($sp)
        addi    $sp,$sp,12

        jr      $ra
Print:  
    	addi $sp , $sp , -8             # save cur register
        sw  $a0 , 0($sp)        
        sw $v0 , 4($sp)
        add $a0 , $zero , $v0
        li $v0 , 1                      # print number
        syscall
        la  $a0 , SPACE                 # print blank
        li $v0 ,4
        syscall
        lw $a0 , 0($sp)                 # recover odd data
        lw $v0 , 4($sp)
        addi $sp ,$sp ,8                # recover stack
        jr $ra
Exit: 
        li $v0 , 10
        syscall
Print_Scan:
	    li $v0 , 4
    	la $a0 , str		            #reminder
	    syscall			    
    	li $v0 , 5	            	    # read num
        syscall	
	    jr $ra
