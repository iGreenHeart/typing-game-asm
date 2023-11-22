;-----------------------------------------------------------------------
; Se debe generar el ejecutable .COM con los siguientes comandos:
; tasm int81RNG.asm
; tlink int81RNG.obj
;-----------------------------------------------------------------------
.8086
.model tiny   ; Definicion para generar un archivo .COM
.code
   org 100h   ; Definicion para generar un archivo .COM
start:
  jmp main
;------------------------------------------------------------------------
;- Part que queda residente en memoria y contine las ISR
;- de las interrupcion capturadas
;------------------------------------------------------------------------
Funcion PROC FAR
  sti
  pushf
                      ;recibir un numero por AX que es mi semilla la cual recibi al pedir la hora al sistema
  xor dx, dx
  mov cx, 90          ; seteo el rango de numeros que quiero que me devuelva
  div cx              ; ah tiene dicho numero
                      ; el cociente se guarda en AX
                      ; el resto en DX ( como 0-49 es chico, se guarda en DL)
  
  popf      
  iret
endp



; Datos usados dentro de la ISR ya que no hay DS dentro de una ISR
DespIntXX dw 0
SegIntXX  dw 0

FinResidente LABEL BYTE   ; Marca el fin de la porción a dejar residente
;------------------------------------------------------------------------
; Datos a ser usados por el Instalador
;------------------------------------------------------------------------
Cartel    DB "Programa Instalado exitosamente!!!",0dh, 0ah, '$'

main:         ; Se apuntan todos los registros de segmentos al mismo lugar CS.
  mov ax, CS
  mov DS, ax
  mov ES, ax

InstalarInt:
  mov AX, 3581h        ; Obtiene la ISR que esta instalada en la interrupcion
  int 21h    
       
  mov DespIntXX, BX    
  mov SegIntXX, ES

  mov AX, 2581h    ; Coloca la nueva ISR en el vector de interrupciones
  mov DX, Offset Funcion 
  int 21h

MostrarCartel:
  mov dx, offset Cartel
  mov ah, 9
  int 21h

DejarResidente:   
  Mov AX, (15 + offset FinResidente) ; Sumo 15 para asegurarme un párrafo más
  Shr AX, 1            
  Shr AX, 1        ; Se obtiene la cantidad de párrafos
  Shr AX, 1    ; ocupado por el código dividiendo por 16
  Shr AX, 1
  Mov DX, AX           
  Mov AX, 3100h    ; y termina sin error 0, dejando el
  Int 21h         ; programa residente
end start
