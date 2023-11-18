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
    ticks dw 0
    segundos db " SEG " ,24h
    terminaste db "Pasaron 4 segundos",0dh,0ah,24h

.code
extrn esletra:proc

teclado proc
    mov ax, @data
    mov ds, ax

inicio:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupción del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)

;Querido lector, no te das una idea cuanto tiempo pasó para darme cuenta que hacer esta pequeña operación
;LIMPIA EL MALDITO BUFFER DEL TECLADO WOOOOO
    mov al, 0FFh
    out 60h, al
    in al, 60h

    mov si, 73 ; Timeout de 4 segundos >>>> 18,2 x 4 ticks
    lea bx, palabra     ;Apunto bx a palabra para la función

    in al, 60h     ;traigo la letra
    mov rebote, al

tickref: ;tick del clock referencia
    mov ah, 00h 
    int 1ah 
    mov ticks, dx

leotimer:
    mov ah, 00h ; cx:dx
    int 1ah
    cmp ticks, dx
    je leotimer 

    dec si
    jnz sigo
    jmp imprimosegfin    ;Reinicio el loop


sigo:
 jmp esperar_tecla
esperar_tecla:
    in al, 60h     ;traigo la letra
    cmp rebote, al 
    je tickref
    mov rebote, al

llamada:
    call esletra
    ;En esta función, compara cada letra del teclado y la devuelve en DL
    ;Guarda en [bx] lo que tengo en dl, e incrementa
    cmp al, 0eH     ;Chequeo si es un backspace
    je backspace
    
    cmp al, 1ch     ;Chequeo si es un enter
    je imprimop 

    jmp tickref

backspace:              ; Borra la última tecla, y devuelve el puntero a la tecla anterior
;Borro, imprimo un espacio y lo borro. De esta manera piso el espacio.
    dec bx
    mov ah, 2
    mov dl, 08h
    int 21h
    mov ah, 2
    mov dl, 20h
    int 21h
    mov [bx], dl
    mov ah, 2
    mov dl, 08h
    int 21h
    jmp tickref 

imprimoseg: 
    mov ah,9
    mov dx, offset segundos
    int 21h
    jmp esperar_tecla

imprimosegfin:
    mov ah,9
    mov dx, offset terminaste
    int 21h


imprimop: ;Imprimo lo que tengo en palabra
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
teclado endp
end

