.8086
.model small
.stack 100h
.data
    teclaanterior db 0
    esenter db "ENTER",0dh,0ah,24h

.code
public esletra
esletra proc

    
mov teclaanterior, al
;Uso SI para antirebote? quizas se pueda borrar

chekenter:
    cmp teclaanterior, 1ch
    jne LetraesA
    mov ah, 9
    mov dx, offset esenter
    int 21h
    ret

LetraesA:
;Es A?
    cmp teclaanterior, 1Eh
    jne LetraesB
    mov ah, 2
    mov dl, 41h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesB:
    cmp teclaanterior, 30h
    jne LetraesC
    mov ah, 2
    mov dl, 42h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesC:
    cmp teclaanterior, 2Eh
    jne LetraesD
    mov ah, 2
    mov dl, 43h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesD:
    cmp teclaanterior, 20h
    jne LetraesE
    mov ah, 2
    mov dl, 44h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesE:
    cmp teclaanterior, 12H
    jne LetraesF
    mov ah, 2
    mov dl, 45h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesF:
    cmp teclaanterior, 21h
    jne LetraesG
    mov ah, 2
    mov dl, 46h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesG:
    cmp teclaanterior, 22h
    jne LetraesH
    mov ah, 2
    mov dl, 47h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesH:
    cmp teclaanterior, 23H
    jne LetraesI
    mov ah, 2
    mov dl, 48h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesI:
    cmp teclaanterior, 17H
    jne LetraesJ
    mov ah, 2
    mov dl, 49h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesJ:
    cmp teclaanterior, 24h
    jne LetraesK
    mov ah, 2
    mov dl, 4Ah
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesK:
    cmp teclaanterior, 25h
    jne LetraesL
    mov ah, 2
    mov dl, 4Bh
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesL:
    cmp teclaanterior, 26h
    jne LetraesM
    mov ah, 2
    mov dl, 4Ch
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesM:
    cmp teclaanterior, 32h
    jne LetraesN
    mov ah, 2
    mov dl, 4Dh
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesN:
    cmp teclaanterior, 31h
    jne LetraesO
    mov ah, 2
    mov dl, 4Eh
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesO:
    cmp teclaanterior, 18h
    jne LetraesP
    mov ah, 2
    mov dl, 4Fh
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesP:
    cmp teclaanterior, 19h
    jne LetraesQ
    mov ah, 2
    mov dl, 50h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesQ:
    cmp teclaanterior, 10h
    jne LetraesR
    mov ah, 2
    mov dl, 51h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesR:
    cmp teclaanterior, 13h
    jne LetraesS
    mov ah, 2
    mov dl, 52h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesS:
    cmp teclaanterior, 1Fh
    jne LetraesT
    mov ah, 2
    mov dl, 53h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesT:
    cmp teclaanterior, 14h
    jne LetraesU
    mov ah, 2
    mov dl, 54h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesU:
    cmp teclaanterior, 16h
    jne LetraesV
    mov ah, 2
    mov dl, 55h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesV:
    cmp teclaanterior, 2Fh
    jne LetraesW
    mov ah, 2
    mov dl, 56h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesW:
    cmp teclaanterior, 11h
    jne LetraesX
    mov ah, 2
    mov dl, 57h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesX:
    cmp teclaanterior, 2Dh
    jne LetraesY
    mov ah, 2
    mov dl, 58h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesY:
    cmp teclaanterior, 15h
    jne LetraesZ
    mov ah, 2
    mov dl, 59h
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno
LetraesZ:
    cmp teclaanterior, 2Ch
    jne sigo
    mov ah, 2
    mov dl, 5Ah
    int 21h
    mov [bx], dl
    inc bx
    jmp retorno


sigo:

ret
retorno: 
ret
esletra endp
end