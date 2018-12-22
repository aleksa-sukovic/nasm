%include "../../lib/asm_io.inc"
;
; Dat je tekst koji je definisan u okviru programa. Niz se završava null string terminator-
; om. Tekst se sastoji od malih, velikih slova i interpunkcijskih znakova. Napisati program
; na asemblerskom jeziku kojim se sva mala slova u tekstu konvertuju u velika, a sva velika
; slova se konvertuju u mala. Ostale karakere ne treba menjati.
;
; Za ulaz: sOme Random STRING!.*tEsT@*#*$
; Dobijamo izlaz: SoME rANDOM string!.*TeSt@*#*$
;
segment .data
    text db 'sOme Random STRING!.*tEsT@*#*$', 0
segment .bss

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha
        xor ebx, ebx ; offset
        xor eax, eax ; current character

        transformation_loop:
            mov eax, [text + ebx]
            cmp eax, 0
            jz transformation_loop_end
                
            ; char < 'A'
            cmp al, 65
            jl advance_loop

            ; 'A' <= char <= 'Z
            cmp al, 97
            jl to_lower_case

            ; 'a' <= char <= 'z'
            cmp al, 122
            jle to_upper_case

            ; char > 'z'
            jmp advance_loop

            to_lower_case:
                add al, 32
                mov [text + ebx], al
                jmp advance_loop
            
            to_upper_case:
                sub al, 32
                mov [text + ebx], al

            advance_loop:
                inc ebx
                jmp transformation_loop

        transformation_loop_end:
            ; printing transformed string
            mov eax, text
            call print_string

    popa
    mov eax, 0
    leave
    ret