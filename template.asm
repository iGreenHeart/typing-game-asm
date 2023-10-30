.8086
.model small
.stack 100h
.data

	mensajePalabra db "Palabra: ", 24h
	mensajePuntos db "Puntos: ", 24h

	palabra db "MATE", 0dh, 0ah, 24h
	puntos db "0", 0dh, 0ah, 24h

	mensajeTiempo1 db "Tenes ", 24h
	mensajeTiempo2 db " segundos", 0dh, 0ah, 24h
	tiempo db "10", 24h

.code
	main proc
	mov ax, @data
	mov ds, ax


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




mov ax, 4c00h					;servicio para salir de DOS
	int 21h


	main endp
end