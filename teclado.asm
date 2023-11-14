.8086
.model small
.stack 100h
.data
    rebote db 0
    palabra db 255 dup (24h),0dh,0ah,24h
    flagincremento dw 0
    flagenter dw 0
    espacio db 0dh,0ah,24h
    anotado db "tenes esto anotado:",0dh,0ah,24h

.code
extrn esletra:proc

main proc
mov ax, @data
mov ds, ax

inicio:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupción del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)
    xor cx, cx
    mov ah,08h              
    int 21h
  

esperar_tecla:
    in al, 60h ; Leer la tecla desde el puerto 60h del teclado

    cmp rebote, al 
    je esperar_tecla
    mov rebote, al

    cmp al, 0eH     ;Chequeo si es un backspace
    je backspace

    lea bx, palabra
    call esletra 

    cmp al, 1ch
    je imprimop 

    je esperar_tecla
    mov [bx], dl 
    inc bx
    je imprimop


jmp esperar_tecla



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
    jmp esperar_tecla 


imprimop:
    mov ah, 9
    mov dx, offset anotado
    int 21h
    mov ah, 9
    mov dx, offset espacio
    int 21h
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

