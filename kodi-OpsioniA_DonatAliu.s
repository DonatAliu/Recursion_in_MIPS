.text
#main funksioni
.globl main
lw $a3,test #Vendosim test prej memories ne a3(pasi qe do ta perdorim si argument ne funksion)
jal printFun #kercejme te ekzekutimi i funksionit printFun me jal qe ta lidhim ate me adresen e ardhshme 

j exit

#---------------Funksioni-------------------------- 
printFun: #funksioni printFun
addi $sp,$sp,-8 #rezervojme hapsiren ne stack per adresen dhe variablen qe do te ndryshoj
sw $ra,($sp) #adresa e kthimit nga kercimi i fundit per ne printFun
sw $s0,4($sp) #ruajme variablen ne stack per 4 me lart se adresa baze e sp

slti $t1,$a3,1 #e shikojme a eshte vlera e test ne a3 < 1
beq $t1,1,funcEnd #nese eshte fillojme me pop ne stack
move $s0,$a3 #kur test nuk eshte <1  e bartim a3 ne s0 (qe te ruhet ne stack me vone)
li $v0,1 #printing int
add $a0,$s0,$zero
syscall

li $v0,4 #printing string
la $a0,cout1 #e marrim string cout1 te data 
syscall
addi $a3,$a3,-1 #e zvoglojme a3 per 1 per ta perdorur si argument ne thirrjen e radhes ne funksion
jal printFun
li $v0,1 #printing int, fillojme ti printojme vlerat qe i kemi marr ne stack 
add $a0,$s0,$zero
syscall

li $v0,4 #printing string
la $a0,cout1
syscall

#funcEnd eshte poshte syscall te fundit pasi qe na nevoitet te bejme pop ne stack ende, deri sa jr na dergon ne main

funcEnd: #kur test<1 fillojme ta bejme pop stack dhe kthehemi te vendi ku eshte thirr funksioni
lw $ra,($sp)
lw $s0,4($sp)
addi $sp,$sp,8
jr $ra

exit:
li $v0,4 #printing string #printojme cout2
la $a0,cout2
syscall 
li $v0,10 #exiting program
syscall
.data 
test: .word 4
cout2:.asciiz "\n...Program finished with exit code 0"
cout1: .asciiz " "
