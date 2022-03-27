#void Fibonacci(int j)
#{
#   int F_0 = 0 , F_1 = 1 , ans = 0;
#   if ( j == 0 ) cout << ans ; return ; 
#   cout <<  '0 '  << '1 ';
#   for( int i = 2 ;  i < j ; i ++)
#   {
#       ans = F_0 + F_1 ;
#       cout << ans << ' ' ;
#       F_0 = F_1 ; F_1 = ans;   
#   }
#   return
#}
        .data
SPACE:  .asciiz " "
str:	.asciiz "\nPlease Enter Fibonacci sequence F(n) with n . \nn = "
	.globl main
        .text
main:   
        jal Print_Scan
        move $s1 $v0                        # save input to $s1
        li $a0 , 0	                        # ans = 0
        li $s2 , 0                          # F[0] = 0
        li $s3 , 1                          # F[1] = 1
        beq $v0 ,$zero ,zero                # if(j == 0) cout << '0'; EXIT
        jal Print                           # cout << '0 ' ;
        li $s4 , 0                          # counter i = 0 
        add $a0 , $s2 , $s3	                # a0 = F[1] 
fib:            
        jal Print                           # cout 
        add $a0 , $s2 , $s3	                # F[n] = F[n-1] + F[n-2]
        add $s2 , $zero , $s3	            # F[n-1] = F[n-2]
        add $s3 , $zero , $a0               # F[n-2] = F[n]
        addi $s4 , $s4 , 1                  # i ++
        bne $s4 , $s1 , fib                 # j == i Exit
        jal Exit

zero:	jal Print
	    jal Exit

Print:  
        li $v0 , 1                          # print number
        syscall
        addi $sp , $sp , -4
        sw  $a0 , 0($sp)                    # print space
        la  $a0 , SPACE 
        li $v0 ,4
        syscall
        lw $a0 , 0($sp)
        addi $sp ,$sp ,4
        jr $ra
Exit: 
        li $v0 , 10
        syscall
Print_Scan:
	    li $v0 , 4
    	la $a0 , str		                #reminder
	    syscall			    
    	li $v0 , 5	            	        # read num
        syscall	
	    jr $ra