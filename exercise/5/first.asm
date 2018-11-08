%include "asm_io.inc"
;
; Napisati program kojim se unosi do 9 pozitivnih jednocifrenih brojeva i 
; odredjuje koliko je od unijetih brojeva parno a koliko neparno
;
segment .data
    pocetna_poruka db 'Unesite granicu niza: ', 10, 0
    rezultat_poruka db 'Zbir svih brojeva je: ', 10, 0
%include "asm_io.inc"
;
; Napisati program kojim se unosi do 9 pozitivnih jednocifrenih brojeva i 
; odredjuje koliko je od unijetih brojeva parno a koliko neparno
;
segment .data
    pocetna_pouka db 'Unesite devet pozitivnih cijelih brojeva', 10, 0
    broj_parnih_msg db 'Broj parnih je: ', 0
    broj_neparnih_msg db 'Broj neparnih je: ', 0
segment .bss
    broj_parnih resd 1
    broj_neparnih resd 2
segment .text
    global asm_main
asm_main:
    enter 0,0
    pusha
        
        mov dword[broj_parnih], 0 ; fill in double value with 0, without dword only first byte would be filled
        mov dword[broj_neparnih], 0

        mov eax, pocetna_poruka
        call print_string
        call print_ln

        xor edx, edx ; fill in edx with 0
        mov ebx, 2   ; dividing with 2 to find out if number is odd or eaven
        mov ecx, 9

    read_loop:
        call read_int ; reading next number
        div ebx; eax / ebx -> eax is result, edx is remainder
        cmp edx, 0
        je broj_je_paran
        inc dword[broj_neparnih]
        jmp bypass
        
        broj_je_paran:
            inc dword[broj_parnih]

        bypass:
            loop read_loop

        ; Printing number of odd
        mov eax, broj_neparnih_msg
        call print_string 
        mov eax, dword[broj_neparnih]
        call print_int

        ; Printing number of eaven
        mov eax, broj_neparnih_msg
        call print_string 
        mov eax, dword[broj_neparnih]
        call print_int
    popa
    mov eax, 0
    leave
    ret