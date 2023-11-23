.model small
.stack 1000H
.data 

    ; Constantes para pular linha
    CR EQU 13
    LF EQU 10
   
    ; Constantes para a Tela inicial 
    logo_inicio db "     ___      __               _    __" ,CR,LF
                db "    / _ | ___/ /____ _______  (_)__/ /" ,CR,LF
                db "   / __ |(_-< __/ -_) __/ _ \/ / _  /" ,CR,LF
                db "  /_/ |_/___|__/\__/_/  \___/_/\_,_/" ,CR,LF
                db "            _      __         ",CR,LF
                db "           | | /| / /__ ___ __",CR,LF
                db "           | |/ |/ / _ `/ // /",CR,LF
                db "           |__/|__/\_,_/\_, / ",CR,LF
                db "                       /___/  ", CR,LF
    botao_start db "Jogar"
    botao_exit  db "Sair"
    
    
    logo_perdeu db "        __   _____   ___ ___ ",CR,LF
                db "        \ \ / / _ \ / __| __|",CR,LF
                db "         \ V / (_) | (__| _| ",CR,LF
                db "          \_/ \___/ \___|___|",CR,LF
                db "      ___ ___ ___ ___  ___ _   _  _ ",CR,LF
                db "     | _ \ __| _ \   \| __| | | || |",CR,LF
                db "     |  _/ _||   / |) | _|| |_| ||_|",CR,LF
                db "     |_| |___|_|_\___/|___|\___/ (_)",CR,LF

    logo_venceu db "        __   _____   ___ ___ ",CR,LF
                db "        \ \ / / _ \ / __| __|",CR,LF
                db "         \ V / (_) | (__| _| ",CR,LF
                db "          \_/ \___/ \___|___|",CR,LF
                db "    __   _____ _  _  ___ ___ _   _ _",CR,LF
                db "    \ \ / / __| \| |/ __| __| | | | |",CR,LF
                db "     \ V /| _|| .` | (__| _|| |_| |_|",CR,LF
                db "      \_/ |___|_|\_|\___|___|\___/(_)",CR,LF
    
    
    
    ; Vetores para desenhar na tela
    desenho_nave db 0Fh,0Fh,0Fh,0Fh,0Fh, 4 , 4 , 4 , 0 , 0
                 db 0Fh,0Fh,0Fh,0Fh,0Fh, 0 , 0 , 0 , 0 , 0
                 db  0 ,0Fh,0Fh,0Fh, 0 , 0 , 0 , 0 , 0 , 0
                 db  0 , 4 ,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh, 0 , 0
                 db  0 , 0 , 4 ,0Fh, 1 , 1 ,0Fh,0Fh,0Fh, 4
                 db  0 , 0 , 4 ,0Fh, 1 , 1 ,0Fh,0Fh,0Fh, 4
                 db  0 , 4 ,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh, 0 , 0
                 db  0 ,0Fh,0Fh,0Fh, 0 , 0 , 0 , 0 , 0 , 0
                 db 0Fh,0Fh,0Fh,0Fh,0Fh, 0 , 0 , 0 , 0 , 0
                 db 0Fh,0Fh,0Fh,0Fh,0Fh, 4 , 4 , 4 , 0 , 0
                 
