.model small  
.data
  A             DB 98, 77, 46, 87, 78, 91, 79, 22, 75, 69, 41, 82  ; define array A
  EVEN_MAX      DB 0                                               ; define a variable refrence memory to store the value of max even
  ODD_MIN       DB 0                                               ; define a variable refrence memory to store the value of min odd
  SIZE_OF_ARRAY DW 12                                              ; store # of numbers to use later
  NewLine       DB 10,13,"$"
.code
  main:         
                MOV  AX,@DATA
                MOV  DS,AX
  ; at first I will suggest that the first number is the target, then I will check all
                MOV  AL, [A]             ; store the first number in AL register
  ; store the first number in my variables:
                MOV  EVEN_MAX, AL
                MOV  ODD_MIN, AL
                MOV  SI, 1               ; I will start indexing from 1(not 0 because I already stored the value of zero index)
  check_numbers:
                MOV  AL, [A + SI]        ; store the current element in the AL register
                TEST AL, 1               ; check if the number is even(LSB bit is 0), if the number is even then ZF will be 1
                JZ   check_even          ; if ZF equal to 1, this is even number
                JMP  check_odd           ; if the number is not even then it is odd (if the execution reach this line this means the value of ZF = 0)
  check_even:   
                MOV  BL, EVEN_MAX        ; store current max in BL
                CMP  BL, AL
                JGE  check_next          ; if the number stored in AL samller than the number stored in BL, then go to check the next number
  ; if the execution reach this line this means that the value in AL is greater than current max and it is even, so we should update the current max
                MOV  EVEN_MAX, AL        ; store new max value
  check_odd:    
                MOV  BL, ODD_MIN         ; store current min in BL
                CMP  AL, BL              ; compare current min value with AL
                JGE  check_next          ; if the number stored in AL greater than the number stored in BL, then go to check the next number
  ; if the execution reach this line this means that the value in AL is samller than current min and it is odd, so we should update the current min
                MOV  ODD_MIN, AL         ; store new min value
                INC  SI                  ; Increment SI to point to the next element
                JMP  check_numbers       ; Repeat the loop
  check_next:   
                INC  SI                  ; increment the indexes by one
                CMP  SI, SIZE_OF_ARRAY
                JGE  print_values        ; if the index SI is equal or greater than size of the array then go to print values
                JMP  check_numbers       ; if the index is smaller than the size then check the rest of numbers
  print_values:                          ; for testing
  ; print max even number
                MOV  AX,0
                MOV  BX,0
                MOV  BL,10
                MOV  AL,EVEN_MAX
                MOV  CL,0
  ev1:          
                DIV  BL
                PUSH AX
                INC  CL
                MOV  AH,0
                CMP  AL,0
                JNZ  ev1
  ev2:          
                POP  AX
                MOV  DL, AH
                ADD  DL, 30h
                MOV  AH, 2
                INT  21h
                DEC  CL
                CMP  CL, 0
                JNZ  ev2
                MOV  DX, offset NewLine
                MOV  AH, 9
                INT  21h
  ; print min odd number
                MOV  AX,0
                MOV  BX,0
                MOV  BL,10
                MOV  AL,ODD_MIN
                MOV  CL,0
  odd1:         
                DIV  BL
                PUSH AX
                INC  CL
                MOV  AH,0
                CMP  AL,0
                JNZ  odd1
  odd2:         
                POP  AX
                MOV  DL, AH
                ADD  DL, 30h
                MOV  AH, 2
                INT  21h
                DEC  CL
                CMP  CL, 0
                JNZ  odd2
  ; end program
                MOV  AH, 4ch
                INT  21h
end main
