global templosClasicos
global cuantosTemplosClasicos

extern malloc

TAM_STRUCT_TEMPLO equ           24      
OFFSET_LARGO equ                0       ;M
OFFSET_NOMBRE equ               8
OFFSET_CORTO equ                16      ;N



;########### SECCION DE TEXTO (PROGRAMA)
section .text

templosClasicos: ; templosClasicos(templo *temploArr[rdi], size_t temploArr_len[rsi]);

	push rbp
	mov rbp, rsp        ;queda alineado a 16

    push rsi 
    push rdi 


    call cuantosTemplosClasicos     ;para tener cuan grande va a ser mi array final

    push rsi                        ;me lo guardo pa poder iterar luego 

    imul TAM_STRUCT_TEMPLO  ;por cada elem del array necesito 24 bytes
    ;estoy usando el One-operand form que multiplica por lo que deje en rax

    call malloc             ; no voy a tocar rax mas, pq tengo que devolver el puntero al nuevo array, que es lo que me devolvio rax
    
    xor rdx, rdx             ; lo voy a usar para iterar

    pop rcx                 ; estoy popeando a la long del array 
    add rcx, 1              ; asi llego al ultimo elemento
    pop rdi                 ; lo voy a usar para acceder a el otro arreglo 


ciclo1:
    cmp rcx 0 
    je  fin1
    
    mov r8b, [rdi + rdx]                    ;me quedo con cant columnas largas
    shr r8b, 2                          ;2N
    add r8b, 1                          ; 2N+1

    mov r9b, [rdi + rdx + OFFSET_CORTO]       ;me quedo con cant columans cortas

    add rdx, 1             ; necesito saber en que pos del array estoy


    cmp r8, r9
    jne ciclo1

    mov r10, [rdi + rdx + OFFSET_NOMBRE]

    mov [rcx + OFFSET_LARGO], r8
    mov [rcx + OFFSET_NOMBRE], r10
    mov [rcx + OFFSET_CORTO], r9


fin1:

    pop rsi 
    pop rbp 
    ret

cuantosTemplosClasicos: ; cuantosTemplosClasicos_c(templo *temploArr[rdi], size_t temploArr_len[rsi]){
        

    xor rax, rax

ciclo: 
    cmp rsi, 0
    je fin

    mov rdx, [rdi]                      ;me quedo con cant columnas largas
    shr rdx, 2                          ;2N
    add rdx, 1                          ; 2N+1

    mov rcx, [rdi + OFFSET_CORTO]       ;me quedo con cant columans cortas


    sub rsi, 1
    cmp rdx, rcx
    jne ciclo 

    add rdi, 24
    add rax, 1

    jmp ciclo

fin:
    ret
    


