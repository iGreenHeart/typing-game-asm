.8086
.model small
.data
    teclaanterior db 0
.code

inicio:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupción del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)
    esperar_tecla:
    in al, 60h          ; Leer la tecla desde el puerto 60h del teclado
    cmp teclaanterior, al 
    je esperar_tecla
    mov teclaanterior, al
; Imprime la tecla en pantalla
    mov ah, 0eh
    int 10h           
    jmp inicio           ; Volver a leer la siguiente tecla

fin_programa:
    mov al, 0           ; Configurar AL en 0 para deshabilitar la interrupción del teclado
    out 64h, al         ; Enviar 0 al puerto 64h para deshabilitar la interrupción
    mov ax,4c00h       
    int 21h             
end inicio