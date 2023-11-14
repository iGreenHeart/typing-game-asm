.8086
.model small
.stack 100h
.data
    teclaanterior db 0

.code
public esletra
esletra proc

mov teclaanterior, al

LetraesA:
;Es A?
    cmp teclaanterior, 1Eh
    jne LetraesB
    mov ah, 2
    mov dl, 41h
    int 21h
    ret
LetraesB:
    cmp teclaanterior, 30h
    jne LetraesC
    mov ah, 2
    mov dl, 42h
    int 21h
    ret
LetraesC:
    cmp teclaanterior, 2Eh
    jne LetraesD
    mov ah, 2
    mov dl, 43h
    int 21h
    ret
LetraesD:
    cmp teclaanterior, 20h
    jne LetraesE
    mov ah, 2
    mov dl, 44h
    int 21h
    ret
LetraesE:
    cmp teclaanterior, 12H
    jne LetraesF
    mov ah, 2
    mov dl, 45h
    int 21h
    ret
LetraesF:
    cmp teclaanterior, 21h
    jne LetraesG
    mov ah, 2
    mov dl, 46h
    int 21h
    ret
LetraesG:
    cmp teclaanterior, 22h
    jne LetraesH
    mov ah, 2
    mov dl, 47h
    int 21h
    ret
LetraesH:
    cmp teclaanterior, 23H
    jne LetraesI
    mov ah, 2
    mov dl, 48h
    int 21h
    ret
LetraesI:
    cmp teclaanterior, 17H
    jne LetraesJ
    mov ah, 2
    mov dl, 49h
    int 21h
    ret
LetraesJ:
    cmp teclaanterior, 24h
    jne LetraesK
    mov ah, 2
    mov dl, 4Ah
    int 21h
    ret
LetraesK:
    cmp teclaanterior, 25h
    jne LetraesL
    mov ah, 2
    mov dl, 4Bh
    int 21h
    ret
LetraesL:
    cmp teclaanterior, 26h
    jne LetraesM
    mov ah, 2
    mov dl, 4Ch
    int 21h
    ret
LetraesM:
    cmp teclaanterior, 32h
    jne LetraesN
    mov ah, 2
    mov dl, 4Dh
    int 21h
    ret
LetraesN:
    cmp teclaanterior, 31h
    jne LetraesO
    mov ah, 2
    mov dl, 4Eh
    int 21h
    ret
LetraesO:
    cmp teclaanterior, 18h
    jne LetraesP
    mov ah, 2
    mov dl, 4Fh
    int 21h
    ret
LetraesP:
    cmp teclaanterior, 19h
    jne LetraesQ
    mov ah, 2
    mov dl, 50h
    int 21h
    ret
LetraesQ:
    cmp teclaanterior, 10h
    jne LetraesR
    mov ah, 2
    mov dl, 51h
    int 21h
    ret
LetraesR:
    cmp teclaanterior, 13h
    jne LetraesS
    mov ah, 2
    mov dl, 52h
    int 21h
    ret
LetraesS:
    cmp teclaanterior, 1Fh
    jne LetraesT
    mov ah, 2
    mov dl, 53h
    int 21h
    ret
LetraesT:
    cmp teclaanterior, 14h
    jne LetraesU
    mov ah, 2
    mov dl, 54h
    int 21h
    ret
LetraesU:
    cmp teclaanterior, 16h
    jne LetraesV
    mov ah, 2
    mov dl, 55h
    int 21h
    ret
LetraesV:
    cmp teclaanterior, 2Fh
    jne LetraesW
    mov ah, 2
    mov dl, 56h
    int 21h
    ret
LetraesW:
    cmp teclaanterior, 11h
    jne LetraesX
    mov ah, 2
    mov dl, 57h
    int 21h
    ret
LetraesX:
    cmp teclaanterior, 2Dh
    jne LetraesY
    mov ah, 2
    mov dl, 58h
    int 21h
    ret
LetraesY:
    cmp teclaanterior, 15h
    jne LetraesZ
    mov ah, 2
    mov dl, 59h
    int 21h
    ret
LetraesZ:
    cmp teclaanterior, 2Ch
    jne sigo
    mov ah, 2
    mov dl, 5Ah
    int 21h
    ret
sigo:
ret
esletra endp
end