desenho_asteroid db  0 , 0 , 0 ,0Fh,0Fh,0Fh,0Fh, 0 , 0 , 0
                 db  0 , 0 ,0Fh,0Fh,0Fh,0Fh, 7 , 7 , 0 , 0
                 db  0 ,0Fh,0Fh,0Fh,0Fh, 7 , 7 , 7 , 7 , 0
                 db 0Fh,0Fh,0Fh,0Fh,0Fh,0Fh, 7 , 7 , 7 ,0Fh
                 db 0Fh, 7 , 7 ,0Fh,0Fh,0Fh,0Fh, 7 ,0Fh,0Fh
                 db 0Fh,0Fh,0Fh,0Fh,0Fh, 7 ,0Fh,0Fh,0Fh,0Fh
                 db 0Fh,0Fh,0Fh,0Fh,0Fh, 7 , 7 ,0Fh,0Fh, 7
                 db  0 , 7 , 7 ,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh, 0
                 db  0 , 0 , 7 , 7 ,0Fh,0Fh,0Fh,0Fh, 0 , 0
                 db  0 , 0 , 0 , 7 , 7 ,0Fh,0Fh, 0 , 0 , 0
                     
                     
  desenho_shield db  0 , 8 , 8 , 8 , 8 , 8 , 8 , 8 , 8 , 0
                 db  8 , 7 , 7 , 7 , 7 , 7 , 7 , 7 , 7 , 8
                 db  8 , 7 , 7 , 7 , 7 , 7 , 7 , 7 , 7 , 8
                 db  8 , 7 , 7 , 7 , 3 ,0Fh, 7 , 7 , 7 , 8
                 db  8 , 7 , 7 , 1 , 9 , 3 ,0Fh, 7 , 7 , 8
                 db  8 , 7 , 7 , 1 , 9 , 9 , 3 , 7 , 7 , 8
                 db  0 , 8 , 7 , 7 , 1 , 1 , 7 , 7 , 8 , 0
                 db  0 , 8 , 7 , 7 , 7 , 7 , 7 , 7 , 8 , 0
                 db  0 , 0 , 8 , 7 , 7 , 7 , 7 , 8 , 0 , 0
                 db  0 , 0 , 0 , 8 , 8 , 8 , 8 , 0 , 0 , 0
                   
    desenho_cura db  0 , 0 , 0 , 2 , 2 , 2 , 2 , 0 , 0 , 0
                 db  0 , 0 , 2 , 0 , 0 , 0 , 0 , 2 , 0 , 0
                 db  0 , 2 , 0 , 0 ,0Ah,0Ah, 0 , 0 , 2 , 0
                 db  2 , 0 , 0 , 0 ,0Ah,0Ah, 0 , 0 , 0 , 2
                 db  2 , 0 ,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah, 0 , 2
                 db  2 , 0 ,0Ah,0Ah,0Ah,0Ah,0Ah,0Ah, 0 , 2
                 db  2 , 0 , 0 , 0 ,0Ah,0Ah, 0 , 0 , 0 , 2
                 db  0 , 2 , 0 , 0 ,0Ah,0Ah, 0 , 0 , 2 , 0
                 db  0 , 0 , 2 , 0 , 0 , 0 , 0 , 2 , 0 , 0
                 db  0 , 0 , 0 , 2 , 2 , 2 , 2 , 0 , 0 , 0
    
    ; Constantes de Posicoes de memoria 
    memoria_video equ 0A000h
    posicao_barra_fundo equ 57600 ; coluna 0 linha 180   
    posicao_barra_vida  equ 59215 ;coluna 15 linha 185
    posicao_barra_tempo equ 59375 ;coluna 175 linha 185
    posicao_central_nave equ 30234 ; nave centralizada (coluna 154 linha 94)
    
    ; Variaveis globais
    
    posicao_atual_nave dw 0
   
    timer dw 2600 ; 130s * 20
    vida dw 10 ; hp da nave 
    
    timer_plot_ast dw 0
    
    velocidade_objetos dw 0
   
    jogando dw 0 ; status do jogo (em jogo=1; menu=0)
    vida_acabou dw 0
    tempo_acabou dw 0
    
    num_asteroides_ativos dw 0 ; numero de asteroides ativos na tela 
    asteroides dw 0,0,0,0,0,0,0 ; coluna atual
               dw 0,0,0,0,0,0,0 ; linha atual
               
    escudo dw 0,0 ; coluna, linha
    escudo_plotado dw 0
    cura_plotada dw 0
    cura dw 0,0 ; coluna, linha
    linha dw 0 ; RETORNO DE UMA FUNCAO - ALTERAR DPS NA REFATORACAO
    
    
    
.code 

;----------------------------------------------------------------------------
;
;                               PROCs GERAIS
;
;----------------------------------------------------------------------------

; Proc para finalizar o programa
FIM_PROGRAMA proc
    mov ah, 4ch
    mov al, 0
    int 21h
    ret
endp

; Proc para iniciar o modo de video 13h da int 10h (320x200, 256 cores)
MODO_DE_VIDEO proc
    mov ax, 13h
    int 10h         
    ret
endp


; Proc para pintar toda a tela de preto (limpar)
LIMPAR_TELA proc
    push ax
    push cx
    push di
           
    mov di, 0
    mov al, 0
    mov cx, 64000
    rep stosb
   
    pop di
    pop cx
    pop ax 
    ret 
    
endp


