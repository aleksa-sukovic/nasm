%include "../../lib/asm_io.inc"
;
; Napisati program kojim se unosi do devet pozitivnih jednocifrenih brojeva i odredjuje
; se koliko je od unijetih brojeva parno, a koliko neparno
; Prikazati odgovarajuce poruke.
;
segment .data
    input_msg db 'Enter 9 numbers', 10, 0
    eaven_output_msg db 'Broj parnih: ', 0
    odd_output_msg db 'Broj neparnih: ', 0
segment .bss
    odd_number_count resd 1
    eaven_number_count resd 1
segment .text
    global asm_main
asm_main:
    enter 0,0
    pusha
        
        ; initializing counters to 0
        mov dword[odd_number_count], 0
        mov dword[eaven_number_count], 0

        ; input message
        mov eax, input_msg
        call print_string

        ; initializing loop variables
        xor edx, edx ; fill edx with all 0s
        mov ecx, 9   ; counter
        mov ebx, 2   ; keeping 2 [with who we are dividing] in ebx register

        input_loop:
            call read_int ; next number is in eax
            div ebx       ; eax = eax / ebx && edx = eax % ebx
            cmp edx, 0
            je eaven_number ; branch if number is eaven
                inc dword[odd_number_count] ; number is odd
            jmp advance_loop

            eaven_number:
                inc dword[eaven_number_count]

            advance_loop:
                loop input_loop
        
        ; printing odd numbers
        mov eax, odd_output_msg
        call print_string
        mov eax, dword[odd_number_count]
        call print_int
        call print_nl

        ; printing eaven numbers
        mov eax, eaven_output_msg
        call print_string
        mov eax, dword[eaven_number_count]
        call print_int
        call print_nl
    popa
    mov eax, 0
    leave
    ret