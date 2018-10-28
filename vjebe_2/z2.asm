%include "lib/asm_io.inc"
global asm_main
; Ucitati dva broja sa konzole i izracunati  istampati zbir

.segment .data
    prompt1 db "Unesi broj: ",0
    prompt2 db "Unesi drugi broj: ",0
    outmsg1 db "Unijeli ste: ",0
    outmsg2 db " i ",0
    outmsg3 db ", njihov zbir je ",0

.segment .bss
    input1 resd 1 ; rezervicemo jednu double word vrijednost, referenca
    input2 resd 1

segment .text
    asm_main:
        enter 0,0
        pusha

        ; first number
        mov eax, prompt1
        call print_string
        call read_int
        mov [input1], eax

        ; second number
        mov eax, prompt2
        call print_string
        call read_int
        move [input2], eax

        mov eax, [input1] ; db 16 bita
        add eax, [input2]
        mov ebx, eax

        mov eax, [outmsg1]
        call print_string
        mov eax, [input1]
        call print_int   
        mov eax, [outmsg2]
        call print_string
        mov eax, [input2]
        call print_string
        mov eax, outmsg3
        call print_string
        mov eax, ebx
        call print_int  

        popa
        mov eax,0
        leave
        ret