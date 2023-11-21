.8086
.model small
.stack 100h
.data
			; recibe por BX el offset y comparo con 24h para saber cuando termina y compara con 0dh
.code 
public reseteo
	reseteo proc

limpio:
	cmp [bx], 24h
	je salir
	cmp [bx], 0dh
	je salir
	mov [bx], 24h
	inc bx
	jmp limpio

salir:
	ret
	reseteo endp
end
