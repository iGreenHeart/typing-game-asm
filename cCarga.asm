.8086
.model small
.stack 100h

.data


.code

public cajaCarga

extrn normalizeRay:proc	

	proc cajaCarga

	push ax
	mov ah, 1
	int 21h
	cmp al, 0dh
	je finCarga
	;call normalizeRay
	mov [bx], al
	inc bx

	jmp cajaCarga

finCarga:	

	pop ax
	ret

	endp cajaCarga

end