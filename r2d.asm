.8086
.model small
.stack 100h
.data
		
.code

public reg2ascii

;recibe en SI el offset apuntado al final y divide el registro que ingresa por CL por 10 para convertirlo en un numero decimal que se guarda en la variable
;para luego printear
	reg2ascii proc

	push ax
	push cx
	push dx

	mov ah, 0
	mov al, cl  ;le paso el reg a AL aca es lo mismo que poner CL
	mov dl, 10  ;
	mov cx, 3
convierto:
	div dl
	add ah, 30h
	mov [si],ah
	mov ah,0
	dec si
loop convierto	

	pop dx
	pop cx
	pop ax

	
	ret 
	reg2ascii endp
end