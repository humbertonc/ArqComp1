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

.code
start:
  mov eax, 999
  looped:
    cmp eax, 2000
    je fim
    
    mov edx, 0
    inc eax
    
    div 11
    cmp edx, 0
    jne looped
  
  print:
    printf("%d\n", count)
    jmp looped
    
  fim:
    invoke ExitProcess, 0
end start 
