.8086
.model small
.stack 100h
.data
    ;VITALES
    archivo db "datos.txt", "$"
    filehandler dw 00h,00h
    readchar db 20h
    palabra db 255 dup ("$"), 24h
    cantSlash db 0
    random db 0
    score db 000
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
    jmp inicio
reset:
    lea di, palabra
    call reseteo ;Función de reinicio
    mov cantSlash,0
    xor ax,ax
    xor bx,bx 
    xor cx,cx
    xor dx,dx
    mov word ptr [filehandler], 0
    mov readchar, 20h
    mov score, 000
    
inicio: 
    call Clearscreen ;Función de limpiado de pantalla
    lea si,palabra
    lea dx,archivo
    mov ah,3dH
    mov al,0
    int 21H
    jc openerr
    mov word ptr[filehandler], ax

    mov cx, 0

char:
    mov ah,3FH
    mov bx, word ptr [filehandler]
    mov cx,1
    lea dx,readchar
    int 21H
    jc charerr
      
    cmp ax,0
    je eof

    mov dl, readchar

    cmp dl, "/"
    je cantidadSlash
    mov cl, cantSlash
    cmp random, cl
    ja char

; je eof
sigo:
    cmp dl, "/"
    je eof

    mov [si], dl
    inc si
    jmp char
  
  
openerr:
    lea dx, filerror
    mov ah,9
    int 21h
    jmp finprograma
  
charerr:
    lea dx, charactererror
    mov ah,9
    int 21h
    jmp eof

cantidadSlash:
    mov cl, cantSlash
    cmp random, cl
    jb eof
    cmp random, cl 
    je sigo

    add cantSlash, 1
    jmp char
 
eof:  
    mov cl, score  
    lea bx, palabra

    call teclado


    mov bl, score
    add bl, cl
    mov score, bl
    cmp cl, 1
    je continuar 

    mov ah, 9
    mov dx, offset fallapalabra1
    int 21h
    mov ah, 9
    mov dx, offset fallapalabra2
    int 21h
espera:    
    in al,60h

    cmp al, 15h ;Si es una Y, reinicia el programa
    je continuar
    cmp al, 31h ;Si es una N, finaliza el programa
    je finprograma

    jmp espera

continuar:
    jmp reset

finprograma:
	mov ah,4ch
	int 21H
main endp

proc Clearscreen
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