%include "../../lib/asm_io.inc"

segment .data
    text db 'sOme Random string', 0
segment .bss

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha
        xor ebx, ebx ; offset
        xor eax, eax

        transformation_loop:
            mov eax, [text + ebx]
            cmp eax, 0
            jz transformation_loop_end
                call print_char
                inc ebx
                jmp transformation_loop

        transformation_loop_end:

    popa
    mov eax, 0
    leave
    ret