; Proc para desenhar os desenhos
; SI: Posicao desenho na memoria
; DI: Posicao do primeiro pixel do desenho no video

DESENHA_ELEMENTO proc
        push dx
        push cx
        push di
        push si

        mov dx, 10
        DESENHA_ELEMENTO_LOOP:
            mov cx, 10
            rep movsb
            dec dx
            add di, 310
            cmp dx, 0
            jnz DESENHA_ELEMENTO_LOOP
         
        pop si
        pop di
        pop cx
        pop dx
        ret 
endp


;Remove um desenho da tela
;DI recebe a posicao do primeiro pixel do sprite
REMOVE_DESENHO proc
        push ax
        push dx
        push cx
        push di
        push si

        mov dx, 10
        mov al, 0
        REMOVE_DESENHO_LOOP:
            mov cx, 10
            rep stosb
            dec dx
            add di, 310
            cmp dx, 0
            jnz REMOVE_DESENHO_LOOP
         
        pop si
        pop di
        pop cx
        pop dx
        pop ax
    ret
endp

; Proc para escrever texto na tela
; al: write mode
; bl: cor
; dh: linha       
; dl: coluna   
; cx: tamanho da string
; bp: end. inicio da string
     
ESC_STRING proc 
     push es
    push ax
    push bx
    push di
    push si
    push bp

    mov di, sp
     
    mov ax, ds    
    mov es, ax
   
    mov bh, 0
   
    mov ah, 13h
    mov al, 1
    int 10h
   
    mov sp, di
    pop bp
    pop si
    pop di
    pop bx
    pop ax
    pop es
    ret
endp


;Escrever um caractere na tela               
;Entrada DL = caracter a ser impresso
ESC_CHAR proc 
    push AX 
    
    mov ah, 2
    int 21h      
    pop AX
    ret
endp


; Ler os direcionais do teclado
; retorna o caractere em AL
LER_KEY proc 
    mov AH, 0 
    int 16h  
    ret  
endp

;Setar a poiscao do cursor
;BH: Pagina
;DH: linha 
;DL: coluna
POS_CURSOR proc 
    push AX
    push BX
    mov AH, 02 ;Codigo da funcao
    int 10h    ;Interrupcao
    pop BX
    pop AX
    ret
endp  


;----------------------------------------------------------------------------
;
;                               PROCs MENU INICIAL
;
;----------------------------------------------------------------------------

; Proc destinada ao menu inicial, para trocar os [] das opcoes
INDICADOR_OPCAO proc
    push DX
    push CX
      
    mov CH, DH
      
    cmp DH, 18
    jz  APAGA_CIMA
    
    add DH, 2    
    jmp LIMPA_INDICADOR    
    
    APAGA_CIMA:
    sub DH, 2
    
    LIMPA_INDICADOR:
    call POS_CURSOR ;BH = Page Number, DH = Row, DL = Column          
    mov CL, DL
    sub DH, 2        
    mov DL, 32
    call ESC_CHAR
    mov DL, 26
    add DH, 2
    call POS_CURSOR
    mov DL, 32
    call ESC_CHAR
    
    mov DX, CX
    call POS_CURSOR ;BH = Page Number, DH = Row, DL = Column
    
    mov DL, 91    
    call ESC_CHAR
    mov DL, 26
    call POS_CURSOR
    mov DL, 93
    CALL ESC_CHAR
    
    mov DL, 31
    call POS_CURSOR ;BH = Page Number, DH = Row, DL = Column          
        
    pop CX
    pop DX
    ret
endp    

; Proc destinada ao menu inicial, retorna a opcao selecionada (jogar ou sair)
SOLICITAR_OPCAO proc
    push AX    
    mov dh, 16
    mov DL, 14    
    call INDICADOR_OPCAO
    
    LER_TECLA: 
        mov DL, 14
        call LER_KEY
        ; Compara se o usuario apertou a arrow down
        cmp AH, 80
        je DOWN_ARROW
        ; Compara se o usuario apertou a arrow up
        cmp AH, 72
        je UP_ARROW  
 
        cmp AH, 28  
        je FIM_SOLICITAR_OPCAO
         
        jmp LER_TECLA 
        UP_ARROW:
        cmp DH,16
            jbe LER_TECLA
            
            sub DH, 2            
            jmp FIM_LER_TECLA
            
        DOWN_ARROW:
            cmp DH,18
            jae LER_TECLA
            
            ADD dh, 2
         
        FIM_LER_TECLA:    
            call INDICADOR_OPCAO
        jmp LER_TECLA
        
        FIM_SOLICITAR_OPCAO:    
    pop AX
    ret        
