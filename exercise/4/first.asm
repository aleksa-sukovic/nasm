%include "asm_io.inc"
;
; Sabrati prvih N brojeva i rezultat prikazati odgovarajucim tekstom.
;
segment .data
    pocetna_poruka db 'Unesite granicu niza: ', 10, 0
    rezultat_poruka db 'Zbir svih brojeva je: ', 10, 0
segment .bss
    ukupan_broj resd 1
segment .text
    global asm_main
asm_main:
    enter 0,0
    pusha

    mov eax, pocetna_poruka
    call print_string ; stampa pocetne poruke

    xor ecx, ecx ; postavi ecx 0
    mov dword[ukupan_broj], 0 ; popuni cijeli double word sa nulama
    call read_int ; u eax se nalazi unijeto N
    mov ecx, eax

    for:
        add dword[ukupan_broj], ecx ; ukupna_vrijednost += trenutni broj
        loop for

        mov eax rezultat_poruka
        call print_string
        mov eax, [ukupan_broj]
        call print_int
        call print_nl
        
    popa
    mov eax, 0
    leave
    ret