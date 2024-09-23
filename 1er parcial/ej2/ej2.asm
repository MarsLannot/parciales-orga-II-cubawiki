
section .data

CONSTANTE_ROJO dd 0.299
CONSTANTE_VERDE dd 0.587
CONSTANTE_AZUL dd 0.114

;########### SECCION DE TEXTO (PROGRAMA)
section .text

global miraQueCoincidencia
miraQueCoincidencia:    ; void miraQueCoincidencia_c( uint8_t *A[rdi], uint8_t *B[rsi], uint32_t N[rdx], 
                        ;    uint8_t *laCoincidencia[rcx] ){

imul rdx, rdx
shl rdx, 2
XOR R8, R8


ciclo:
    cmp rdx, r8
    je, fin

    mov xmm0 , qword [rdi + r8]
    mov xmm1 , qword [rsi + r8]

    PCMPEQw xmm3, xmm0, xmm1





fin:
    ret

