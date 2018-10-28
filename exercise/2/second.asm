;
; Print that message
; Load two numbers from input, print out their difference, addition, and modulus
;

%include "lib/asm_io.asm"

segment .data
    prompt1 db "Enter a number: ",0
    prompt2 db "Enter another number: ",0
    outputmsg1 db "Unijeli ste: ",0
    outputmsg2 db " i ",0
    outputmsg3 db "Njihov zbir je: ",0
    outputsmg4 db "Njihova razlika je: ",0
    outputmsg5 db "Njihov kolicnik je: ",0
    outputmsg6 db "Ostatak pri dijeljenju je: ",0

segment .bss
    input1 resd 1 ; 1 uninitialized double word (4bytes)
    input2 resd 1 ; 1 uninitialized double word (4bytes)

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    mov eax, prompt1
    call print_string
    call read_int
    mov [input1], eax

    mov eax, prompt2
    call print_string
    call read_int
    mov [input2], eax
    call print_nl

    mov eax, [input1]
    add eax, [input2]
    mov ebx, eax

    mov eax, [outputmsg1]
    call print_string
    mov eax, [input1]
    call print_int

    mov eax, [outputmsg2]
    call print_string
    mov eax, [input2]
    call print_int

    mov eax, [outputmsg3]
    call print_string
    mov eax, ebx
    call print_int

    mov eax, [input1]
    sub eax, [input2]
    mov ebx, eax
    mov eax, [outputsmg4]
    call print_string
    mov eax, ebx
    call print_int

    mov eax, [input1]
    div eax, [input2]
    mov ebx, eax
    mov eax, [outputmsg5]
    call print_string
    mov eax, ebx
    call print_int

    mov eax, [input1]
    rem