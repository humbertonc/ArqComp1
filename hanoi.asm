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
  qtdDiscos SDWORD 3

.code
TorredeHanoi:

  ;Prólogo da função
  push ebp
  mov ebp, esp
  ;Como a função não possui variáveis locais, só precisamos
  ;colocar o endereço antigo de ebp na pilha e colocar ebp no topo da pilha

  ;Se a quantidade de discos for 1, pula para a parte igualum
  cmp DWORD PTR [ebp+20], 1
  je IgualUm

  ;Como a função é recursiva, vamos chamá-la de novo, diminuindo a quantidade de discos em 1
  ;e trocando a torre destino com a torre auxiliar
  sub DWORD PTR [ebp+20], 1
  push DWORD PTR [ebp+20]
  push DWORD PTR [ebp+16]
  push DWORD PTR [ebp+8]
  push DWORD PTR [ebp+12]
  call TorredeHanoi

  ;Imprime o movimento da torre origem para a torre destino
  printf("[%d, %d]\n", DWORD PTR [ebp+16], DWORD PTR [ebp+12])

  ;Chama a função de novo, colocando a torre auxiliar recebida como de origem,
  ;a de origem recebida como de destino, e a de destino recebida como auxiliar
  ;Como a quantidade de discos já foi subtraída em 1, não precisamos fazer isso de novo
  push DWORD PTR [ebp+20]
  push DWORD PTR [ebp+8]
  push DWORD PTR [ebp+12]
  push DWORD PTR [ebp+16]
  call TorredeHanoi

  ;Epílogo da função
  ;Funciona da mesma forma que o epílogo na parte IgualUm
  pop ebp
  ret 16
  
  IgualUm:

  ;Imprime o movimento da torre origem para a torre destino
  printf("[%d, %d]\n", DWORD PTR [ebp+16], DWORD PTR [ebp+12])

  ;Epílogo da função
  ;Como a função não possui variáveis locais, esp já está no mesmo local que ebp
  pop ebp

  ;Retorna e desempilha os 4 parâmetros
  ret 16
  
start:
  
  push qtdDiscos ;Coloca a quantidade de discos na pilha (1 parâmetro)
  push 1 ;Coloca a torre origem na pilha (Segundo parâmetro)
  push 3 ;Coloca a torre destino na pilha (Terceiro parâmetro)
  push 2 ;Coloca a torre auxiliar na pilha (Quarto parâmetro)
  call TorredeHanoi ;Chama a função

  invoke ExitProcess, 0
    
end start 
