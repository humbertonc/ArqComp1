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
  a SDWORD 5
  b SDWORD 1

.code
start:

  mov eax, b
  cmp a, eax
  jl second
  printf("A: %d", a)
  jmp fim

 second:
  printf("B: %d", b)   

 fim:
    invoke ExitProcess, 0

end start 