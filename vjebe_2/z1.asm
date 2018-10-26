%include "lib/asm_io.inc"
global asm_main
; Napisati program koji ce stringovima s1 i s2
; da na prva dva mjesta promijeni znakove.

.segment .data
    string1 db "abcde",0
    string2 db "fghij",0

.segment .bss

segment .text
    asm_main:
        enter 0,0
        pusha

        ; mov al,string1 u al adresa prvog elementa stringa
        mov al,[string1]
        mov ah,[string1 + 1]
        mov bl,[string2]
        mov bh,[string2 + 1]

        mov [string1],bl
        mov [string1 + 1],bh
        mov [string2],al
        mov [string2 + 1],ah

        mov eax, string1
        call print_string
        call print_nl

        mov eax, string2
        call print_string
        call print_ln

        popa
        mov eax,0
        leave
        ret