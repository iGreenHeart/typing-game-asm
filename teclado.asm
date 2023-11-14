.8086
.model small
.stack 100h
.data
    rebote db 0
    palabra db 255 dup (24h),0dh,0ah,24h
    flagincremento dw 0
    flagenter dw 0

.code
extrn esletra:proc

main proc
mov ax, @data
mov ds, ax

inicio:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupción del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)
    xor cx, cx

esperar_tecla:
    in al, 60h ; Leer la tecla desde el puerto 60h del teclado

    cmp rebote, al 
    je esperar_tecla
    mov rebote, al

    cmp al, 0EH     ;Chequeo si es un backspace
    je backspace

    lea bx, palabra
    xor si, si
    call esletra 

    cmp al, 1ch
    je casienter ;Entra a casi enter, se fija si el flag esta en 1, sinó vuelve

    mov flagincremento, si ;antirebote, quizas se pueda borrar?
    cmp flagincremento, 0
    je esperar_tecla
    mov [bx], dl 
    inc bx
    cmp cx, 9 ;contador, si llega a 9 termina el programa
    je imprimop
    inc cx

jmp esperar_tecla

casienter:
mov flagenter, dx
cmp flagenter,0
je esperar_tecla
jmp imprimop

backspace:              ; Borra la última tecla, y devuelve el puntero a la tecla anterior
;Borro, imprimo un espacio y lo borro. De esta manera piso el espacio.
    mov ah, 2
    mov dl, 08h
    int 21h
    mov ah, 2
    mov dl, 20h
    int 21h
    mov ah, 2
    mov dl, 08h
    int 21h
    dec bx
    dec cx
    jmp esperar_tecla 


imprimop:
    mov ah, 9
    mov dx, offset palabra
    int 21h

fin_programa:
    mov al, 0           ; Configurar AL en 0 para deshabilitar la interrupción del teclado
    out 64h, al         ; Enviar 0 al puerto 64h para deshabilitar la interrupción
    mov ax,4c00h       
    int 21h             
main endp
end

