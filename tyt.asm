.8086
.model small
.stack 100h
.data
    ;MENÚ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    mensajePalabra db "Palabra: ", 24h
    mensajePuntos db "Puntos: ", 24h
    palabramain db 255 dup (24h), 0dh, 0ah, 24h
    puntaje db "000", 0dh, 0ah, 24h
    mensajeTiempo db "Tenes 4 segundos, empezando ya!", 0dh, 0ah, 24h
    ;VITALES - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    lectura db 255 dup (24h),0dh,0ah,24h
    rebote db 0
    tickinicial dw 0
    ticks dw 0
    puntos db 0
    ;EXTRA - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    flagseg dw 0
    espacio db 0dh,0ah,24h
    anotado db "tenes esto anotado: ",24h
    segundos db " SEG " ,24h
    terminaste db "Pasaron 4 segundos",0dh,0ah,24h
    aciertapalabra db "Sos un groso: ", 0dh,0ah,24h



.code
extrn esletra:proc
extrn reg2ascii:proc
public teclado 


teclado proc

    mov ax,1
    int 10h

    xor si, si

    mov al, cl
    lea si, puntaje
    add si, 2
    call reg2ascii

    lea si, palabramain
limpiar:
    cmp byte ptr[si], 24h
    je precargo
    cmp byte ptr[si], 0dh
    je precargo
    mov byte ptr[si], 24h
    inc si
    jmp limpiar

precargo:
 xor si,si 
    lea si, lectura
limpiar1:
    cmp byte ptr[si], 24h
    je precargo2
    cmp byte ptr[si], 0dh
    je precargo2
    mov byte ptr[si], 24h
    inc si
    jmp limpiar1
precargo2:
 xor si,si
cargo:
    cmp byte ptr[bx],24h
    je inicioprograma
    mov ah,[bx]
    mov palabramain[si], ah
    inc bx
    inc si
    jmp cargo


inicioprograma:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupciónión del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)

;Querido lector, no te das una idea cuanto tiempo investigué para hacer esta pequeña operación
;ESTO LIMPIA EL MALDITO BUFFER DEL TECLADO WOOOOO
    mov al, 0FFh
    out 60h, al
    in al, 60h
    mov rebote, al

    
menu:                   ;Imprimo el menú       
    mov ah, 9                   
    mov dx, offset mensajePuntos    
    int 21h 
    mov ah, 9                   
    mov dx, offset puntaje   
    int 21h 
    mov ah, 9                  
    mov dx, offset mensajeTiempo  
    int 21h    
    mov ah, 9                  
    mov dx, offset mensajePalabra   
    int 21h  
    mov ah, 9                  
    mov dx, offset palabramain  
    int 21h 
    mov ah, 9
    mov dx, offset espacio
    int 21h

tickref: ;tick del clock referencia 
    mov ah, 00h 
    int 1ah 
    mov tickinicial, dx 
    
    lea bx, lectura     ;Apunto bx a lectura, aquí se guardará lo que lea el teclado.

timer: ;Compara la referencia con una muestra actual, la resta. Si es mayor a 4 segundos finaliza el programa!
    mov ah, 00h 
    int 1ah
    mov ticks, dx   
    mov ax, ticks
    sub ax, tickinicial
    cmp ax, 72 ; 4 segundos en ticks a una frecuencia de 18.2 Hz
    jg imprimosegfin

;en cuanto al rebote: Las teclas tienen señales DOWN y UP, cuando apretas una tecla envias una señal DOWN
;y la misma cuando la soltas, envia una UP. El anti-rebote (para evitar que imprima como loco), guarda esa señal UP
;la cual cambia si hay una señal nueva disponible en el puerto del teclado.
esperar_tecla:
    in al, 60h       ;traigo la letra
    cmp rebote, al   ;Comparo si no hay un caracter nuevo esperando
    je timer
    mov rebote, al

llamada:
    call esletra
    ;En esta función, compara cada letra del teclado y la devuelve en DL
    ;Guarda en [bx] lo que tengo en dl, e incrementa
    cmp al, 0eH     ;Chequeo si es un backspace, si es salta para borrar 
    je backspace
    
    cmp al, 1ch     ;Chequeo si es un enter, si es salta para finalizar
    je finteclado 

    jmp timer
backspace:              ; Borra la última tecla, y devuelve el puntero a la tecla anterior
                        ;Los servicios 2 borran en pantalla, luego reemplazo con 24h el [bx] a borrar
    mov ah, 2
    mov dl, 08h
    int 21h
    mov ah, 2
    mov dl, 20h
    int 21h
    mov dl, 24h
    mov ah, 2
    mov dl, 08h
    int 21h
    mov dl, 24h
    mov [bx], dl
    cmp bx, 0
    je timer
    dec bx
    mov [bx], dl
    jmp timer 

imprimosegfin: 
    mov ah,9
    mov dx, offset espacio
    int 21h
    mov ah,9
    mov dx, offset terminaste
    int 21h
    jmp fallo
        
finteclado: ;Imprimo lo que tengo en palabra
    mov si, 0
comparo:
    mov ah, lectura[si]
    mov bh , palabramain[si]
    cmp lectura[si],24h
    je verifico 
    cmp ah, bh
    jne fallo
    inc si 
    jmp comparo
verifico:
    cmp ah, bh
    je acierto
    jmp fallo    

acierto:
    mov ah, 9
    mov dx, offset aciertapalabra
    int 21h
    xor cx, cx
    mov cl, 1
    ret

fallo:
    mov al, 0FFh
    out 60h, al
    in al, 60h
    mov rebote, al
    mov cl, 0 
    ret

terminar:
    mov ax, 1
    ret        
teclado endp
end

