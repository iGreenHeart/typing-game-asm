.8086
.model small
.stack 100h
.data
    teclaanterior db 0

.code
extrn esletra:proc


inicio:
    mov al, 1           ; Configurar AL en 1 para habilitar la interrupción del teclado
    out 64h, al         ; Enviar 1 al puerto 64h (puerto de control del teclado)
    esperar_tecla:
    in al, 60h          ; Leer la tecla desde el puerto 60h del teclado
    cmp teclaanterior, al 
    je esperar_tecla
    mov teclaanterior, al
    call esletra
    jmp esperar_tecla

fin_programa:
    mov al, 0           ; Configurar AL en 0 para deshabilitar la interrupción del teclado
    out 64h, al         ; Enviar 0 al puerto 64h para deshabilitar la interrupción
    mov ax,4c00h       
    int 21h             
end inicio

