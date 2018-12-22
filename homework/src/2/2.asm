%include "../../lib/asm_io.inc"

segment .data
    array_length dd 3
    input_msg db 'Enter a number: ', 10, 0
    space db ' ', 0
segment .bss
    array_space resw 10
    outer_loop_offset resd 1
    saved_index resd 1
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

        ; Sorting array
        xor ebx, ebx
        mov ecx, dword [array_length]
        dec ecx
        outer_sort_loop:
            mov eax, dword[array_space + ebx]      ; current element in eax
            mov [outer_loop_offset], dword ebx
            mov [saved_index], dword ecx

            add ebx, dword 4
            dec ecx
            inner_sort_loop:
                mov edx, dword[array_space + ebx] ; next element in edx
                cmp edx, eax
                jg swap_element
                jmp advance_inner_sort_loop

                swap_element:
                    mov [array_space + ebx], dword eax
                    mov ebx, dword[outer_loop_offset]
                    mov [array_space + ebx], dword edx

            advance_inner_sort_loop:
                add ebx, 4
                loop inner_sort_loop

        advance_outer_sort_loop:
            mov ecx, dword[saved_index]
            mov ebx, dword[outer_loop_offset]
            add ebx, 4
            loop outer_sort_loop

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