endp

; Proc principal do menu inicial do jogo
TELA_INICIAL proc
    ; PRINTA LOGO JOGO
    mov al, 0 ; write mode
    mov bl, 2 ; cor
    mov dh, 0 ; linha       
    mov dl, 0 ; coluna   
    mov cx, 315 ; tamanho da string
    mov bp, offset logo_inicio
    call ESC_STRING
    
    ; Printa desenhos do menu
    
    mov si, offset desenho_nave
    mov di, 28560
    call DESENHA_ELEMENTO
    
    mov si, offset desenho_asteroid
    mov di, 28610
    call DESENHA_ELEMENTO
    
    mov si, offset desenho_shield
    mov di, 28660
    call DESENHA_ELEMENTO
    
    mov si, offset desenho_cura
    mov di, 28710
    call DESENHA_ELEMENTO
    
    
    
    ; PRINTA BOTOES JOGAR E SAIR
    mov bl, 15 ; cor
    mov dh, 16 ; linha      
    mov dl, 18  ; coluna
    mov cx, 5 ; tamanho da string
    mov bp, offset botao_start
    call ESC_STRING    
    add dh, 2 ; linha
    mov cx, 4 ; tamanho da string
    mov bp, offset botao_exit
    call ESC_STRING    
    
    ; Chama proc para escolher opcao
    call SOLICITAR_OPCAO
    
    
    ; Compara se a linha selecionada foi a 18 (SAIR)
    cmp DH,18
    je FIM_TELA_INICIAL
    ; Compara se a linha selecionada foi a 16 (JOGAR)
    cmp DH,16
    je CHAMA_INICIO
    jmp FIM_TELA_INICIAL
    
    
    CHAMA_INICIO:   
        call INICIAR_JOGO 
    FIM_TELA_INICIAL:
        call FIM_PROGRAMA
    ret
    endp
   
    
;----------------------------------------------------------------------------
;
;                               PROCs DO JOGO
;
;----------------------------------------------------------------------------

    
    
; Proc destinada a inicializar o jogo
INICIAR_JOGO proc   
    call LIMPAR_TELA
    mov si, offset desenho_nave
    mov di, posicao_central_nave
    call DESENHA_ELEMENTO
    call PRINT_HUD
    
    mov bx, posicao_central_nave
    mov posicao_atual_nave, bx
    mov jogando, 1
    call EM_JOGO
    
    
    ret
    endp    


; Proc para escrever uma barra da HUD do jogo
; DX: Altura
; DI: End. inicial
; CX: Largura da barra
; AL: cor
PRINT_BARRA_HUD proc
    push di
    push dx

    PRINT_BARRA_HUD_LOOP:
        push cx
        rep stosb
        pop cx
        add di, 320
        sub di, cx
        dec dx
        cmp dx, bx
        jne PRINT_BARRA_HUD_LOOP
       
    pop dx
    pop di
    ret
endp


; Proc para printar toda a HUD do jogo
PRINT_HUD proc
   
    mov di, posicao_barra_fundo   
   
    xor bx, bx
    mov dx, 20 ; altura da barra principal
   
    LOOP_HUD_FUNDO:
        mov al, 8   ; cor cinza
        mov cx, 320 ; numero de colunas    
        rep stosb                  
        dec dx
        cmp dx, bx
        jne LOOP_HUD_FUNDO
   
        mov dx, 10 ; altura
    mov di, posicao_barra_vida
    mov al, 2 ; cor da barra 
    mov cx, 130 ; comprimento da barra
   
    call PRINT_BARRA_HUD
       
    mov dx, 10 ; altura
    mov di, posicao_barra_tempo
    mov al, 0bh ; cor da barra
    mov cx, 130 ; comprimento da barra
   
   call PRINT_BARRA_HUD

    ret
endp
    
    
    
;Limpa o buffer do teclado da interrupcao 16h
LIMPA_BUFFER_TECLADO proc
    mov ah, 01h 
    int 16h       

    jz BUFFER_LIMPO  
    mov ah, 00h   
    int 16h       

    jmp LIMPA_BUFFER_TECLADO

    BUFFER_LIMPO:
    ret
    endp 
    
