.8086
.model small
.stack 100h
.data
    ;VITALES
    archivo db "datos.txt", "$"
    filehandler dw 00h,00h
    readchar db 20h
    semilla dw 0
    palabra db 255 dup ("$"), 24h
    cantSlash db 0
    random db 0
    score db 000
    verifico dw 0
    ;MENSAJES
    filerror db "Archivo no existe o error de apertura", 0dh, 0ah, '$'
    charactererror db "Error de lectura de caracter", 0dh, 0ah, '$'
    fallapalabra1 db "GAME OVER, REINTENTAR?",0dh,0ah,24h
    fallapalabra2 db "Y/N?",0dh,0ah,24h
.code
extrn teclado:proc
extrn reseteo:proc

main proc

    mov ax,@data
    mov ds,ax

    mov ax,1
    int 10h

    mov ah, 2Ch
    int 21h
    add dh, ch  ; Combina CH y DH para obtener un valor más único
    mov semilla, dx

    ; Llama a la interrupción personalizada y actualiza la semilla
    mov ax, semilla
    int 81h
    mov semilla, ax  ; al tiene un valor
    mov random, dl

    jmp inicio

reset:                      ;reseteo todo  

    lea di, palabra
    call reseteo            ;limpia la variable palabra
    mov cantSlash,0

 mov ah, 2Ch
    int 21h
    add dh, ch              ; Combina CH y DH para obtener un valor más único
    mov semilla, dx

    ; Llama a la interrupción personalizada y actualiza la semilla
    mov ax, semilla
    int 81h
    mov semilla, ax         ; al tiene un valor
    mov random, dl

    xor ax,ax
    xor bx,bx 
    xor cx,cx
    xor dx,dx
    mov word ptr [filehandler], 0
    mov readchar, 20h    
    
inicio: 
    call Clearscreen        ;Función de limpiado de pantalla
    lea si,palabra
    lea dx,archivo
    mov ah,3dH              ; abrir el archivo
    mov al,0                ;abrirlo en modo lectura
    int 21H  
    ;jc openerr               ;si hay carry significa que abrio mal
    mov word ptr[filehandler], ax  ;almacenar el descriptor de archivo

    mov cx, 0

char:
    mov ah,3FH              ;leer del archivo
    mov bx, word ptr [filehandler]  ;le pasamos el descriptor previamente almacenado
    mov cx,1                ;le indicamos que leemos un byte sin mas
    lea dx,readchar         ;aca le pasamos dx el caracter leido
    int 21H
    jc charerr              ;salta aca si hubo algun error del carcter leido
      
    cmp ax,0                ;ver si termino el archivo
    je eof

    mov dl, readchar        ;mov dl el caracter leido

    cmp dl, "/"             ;comparamos con /
    je cantidadSlash        ;si encontro un / entra 
    cmp dl, 40h
    ja casiletra
    jmp char
casiletra:
    cmp dl, 5bh
    jb esletra
    jmp char
esletra:
    mov cl, cantSlash       ;mueve a cl la cantidad de / q hubo porque asi nos aseguramos que escriba solo la palabra en funcion a las / que le dijimos
    cmp random, cl          ;compara con el random para saber si tiene que escribir la palabra o todavia no
    ja char

; je eof
sigo:
    cmp dl, "/"             ;compara con un / porque significa que es el / que esta al final de la palabra pedida
    je eof                  ;salta al final

    mov [si], dl            ;movemos a la variable el caracter leido
    inc si
    jmp char                ;volemos a leer el siguiente caracter
  
  
openerr:                    ;imprime un cartel que indica que el archivo se abrio mal
    lea dx, filerror
    mov ah,9
    int 21h
    jmp finprograma
  
charerr:                    ;imprime un cartel que indica que se leyo mal un caracter
    lea dx, charactererror
    mov ah,9
    int 21h
    jmp eof

cantidadSlash:              ;esta funcion es la que entra cuando detecta un / para saber si ya esta en condicion de escribir la palabra
    mov cl, cantSlash       ;muevo la cant de / a cl
    cmp random, cl          ;veo que la cantidad de / sea la misma que el random indicando que esta sobre la palabra indicada
    je sigo

    add cantSlash, 1        ;aumenta la cant de / en 1 
    jmp char
 
eof:
    mov ah, 3Eh
    int 21h  
    mov cl, score           ;movemos el score guardado en cl
    lea bx, palabra         ;movemos el offset de palabra
    call teclado            ;llamamos a teclado donde se haran todas las comparaciones
     mov ax,1
    int 10h
 
 
    mov bl, score           ;move a bl el score que teniamos
    add bl, cl              ;le agregamos el score nuevo
    mov score, bl           ;lo guardamos en la variable
    cmp cl, 1               ;ve si cl tiene un 1 o no porque CL trae un 1 de la funcion si la persona escribio bien la palabra
    je continuar 
                            ;si Cl no es un 1, imprime los carteles para saber si queres seguir jugando o no
    mov score, 0
    mov ah, 9
    mov dx, offset fallapalabra1 
    int 21h
    mov ah, 9
    mov dx, offset fallapalabra2
    int 21h
espera:                     ;lee del teclado la opcion del usuario para continuar o salir
    in al,60h

    cmp al, 15h ;Si es una Y, reinicia el programa
    je continuar
    cmp al, 31h ;Si es una N, finaliza el programa
    je finprograma

    jmp espera

continuar:
    jmp reset

finprograma:                ;fin del programa
    mov ax,2
    int 10h
    mov ah,4ch 
    int 21H
main endp

proc Clearscreen           ;no se limpia xd
    push ax
    push es
    push cx
    push di
    mov ax,3
    int 10h
    mov ax,0b800h
    mov es,ax
    mov cx,1000
    mov ax,7
    mov di,ax
    cld
    rep stosw
    pop di
    pop cx
    pop es
    pop ax
    ret

Clearscreen endp

end
