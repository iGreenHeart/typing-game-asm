.8086
.model small
.stack 100h
.data
		
.code

public reg2ascii

;recibe en bx el offset apuntado al final
	reg2ascii proc

	push ax
	push cx
	push dx

	mov ah, 0
	mov al, cl  ;le paso el reg a AL aca es lo mismo que poner DL
	mov dl, 10
	mov cx, 3
convierto:
	div dl
	add [bx],ah
	mov ah,0
	dec bx
loop convierto	

	pop dx
	pop cx
	pop ax
	pop bp


	ret 
	reg2ascii endp
end