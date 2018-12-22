%include "asm_io.inc"
segment .data
    input_msg_1 db "Unesite duzinu niza: ", 0
    array dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    djelilac dd 2
    array_length dd 10
    space db " ", 0
segment .bss
segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha
        ; Fill array odd elements with -1
        mov ecx, [array_length]
        xor ebx, ebx
        xor edx, edx
        fill_loop:
            mov eax, [array + ebx]
            div dword[djelilac]
            cmp edx, 0
            jne cancel_odd
            jmp advance_fill_loop

            cancel_odd:
                mov [array + ebx], dword -1

        advance_fill_loop:
            add ebx, 4
            loop fill_loop

        ; Print array
        mov ecx, [array_length]
        xor ebx, ebx
        print_loop:
            mov eax, [array + ebx]
            call print_int

            mov eax, space
            call print_string

            add ebx, 4
            loop print_loop
    popa
    mov eax, 0
    leave
    ret
