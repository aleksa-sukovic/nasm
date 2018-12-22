%include "asm_io.inc"

segment .data
    input1 db "Argument 1 message!", 10, 0
    input2 db "Argument 2 message!", 10, 0
segment .bss
    number resd 1
segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha
        push dword number
        call function
        add esp, 4

        mov eax, [number]
        call print_int
    popa
    mov eax, 0
    leave
    ret

function:
    push ebp
    mov ebp, esp

    call read_int
    mov ebx, dword[ebp + 8]
    mov [ebx], eax

    mov esp, ebp
    pop ebp
    ret