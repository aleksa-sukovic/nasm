%include "../../lib/asm_io.inc"

segment .data
    array_length dd 3
    input_msg db 'Enter a number: ', 10, 0
    space db ' ', 0
segment .bss
    array_space resw 10
segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

        ; Reading array from standard input
        xor ebx, ebx ; offset
        mov ecx, dword[array_length] ; counter
        input_loop:
            ; Rading next number            
            mov eax, input_msg
            call print_string
            call read_int

            ; Saving number
            mov [array_space + ebx], dword eax
            add ebx, 4

            loop input_loop

        ; Printing sorted array
        xor ebx, ebx
        mov ecx, dword[array_length]
        print_loop:
            mov eax, dword[array_space + ebx]
            call print_int

            mov eax, space
            call print_string

            add ebx, 4
            loop print_loop

    popa
    mov eax, 0
    leave
    ret