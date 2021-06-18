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
  qtdDiscos SDWORD 6
  
.code
TorredeHanoi:

  push ebp
  mov ebp, esp
  
  cmp DWORD PTR [ebp+20], 1
  je igualum

  mov eax, [ebp+20]
  sub eax, 1
  push eax
  mov eax, DWORD PTR [ebp+16]
  push eax
  mov eax, DWORD PTR [ebp+8]
  push eax
  mov eax, DWORD PTR [ebp+12]
  push eax
  call TorredeHanoi

  printf("[%d, %d]\n", DWORD PTR [ebp+16], DWORD PTR [ebp+12])

  mov eax, [ebp+20]
  sub eax, 1
  push eax
  mov eax, DWORD PTR [ebp+8]
  push eax
  mov eax, DWORD PTR [ebp+12]
  push eax
  mov eax, DWORD PTR [ebp+16]
  push eax
  call TorredeHanoi

  mov esp, ebp
  pop ebp
  ret 16
  
  igualum:
  
  printf("[%d, %d]\n", DWORD PTR [ebp+16], DWORD PTR [ebp+12])
  mov esp, ebp
  pop ebp
  ret 16
  

start:
  
  push qtdDiscos
  mov eax, 1
  push eax
  mov eax, 3
  push eax
  mov eax, 2
  push eax
  call TorredeHanoi

  invoke ExitProcess, 0
    
end start 
