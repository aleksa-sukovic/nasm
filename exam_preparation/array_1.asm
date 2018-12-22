%include "asm_io.inc"

segment .data
    poruka_1 db "Unesite 9 proizvoljnih brojeva", 10, 0
    space db " ", 0
    djelilac dd 2 ; initialized double value [initialized to 2]
    multiplicative dd 4
segment .bss
    array resd 10
    result_array resd 10
    result_array_length resd 1
segment .text
    global asm_main
asm_main:
    enter 0, 0
    pusha
        mov eax, poruka_1
        call print_string

        mov ecx, 9
        mov ebx, 0
        input_loop:
            call read_int
            mov [array + ebx], eax
            add ebx, 4
            loop input_loop
        
        mov ecx, 9
        mov ebx, 0
        mov dword[result_array_length], 0
        xor edx, edx
        process_loop:
            mov eax, [array + ebx]
            div dword[djelilac]
            cmp edx, 0
            je save_element
            jmp advance_loop

            save_element:
                mov eax, dword[result_array_length]
                mul dword[multiplicative]
                mov edx, [array + ebx]
                mov dword[result_array + eax], edx

                mov edx, dword[result_array_length]
                inc edx
                mov [result_array_length], edx

            advance_loop:
                add ebx, 4
                xor edx, edx
                loop process_loop

        call print_nl
        mov ecx, dword[result_array_length]
        mov ebx, 0
        print_loop:
            mov eax, [result_array + ebx]
            call print_int
            
            mov eax, space
            call print_string
            
            add ebx, 4
            loop print_loop
    popa
    mov eax, 0
    leave
    ret
