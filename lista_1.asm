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
    count SDWORD 1

.code
start:
    mov eax, 0
  contador:
    add eax, count
    inc count
    cmp count, 100
    jle contador

    printf("EAX: %d\n", eax)

    invoke ExitProcess, 0
end start 