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
  a SDWORD ?
  b SDWORD 41
  ca SDWORD 51

.code
start:
  mov eax, b
  add eax, ca
  add eax, 100
  mov a, eax
  
  printf("A: %d", a)
  
  invoke ExitProcess, 0
end start 
