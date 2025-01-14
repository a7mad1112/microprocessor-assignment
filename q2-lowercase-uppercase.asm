.model small
.data
  S          DB "Ahmed Alawneh."
  FIRST_NAME DB 20 DUP(?)
  SNAME      DB 20 DUP(?)
  NewLine    DB 10,13,"$"
.code
  main:                 
                        MOV AX, @DATA
                        MOV DS, AX
                        MOV SI, offset S
                        MOV DI, offset FIRST_NAME
  check_character:      
                        MOV AL, [SI]               ; load current char to AL
                        CMP AL, " "                ; compare the current char with AL, if equal this means we should handle sname now
                        JE  handle_sname
                        CMP AL, "a"                ; compare current char with 'a', if the current char is smaller than 'a' this means it is uppercase and need to be converted
                        JB  convert_to_lowercase
  store_character:      
                        MOV [DI], AL               ; store current char in DI which is an offset of first name
  ; incremnt ID, SI to move for checking next char
                        INC DI
                        INC SI
                        JMP check_character
  convert_to_lowercase: 
                        ADD AL, 32D                ; the uppercase letter + 32D will convert the char to lowercase
                        JMP store_character        ; jump to store the char after convert it
  handle_sname:         
                        MOV DI, offset SNAME       ; after start handling sname, we need to make the DI points to the surname varialbe
  load_sname_char:      
                        MOV AL, [SI]               ; load s name characters from S
                        CMP AL, "."                ; if the AL is '.', this means the name is finished
                        JE  print_values
                        CMP AL, "a"                ; check if the char is small then it need to be converted
                        JAE convert_to_uppercase
                        JMP store_sname_character
  convert_to_uppercase: 
                        SUB AL, 32D                ; the lowercase letter - 32D will convert the char to uppercase
                        JMP store_sname_character
  store_sname_character:
                        MOV [DI], AL               ; store the char in the DI which is offset of SNAME
                        INC DI                     ; increment SI, DI to point to the next char
                        INC SI
                        JMP load_sname_char        ; move to lead the next char in sname
  print_values:         
                        MOV DX, OFFSET FIRST_NAME  ; Print FIRST_NAME
                        MOV AH, 9
                        INT 21H
                        MOV AH, 4CH                ; Exit program
                        INT 21H
  end main
