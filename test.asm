.model small
.data
.code

start:
    mov ax, 00h        ; Initialize the keyboard.
    int 16h

mainloop:
    mov ah, 00h        ; Read keyboard input.
    int 16h

    mov ah, 00h
    mov bx, 0000h
    int 16h

    mov ah, 02h        ; Display the character in AL.
    int 21h