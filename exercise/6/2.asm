%include "asm_io.inc"
segment .data
    prompt1 db 'Unesite broj ', 0
    prompt2 db 'Unesite drugi broj', 0
    out1 db 'Rezultat je: ', 0
segment .bss
    input1 resd 1
    input2 resd 1
segment .text
    global asm_main
asm_main:
    enter 0,0
    pusha
        mov eax, prompt1
        call print_string

        mov ebx, input1
        call get_int
    popa
    mov eax, 0
    leave
    ret

; Podprogram get_int
; Parametri:
;   ebx - adresa dword vrijednosti u koju se smijesta integer
;
get_int:
    call read_int
    mov [ebx], eax
    ret