;Bloqueia a execucaoo do programa a cada 50ms
BLOQUEIA_EXECUCAO_PROGRAMA proc
    push cx
    push dx
    push ax
   
    mov ah, 86h
    xor cx, cx
    mov dx, 0c350h ; DEFINE OS 50ms
    int 15h
   
    pop ax
    pop dx
    pop cx
    ret
endp


; Pinta de preto a barra do tempo a cada 1s (total: 130s)
BARRA_TEMPO_JOGO proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    xor dx, dx
    mov di, posicao_barra_tempo
    mov ax, timer
    dec ax
    mov timer, ax
    mov cx, 20 ;50ms * 20 = 1s
    div cx
    add di, ax

    mov si, 0; cor preta
    
    mov ax, memoria_video
    mov ds, ax
    mov cx, 10
    
   PINTAR_PRETO_BARRA_TEMPO:
    movsb
    add di, 319 ; 319 eh para pular a linha, pois o movsb soma di++
    loop PINTAR_PRETO_BARRA_TEMPO
    
    mov ax, @data
    mov ds, ax
    
    mov bx, timer
    cmp bx, 0 ; comparar se o tempo acabou
    jz TIMER_ACABOU
    jmp FIM_GAME_TIMER
   
    TIMER_ACABOU:
    mov jogando, 0 ; mover para a variavel em jogo 0, para dizer que o jogo acabou.
    mov tempo_acabou, 1
     
     
 FIM_GAME_TIMER:
     pop di
     pop si
     pop dx
     pop cx
     pop bx
     pop ax
    ret
endp 
    
    
;Proc destinada a mover a nave para cima
MOVE_NAVE_CIMA proc
    push ax
    push bx
    push cx
    push si
    push di
   mov bx, posicao_atual_nave
    
    mov ax, memoria_video
    mov ds, ax
    
    mov dx, 11
    mov si, bx
    mov di, bx
    sub di, 320
    push di
    MOVE_NAVE_CIMA_LOOP:
            mov cx, 10
            rep movsb
            dec dx
            add di, 310
            add si, 310
            cmp dx, 0
            jnz MOVE_NAVE_CIMA_LOOP
            pop di
            mov bx, di
           
             mov ax, @data
             mov ds, ax
            
             mov posicao_atual_nave, bx
        pop di
        pop si
        pop cx
        pop bx
        pop ax
            ret
     endp

     ;Proc destinada a mover a nave para baixo
MOVE_NAVE_BAIXO proc
    push ax
    push bx
    push cx
    push si
    push di
    mov bx, posicao_atual_nave
    mov ax, memoria_video
    mov ds, ax
    
    mov dx, 11
    mov si, bx
    mov di, bx
    add di, 320
    push di
    add di, 2880 ; inicio da ultima linha da nave
    add si, 2880 ; inicio da linha de baixo da nave
    MOVE_NAVE_BAIXO_LOOP:
            mov cx, 10
            rep movsb
            dec dx
            sub di, 330
            sub si, 330
            cmp dx, 0
            jnz MOVE_NAVE_BAIXO_LOOP
            pop di
            mov bx, di
             mov ax, @data
             mov ds, ax
             mov posicao_atual_nave, bx
        pop di
        pop si    
        pop cx
        pop bx
        pop ax
            ret
endp


;Proc destinada a checar a tecla digitada e direcionar a nave para as proc de mover para cima, baixo ou nao fazer nada
CHECA_MOVIMENTO_NAVE proc   

        push ax
        push bx
        push cx
        push dx
        push si
        push di
        MOV AH,01h
        INT 16h
        JZ FIM_MOVIMENTO_NAVE
        ;check which key is being pressed (AL = ASCII character)
        call LER_KEY
         
        ; Compara se o usuario apertou a arrow down
        cmp AH, 80
        jz MOVER_PARA_BAIXO
        ; Compara se o usuario apertou a arrow up
        cmp AH, 72
        jz MOVER_PARA_CIMA
            
        jmp FIM_MOVIMENTO_NAVE
        
        MOVER_PARA_CIMA:
        cmp  posicao_atual_nave, 474
        jz FIM_MOVIMENTO_NAVE
        call MOVE_NAVE_CIMA 
        jmp FIM_MOVIMENTO_NAVE   
        
        
        MOVER_PARA_BAIXO:
        cmp  posicao_atual_nave, 54234
        jz FIM_MOVIMENTO_NAVE
        call MOVE_NAVE_BAIXO 
        jmp FIM_MOVIMENTO_NAVE
        
        
        FIM_MOVIMENTO_NAVE:
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
    ret
