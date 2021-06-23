.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data
  qtdDiscos DD ?
  inputHandle DD 0
  outputHandle DD 0
  inputString DB 5 dup(0)
  requestString DB "Digite a quantidade de discos no seu jogo de Torres de Hanoi:", 0H
  comecoPrint DB "["
  meioPrint DB ","
  fimPrint DB "]", 0AH
  tamanhoString DD 0
  primeiroNum DB 0
  segundoNum DB 0
  newLine DB 0AH
  consoleCount DD 0

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

  ;Converte o número da torre origem e torre destino para string
  invoke dwtoa, DWORD PTR [ebp+16], addr primeiroNum
  invoke dwtoa, DWORD PTR [ebp+12], addr segundoNum

  ;Imprime o movimento da torre origem para a torre destino
  invoke WriteConsole, outputHandle, addr comecoPrint, sizeof comecoPrint, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr primeiroNum, sizeof primeiroNum, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr meioPrint, sizeof meioPrint, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr segundoNum, sizeof segundoNum, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr fimPrint, sizeof fimPrint, addr consoleCount, NULL

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

  ;Converte o número da torre origem e torre destino para string
  invoke dwtoa, DWORD PTR [ebp+16], addr primeiroNum
  invoke dwtoa, DWORD PTR [ebp+12], addr segundoNum

  ;Imprime o movimento da torre origem para a torre destino
  invoke WriteConsole, outputHandle, addr comecoPrint, sizeof comecoPrint, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr primeiroNum, sizeof primeiroNum, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr meioPrint, sizeof meioPrint, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr segundoNum, sizeof segundoNum, addr consoleCount, NULL
  invoke WriteConsole, outputHandle, addr fimPrint, sizeof fimPrint, addr consoleCount, NULL

  ;Epílogo da função
  ;Como a função não possui variáveis locais, esp já está no mesmo local que ebp
  pop ebp

  ;Retorna e desempilha os 4 parâmetros
  ret 16
  
start:

  ;Colocando os handles de entrada e saída nas variáveis correspondentes
  invoke GetStdHandle, STD_OUTPUT_HANDLE
  mov outputHandle, eax
  invoke GetStdHandle, STD_INPUT_HANDLE
  mov inputHandle, eax

  ;Imprime o pedido para o usuário digitar a quantidade de discos
  invoke WriteConsole, outputHandle, addr requestString, sizeof requestString, addr consoleCount, NULL

  ;Faz a leitura da quantidade de discos digitada pelo usuário
  invoke ReadConsole, inputHandle, addr inputString, sizeof inputString, addr consoleCount, NULL

  ;Retira os valores que não são números da inputString
  mov esi, offset inputString 
  proximo:
    mov al, [esi]
    inc esi
    cmp al, 48
    jl terminar
    cmp al, 58
    jl proximo
  terminar:
    dec esi 
    xor al, al
    mov [esi], al

  ;Converte inputString para número e coloca na variável correspondente
  invoke atodw, addr inputString
  mov qtdDiscos, eax
  
  push qtdDiscos ;Coloca a quantidade de discos na pilha (Primeiro parâmetro)
  push 1 ;Coloca a torre origem na pilha (Segundo parâmetro)
  push 3 ;Coloca a torre destino na pilha (Terceiro parâmetro)
  push 2 ;Coloca a torre auxiliar na pilha (Quarto parâmetro)
  call TorredeHanoi ;Chama a função

  invoke ExitProcess, 0
    
end start 
