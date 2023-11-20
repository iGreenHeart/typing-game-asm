.8086
.model small
.stack 100h


.data

.code 

extrn timer:proc
extrn teclado:proc


	main proc

	mov ax, @data
	mov ds, ax



	call timer

	call teclado


	mov ax, 4c00h
	int 21h

	main endp

end