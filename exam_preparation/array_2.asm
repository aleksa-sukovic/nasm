%include "asm_io.inc"
segment .data
    input_msg_1 db "Unesite duzinu niza: ", 0
    djelilac dd 2
segment .bss
    array_space resd 100
    array_length resd 1
segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha
        ; Loading N
        push dword input_msg_1
        push dword array_length
        call load_array_length
        add esp, 8

        ; Fill array with zeros
        mov ecx, [array_length]
        xor ebx, ebx
        xor edx, edx
        fill_loop:
            mov eax, dword[array + ebx]
            div dword[djelilac]
            cmp edx, 0
            jne cancel_odd
            jmp advance_fill_loop

        cancel_odd:
            mov [array_space + ebx], 0
        advance_fill_loop:
            add ebx, 4
            loop fill_loop

        mov eax, dword[array_length]
        call print_int
    popa
    mov eax, 0
    leave
    ret

load_array_length:
    push ebp
    mov ebp, esp
        mov eax, [ebp + 12]
        call print_string

        call read_int
        mov ebx, [ebp + 8]
        mov dword[ebx], dword eax
    mov esp, ebp
    pop ebp
    ret