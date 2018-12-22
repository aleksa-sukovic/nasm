%include "../../lib/asm_io.inc"
segment .data
    prompt1 db "Unesi broj N: ",0

segment .bss
    array_space resw 10
    current_index resd 1
    current_element resd 1
    array_length resd 1

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ; loading N
    mov eax, prompt1
    call print_string
    call read_int

    mov ecx, eax ; counter in ecx
    mov ebx, 2 ; dividing with 2
    xor edx, edx
    mov dword[array_length], 0
    mov dword[current_index], 0

    read_loop:
        call read_int ; next number in eax
        div ebx
        cmp edx, 0 ; edx = next_num % 2
        je save_element ; if number is eaven, saving it
        jmp advance_read_loop

        save_element:
            mov [current_element], eax

            mov eax, [current_index]
            mov edx, 2
            mul edx ; current element offset in eax

            mov edx, [current_element]
            mov [array_space + eax], edx

            xor edx, edx
            inc dword[current_index]
            inc dword[array_length]

        advance_read_loop:
            loop read_loop

    mov ecx, [array_length]
    mov dword[current_index], 0
    print_loop:
        mov eax, [current_index]
        mov edx, 2
        mul edx ; current element offset in eax

        mov eax, [array_space + eax]
        call print_int
        
        inc dword[current_index]
        loop print_loop

    popa
    mov eax,0
    leave
    ret