.8086
.model small   ; pequeño
.stack 100    ; 100 bytes para stack
.data
	tick db 0
	tiempo db 0dh,0ah,24h
	terminaste db "Pasaron 4 segundos",0dh,0ah,24h
	segundos db "segundo",0dh,0ah,24h

.code
	public timer

mov ax, @data
mov ds, ax

timer proc
	mov bx, 73 ; Timeout de 4 segundos >>>> 18,2 x 4 ticks
tickref: ;tick del clock referencia
	mov ah, 00h 
	int 1ah 
	mov si, dx
leotimer:
	mov ah, 00h ; cx:dx
	int 1ah  
	cmp si, dx
	je leotimer

	cmp bx, 55
	je imprimoseg
	cmp bx, 37
	je imprimoseg
	cmp bx, 18
	je imprimoseg


sigo:
	dec bx
	jnz tickref
	jmp final

imprimoseg: 
	mov ah,9
	mov dx, offset segundos
	int 21h
	jmp sigo
final:
	mov ah,9
	mov dx, offset terminaste
	int 21h

exit:
	mov ax,4c00h
	int 21h     ;volver al DOS
timer endp
end
