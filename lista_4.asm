.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

.data
  a SDWORD 4

.code
start:

  mov eax, a
  mov ebx, 2
  mov edx, 0
  div ebx
  cmp edx, 0
  jne impar
  printf("Numero %d e par", a)
  jmp fim

impar:
  printf("Numero %d e impar", a)
  
fim:
  invoke ExitProcess, 0

end start