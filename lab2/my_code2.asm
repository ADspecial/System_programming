ORG 0x0000          ; Program start address
DATA:
    DB 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0xFF, 0xAA ; 
ORG 0x60;
S_I:
	DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90; 

MOV DPTR, #DATA     ; Указатель на массив 
MOV A, #0           ; Зануляем акк
MOV R0, #10			; Записываем число итераций
MOV R2, #0			; Зануляем регистр в котором будет хранится сумма
MOV R1, #0;
LOOP:
	MOV A, #0        ; 
    MOVC A, @A+DPTR  ; Перемещаем значение по адресу DPTR в акк
    RRC A            ; 
	ADD A, R2        ; 
	JNC NOTOVER		 ;
	INC R1			 ;
NOTOVER:
    MOV R2, A		 ;
	INC DPTR         ;
    DJNZ R0, LOOP    ;

MOV A, R1		 ;
MOV B, #0x10		;
DIV AB;
MOV R4, A;
MOV R5, B;
MOV B, #0x10;
MOV A, R2;
DIV AB;
MOV R6, A;
MOV R7, B;

MOV A, #0x0;
MOV DPTR, #S_I     ;
MOVC A, @A+DPTR  ;


SETB P0.7		 ;	
LOOP2:
	CLR P3.3	;
	CLR P3.4	;
	MOV A, R7;
	MOVC A, @A+DPTR;
	MOV P1, A	;
	MOV P1, #0FFH	;
	SETB P3.3	;
	MOV A, R6;
	MOVC A, @A+DPTR;
	MOV P1, A	;
	MOV P1, #0FFH	;
	SETB P3.4	;
	CLR P3.3	;
	MOV A, R5;
	MOVC A, @A+DPTR;
	MOV P1, A	;
	MOV P1, #0FFH	;
	SETB P3.3	;
	MOV A, R4;
	MOVC A, @A+DPTR;
	MOV P1, A	;
	MOV P1, #0FFH	;
JMP LOOP2;
END              ; End of program


	
