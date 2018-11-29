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
        mov ecx, ret
        jmp get_int
        ret:
            ; pozivanje funkcije po drugi put
            mov eax, prompt2
            call print_string
            
            mov ebx, input2
            mov ecx, $ + 7 ; tekuce mjesto u programu oznaceno sa $, sa plus prekacemo jmp instrukciju
            jpm short get_int

            mov eax, [input1]
            add eax, [input2]

            mov ebx, eax
            mov eax, out1
            call print_string
            mov eax, ebx
            call print_int
            call print_ln
    popa
    mov eax, 0
    leave
    ret

; Podprogram get_int
; Parametri:
;   ebx - adresa dword vrijednosti u koju se smijesta integer
;   ecx - adresa instrukcije na koju treba da se vrati
;
get_int:
    call read_int
    mov [ebx], eax
    jmp ecx