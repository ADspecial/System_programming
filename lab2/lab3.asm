ORG 0H;
JMP start;
data:
    DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
	DB 7FH;
TABLE:
	DB 0xC0; 0 
	DB 0xF9; 1
	DB 0xA4; 2
	DB 0xB0; 3
	DB 0x99; 4
	DB 0x92; 5
	DB 0x82; 6
	DB 0xF8; 7
	DB 0x80; 8
	DB 0x90; 9
	DB 0x88; A
	DB 0x83; B
	DB 0xC6; C 
	DB 0xA1; D
	DB 0x86; E
	DB 0x8E; F

DECODE:
	MOV DPTR, #TABLE ;
	MOVC A, @A+DPTR ;
RET;

start:
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
	CLR C;
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

SETB P0.7		 ;	
LOOP2:
	CLR P3.3	;
	CLR P3.4	;
	MOV A, R7;
	CALL DECODE ;
	MOV P1, A	;
	MOV P1, #0FFH	;
	SETB P3.3	;
	MOV A, R6;
	CALL DECODE ;
	MOV P1, A	;
	MOV P1, #0FFH	;
	SETB P3.4	;
	CLR P3.3	;
	MOV A, R5;
	CALL DECODE ;
	MOV P1, A	;
	MOV P1, #0FFH	;
	SETB P3.3	;
	MOV A, R4;
	CALL DECODE ;
	MOV P1, A	;
	MOV P1, #0FFH	;
JMP LOOP2;

END              ; End of program


	
