%include "../lib/asm_io.inc"
segment .data
    prompt1 db "Unesi broj N: ",0

segment .bss
    original_array resd 100 ; 10 * 4 bytes for array
    copy_array resd 100 ; 10 * 4 bytes for array
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
            mov edx, 4
            mul edx
            add eax, copy_array

            mov edx, [current_element]
            mov [eax], edx

            mov edx, [current_index]
            add edx, 1
            mov [current_index], edx
            xor edx, edx
            inc dword[array_length]
            jmp advance_read_loop

        advance_read_loop:
            loop read_loop

    mov ecx, [array_length]
    print_loop:
        mov eax, ecx
        mov edx, 4
        mul edx
        add eax, copy_array
        mov edx, eax
        mov eax, [edx]
        call print_int
        loop print_loop

    popa
    mov eax,0
    leave
    ret