.8086
.model small
.stack 100h
.data
    rebote db 0
    palabra db 255 dup (24h),0dh,0ah,24h

.code
extrn esletra:proc


inicio:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupción del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)
    in al, 60h          ; Leer la tecla desde el puerto 60h del teclado
    xor cx, cx
esperar_tecla:
    in al, 60h
;hago un anti-rebote
    cmp rebote, al 
    je esperar_tecla
    mov rebote, al

;    lea bx, palabra
    call esletra
    mov [bx], dl 
    inc bx  
    inc cx
 jmp esperar_tecla_enter

esperar_tecla_enter:
    in al, 60h

    cmp al, 2Ch      ;Chequeo si es un enter
    je fin_programa

    cmp al, 0EH     ;Chequeo si es un backspace
    je backspace

    cmp rebote, al 
    je esperar_tecla_enter
    mov rebote, al

;    lea bx, palabra
    call esletra
    mov [bx], dl 
    inc bx
    cmp cx, 10
    je imprimop
    inc cx
jmp esperar_tecla_enter

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
    jmp esperar_tecla_enter 


imprimop:
mov ah, 9
mov dx, offset palabra
int 21h

fin_programa:
    mov al, 0           ; Configurar AL en 0 para deshabilitar la interrupción del teclado
    out 64h, al         ; Enviar 0 al puerto 64h para deshabilitar la interrupción
    mov ax,4c00h       
    int 21h             
end inicio

