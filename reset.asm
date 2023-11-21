.8086
.model small
.stack 100h
.data
			; recibe por BX el offset y comparo con 24h para saber cuando termina y compara con 0dh
.code 
public reseteo
	reseteo proc

limpio:
	cmp byte ptr[di], 24h
	je salir
	cmp byte ptr[di], 0dh
	je salir
	mov byte ptr[di], 24h
	inc di
	jmp limpio
salir:
	ret
	reseteo endp
end
