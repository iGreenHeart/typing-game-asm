.8086
.model small
.stack 100h
.data

 archivo db "datos.txt", "$"
 filehandler db 00h,00h
 readchar db 20h
 filerror db "Archivo no existe o error de apertura", 0dh, 0ah, '$'
 charactererror db "Error de lectura de caracter", 0dh, 0ah, '$'
 palabra db 255 dup ("$"), 24h
 cantSlash db 0
 random db 0
.code
main proc

  mov ax,@data
  mov ds,ax
  
  call Clearscreen

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
  jmp final
  
charerr:
  lea dx, charactererror
  mov ah,9
  int 21h
  jmp final

cantidadSlash:
  mov cl, cantSlash
  cmp random, cl
  jb eof
  cmp random, cl 
  je sigo

  add cantSlash, 1
  jmp char
 
final:
eof:
  
  mov ah,9
  mov dx, offset palabra
  int 21h

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

end main