endp



GERA_NUMERO_ALEATORIO proc
    push dx
    mov ah,2Ch ;VAI BUSCAR A HORA DO SISTEMA
    int 21h
    mov ax,dx ;Guarda em AX os milisegundos(DL)
    pop dx
    ret
endp



;SI: RECEBE O OFFSET DO DESENHO (asteroide, shield ou cura)
;Retonar Linha em DX
PRINTA_OBJETO_DIREITA proc
    push ax
    push cx
    push si
    push di
    push bx
    xor bx, bx
    xor dx, dx
    call GERA_NUMERO_ALEATORIO
    mov bx, 150
    div bx
    cmp dx, 11
    ja PLOTAR_DESENHO
    mov dx, 12
    cmp dx, 145
    jb PLOTAR_DESENHO
    mov dx, 144
    
    PLOTAR_DESENHO:
        xor bx, bx
        mov ax, dx ; Retorno da linha em DX
        mov linha, dx
        push dx
        mov bx, 320 ; linha * 320
        mul bx
        mov bx, 308 ; coluna 308
        add ax, bx 
        xor di, di
        mov di, ax
        call DESENHA_ELEMENTO
        pop dx
        pop bx
        pop di
        pop si
        pop cx
        pop ax
    ret
endp


PLOTA_NOVO_ASTEROIDE proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    xor ax, ax
    xor dx, dx
    
    mov ax, timer
    mov cx, 20
    div cx
    mov cx, timer_plot_ast
    cmp ax, cx
    je FINAL_PLOTA_NOVO_ASTEROIDE
    mov timer_plot_ast, ax 
    mov cx, num_asteroides_ativos
    cmp cx, 7
    je FINAL_PLOTA_NOVO_ASTEROIDE
    
    mov cx, 7
    xor ax, ax
    mov si, offset asteroides
LOOP_NOVO_AST:
    add si, 14
    lodsw
    sub si, 2
    cmp ax, 0
    jne FINAL_LOOP_NOVO_AST
    push si
    mov si, offset desenho_asteroid
    call PRINTA_OBJETO_DIREITA
    pop si
    mov ax, linha
    mov bx, @data
    mov es, bx
    
   
    mov di, si
    stosw
    sub di, 2
    sub di, 14
    mov ax, 308
    stosw
    sub di, 2
    mov ax, num_asteroides_ativos
    inc ax
    mov num_asteroides_ativos, ax
    
    mov bx, memoria_Video
    mov es, bx
    
    jmp FINAL_PLOTA_NOVO_ASTEROIDE
    FINAL_LOOP_NOVO_AST:
    sub si, 14
    add si, 2
    loop LOOP_NOVO_AST
    
    
   FINAL_PLOTA_NOVO_ASTEROIDE:
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        ret
endp


;si = Recebe posicao atual do objeto
MOVE_OBJETO proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    mov ax, memoria_video
    mov ds, ax

    mov dx, 11

LOOP_MOVE_OBJETO:  
    mov cx, 11
    mov di, si
    dec di
    rep movsb
    add di, 309 
    add si, 309
    dec dx
    cmp dx, 0
    jnz LOOP_MOVE_OBJETO
    
    mov ax, @data
    mov ds, ax
    
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp

TOMAR_DANO proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov ax, vida
    dec ax
    mov vida, ax
    mov bx, 13
    mul bx
    mov bx, posicao_barra_vida
    add ax, bx
    mov si, 0
    mov di, ax
    mov dx, 10
    mov ax, 0
APAGAR_BARRA_HP_LOOP:
    mov cx, 13
    rep stosb
    add di, 307
    dec dx
    cmp dx, 0
    jnz APAGAR_BARRA_HP_LOOP

    mov ax, vida
    cmp ax, 0
    jnz FINAL_TOMAR_DANO
    mov jogando, 0
    mov vida_acabou, 1
    
FINAL_TOMAR_DANO:
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp

