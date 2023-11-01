.8086
.model small
.stack 100h
.data

.code

	public normalize

	normalizeRay proc
	
	cmp al, 60h		;Es mayor a "a"
	ja normalize	;Salto a normalizar (Resto 20h)

	cmp al, 7Bh		;Es menor a "z"
	jb normalize	;Salto a normalizar (Resto 20h)
	
	jmp finNormalize

normalize:

	sub al, 20h
	ret	

finNormalize:
	
	ret

	normalizeRay endp	
end