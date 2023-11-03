.8086
.model small
.stack 100h
.data

	mensajePalabra db "Palabra: ", 24h
	mensajePuntos db "Puntos: ", 24h

	palabra db "MATE", 0dh, 0ah, 24h
	puntos db "0", 0dh, 0ah, 24h
	input db 255 dup (24h), 0dh, 0ah,24h
	mensajeTiempo1 db "Tenes ", 24h
	mensajeTiempo2 db " segundos", 0dh, 0ah, 24h
	mensajeperdiste db "Malo de mierda", 0dh, 0ah, 24h
	mensajewin db "Sos una maquina", 0dh, 0ah, 24h
	tiempo db "10", 24h

.code
	main proc
	mov ax, @data
	mov ds, ax

	

template:
	mov ah, 9					;servicio 9, print dx
	mov dx, offset mensajePalabra	
	int 21h				

	mov ah, 9					;servicio 9, print dx
	mov dx, offset palabra	
	int 21h	

	mov ah, 9					;servicio 9, print dx
	mov dx, offset mensajePuntos	
	int 21h	

	mov ah, 9					;servicio 9, print dx
	mov dx, offset puntos	
	int 21h	

	mov ah, 9					;servicio 9, print dx
	mov dx, offset mensajeTiempo1	
	int 21h	

	mov ah, 9					;servicio 9, print dx
	mov dx, offset tiempo	
	int 21h	

	mov ah, 9					;servicio 9, print dx
	mov dx, offset mensajeTiempo2	
	int 21h	

	mov bx, 0
	mov si, 0

carga:
	mov ah,1
	int 21h
	cmp al, 0dh
	je fincarga
	mov input[bx], al 
	inc bx
	jmp carga

fincarga:
	mov bx, 0
	mov si, 0
comparacion:
	mov dl, palabra[si]
	mov ah, input[bx]

    cmp dl,0dh
	je win

	cmp ah, dl
	jne gameover
	

	inc bx
	inc si 
	jmp comparacion



gameover:
	mov ah,9
	mov dx, offset mensajeperdiste
	int 21h


	jmp fin

win:

	mov ah,9
	mov dx, offset mensajewin
	int 21h
	
	jmp fin

fin:
	mov ax, 4c00h					;servicio para salir de DOS
	int 21h


	main endp
end