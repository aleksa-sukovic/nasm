;
; Unijeti niz od N < 10 jednocifrenih brojeva i izbaciti sve koji su neparni
;
%include "asm_io.inc"

segment .data
    poruka_1 db "Unesite 10 proizvoljnih brojeva", 10, 0
    djelilac dd 2

segment .bss
    niz resd 9

segment .text
    global asm_main
asm_main:
    enter 0,0
    pusha

        mov eax, poruka_1
        call print_string

        mov dword[djelilac], 2
        mov ebx, 0 ; indeks niza
        mov ecx, 9 ; brojac petlje

        read_loop:
            call read_int
            mov dword[niz + ebx], eax
            inc ebx
            inc ebx
        loop read_loop

        mov ecx, 9
        xor edx, edx
        xor ebx, ebx
        process_loop:
            mov eax, dword[niz + ebx]
            div dword[djelilac]
            cmp edx, 0
            jne izbaci_neparni
            jmp dumb

            izbaci_neparni:
                mov eax, 0
                mov dword[niz + ebx], eax

        dumb:
            nop
            inc ebx
            inc ebx
        loop process_loop

        mov ebx, 0
        mov ecx, 9
        print_loop:
            mov eax, dword[niz + ebx]
            inc ebx
            inc ebx

            call print_int
            call print_nl
        loop print_loop

    popa
    mov eax, 0
    leave
    ret
