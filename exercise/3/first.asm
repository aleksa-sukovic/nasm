%include "asm_io.inc"
segment .data
    string1 db "Hello World",0

segment .bss

segment .text
    global asm_main
asm_main:
    enter 0,0
    pusha

        mov eax, string1
        call print_string

    popa
    mov eax, 0
    leave
    ret