CHECA_COLISAO proc

    ; si recebe coluna asteroide
    ; coluna nave 154
    push ax
    push cx
    push dx
    push si
    push di

    mov bx, 0
    cmp ax, 164 ; 154 + 10 (pixel da direita)
    ja FINAL_DA_PROC
    cmp ax, 144 ; 154 - 10 (pixel da esquerda)
    jb FINAL_DA_PROC
  
    
    mov ax, posicao_atual_nave
    sub ax, 154
    mov cx, 320
    xor dx, dx
    div cx
    mov dx, ax
    add si, 14
    xor ax, ax
    lodsw
    sub si, 2
    add ax, 10
    cmp ax, dx
    jb FINAL_DA_PROC
    sub ax, 20
    cmp ax, dx
    ja FINAL_DA_PROC
    
    call TOMAR_DANO
    mov bx, 1
FINAL_DA_PROC:
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
endp




;si recebe 
MORRER proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    add si, 14
    lodsw
    sub si, 2
    xor dx, dx
    mov bx, 320
    mul bx
    mov dx, ax
    sub si, 14
    lodsw
    sub si, 2
    add ax, dx 
    mov di, ax
    call REMOVE_DESENHO
    mov bx, @data
    mov es, bx
    mov ax, 0
    mov di, si
    stosw
    sub di, 2
    add di, 14
    stosw
    mov bx, memoria_video
    mov es, bx
    
    mov ax, num_asteroides_ativos
    dec ax
    mov num_asteroides_ativos, ax
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    
    
    ret
endp

CHECA_MOVIMENTO_ASTEROIDE proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    mov si, offset asteroides
    mov cx, 7
TESTE_TESTE:   
    xor ax, ax
    add si, 14
    lodsw
    sub si, 2
    sub si, 14
    cmp ax, 0
    jz CAI_FORA
    lodsw
    sub si, 2
    cmp ax, 0
    jz MORRE
    call CHECA_COLISAO
    cmp bx, 1
    jz MORRE
    add si, 14
    lodsw
    sub si, 2
    xor dx, dx
    mov bx, 320
    mul bx
    mov dx, ax
    sub si, 14
    lodsw
    sub si, 2
    add ax, dx
    push si
    mov si, ax
    call MOVE_OBJETO
    pop si
    mov bx, @data
    mov es, bx
    lodsw
    sub si, 2
    dec ax
    mov di, si
    stosw
    mov bx, memoria_video
    mov es, bx
    jmp CAI_FORA
MORRE:
    call MORRER
CAI_FORA:
    add si, 2
    loop TESTE_TESTE
    
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
  ret
 endp
 
 
 TELA_PERDEU proc
    push ax
    push bx
    push cx
    push dx
    
    call LIMPAR_TELA
 
    mov al, 0 ; write mode
    mov bl, 4 ; cor
    mov dh, 2 ; linha       
    mov dl, 0 ; coluna   
    mov cx, 274 ; tamanho da string
    mov bp, offset logo_perdeu
    call ESC_STRING
    pop dx
    pop cx
    pop bx
    pop ax
        
        
 ret
 endp
 
 
 
 
 
  TELA_GANHOU proc
    push ax
    push bx
    push cx
    push dx
    call LIMPAR_TELA
 
    mov al, 0 ; write mode
    mov bl, 0eh ; cor
    mov dh, 2 ; linha       
    mov dl, 0 ; coluna   
    mov cx, 278 ; tamanho da string
    mov bp, offset logo_venceu
    call ESC_STRING
    pop dx
    pop cx
    pop bx
    pop ax
        
        
 ret
 endp
 
 
 
; Proc de LOOP do jogo em funcionamento  
EM_JOGO proc

     LOOP_JOGO:

        call BARRA_TEMPO_JOGO
        call CHECA_MOVIMENTO_NAVE
        call LIMPA_BUFFER_TECLADO
        call PLOTA_NOVO_ASTEROIDE
        call CHECA_MOVIMENTO_ASTEROIDE
        call BLOQUEIA_EXECUCAO_PROGRAMA
        
        mov bx, jogando
        cmp bx, 1
        je LOOP_JOGO    
        
        mov bx, vida_acabou
        cmp bx, 1
        je TELA_PERDEU
        mov bx, tempo_acabou
        cmp bx, 1
        je TELA_GANHOU
        ret
endp
 

; funcao main (iniciar)
inicio:  
    mov ax, @data
    mov ds, ax
    mov ax, memoria_video
    mov es, ax
    call MODO_DE_VIDEO
    call TELA_INICIAL
 

end inicio


