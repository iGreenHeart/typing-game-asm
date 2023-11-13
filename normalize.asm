.8086
.model small
.stack 100h
.data

.code

public normalizeRay

	normalizeRay proc

recorroNorm:	
	cmp al, 60h		;Es mayor a "a"
	ja casiMinus	;Salto a normalizar (Resto 20h)
	jmp finNormalize

casiMinus:
	cmp al, 7Bh		;Es menor a "z"
	jb normalize	;Salto a normalizar (Resto 20h)
	jmp finNormalize

normalize:

	sub al, 20h

finNormalize:

	ret

	normalizeRay endp	
end