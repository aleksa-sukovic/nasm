%include "../../lib/asm_io.inc"

;
; Prikazati naziv dana u zavisnosti od pritisnutog tastera od 1 do 7. 
; (Primjer: ako korisnik pritisne 1 prikazuje se “ponedeljak”)
;

segment .data
    monday_msg db 'Ponedeljak', 10, 0
    tuesday_msg db 'Utorak', 10, 0
    wednesday_msg db 'Srijeda', 10, 0
    thursday_msg db 'Cetvrtak', 10, 0
    friday_msg db 'Petak', 10, 0
    saturday_msg db 'Subota', 10, 0
    sunday_msg db 'Nedelja', 10, 0
segment .bss

segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha
        call read_int ; input is in eax
        
        cmp eax, 1
        je monday
        cmp eax, 2
        je tuesday
        cmp eax, 3
        je wednesday
        cmp eax, 4
        je thursday
        cmp eax, 5
        je friday
        cmp eax, 6
        je saturday
        cmp eax, 7
        je sunday

        monday:
            mov eax, monday_msg
            jmp finish
        tuesday:
            mov eax, tuesday_msg
            jmp finish
        wednesday:
            mov eax, wednesday_msg
            jmp finish
        thursday:
            mov eax, thursday_msg
            jmp finish
        friday:
            mov eax, friday_msg
            jmp finish
        saturday:
            mov eax, saturday_msg
            jmp finish
        sunday:
            mov eax, sunday_msg
    
    finish:
        call print_string

    popa
    mov eax, 0
    leave
    ret