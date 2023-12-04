.model small
.stack 1000H
.data 
    ; Variaveis para alterar a configuracao
    
    quantidade_asteroides dw 16
    timer_do_jogo dw 130 ;segundos
    cooldown_shield dw 15 ;segundos
    tempo_imunidade_escudo dw 5 ;segundos
    
    ; Constantes para pular linha
    CR EQU 13
    LF EQU 10
   

    ; Constantes de escritas
    logo_inicio db "     ___      __               _    __" ,CR,LF
                db "    / _ | ___/ /____ _______  (_)__/ /" ,CR,LF
                db "   / __ |(_-< __/ -_) __/ _ \/ / _  /" ,CR,LF
                db "  /_/ |_/___|__/\__/_/  \___/_/\_,_/" ,CR,LF
                db "            _      __         ",CR,LF
                db "           | | /| / /__ ___ __",CR,LF
                db "           | |/ |/ / _ `/ // /",CR,LF
                db "           |__/|__/\_,_/\_, / ",CR,LF
                db "                       /___/  ", CR,LF
    botao_start db "Start"
    botao_exit  db "Exit"
    botao_restart db "Restart"
    
    
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
    
    
    
   ; Constantes de desenhos
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
                 
desenho_nave_imune   db  7 , 7 , 7 , 7 , 7 , 9 , 9 , 9 , 0 , 0
                     db  7 , 7 , 7 , 7 , 7 , 0 , 0 , 0 , 0 , 0
                     db  0 , 7 , 7 , 7 , 0 , 0 , 0 , 0 , 0 , 0
                     db  0 , 9 , 7 , 7 , 7 , 7 , 7 , 7 , 0 , 0
                     db  0 , 0 , 9 , 7 , 3 ,0Fh, 7 , 7 , 7 , 9
                     db  0 , 0 , 9 , 7 , 1 , 9 , 7 , 7 , 7 , 9
                     db  0 , 9 , 7 , 7 , 7 , 7 , 7 , 7 , 0 , 0
                     db  0 , 7 , 7 , 7 , 0 , 0 , 0 , 0 , 0 , 0
                     db  7 , 7 , 7 , 7 , 7 , 0 , 0 , 0 , 0 , 0
                     db  7 , 7 , 7 , 7 , 7 , 9 , 9 , 9 , 0 , 0
                 
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
    posicao_barra_nivel equ 59355 ; coluna 155 linha 185 nivel do jogo
    poiscao_nivel_um equ 61915 ; posicao de print do nivel 1
    
    
    
    ; Variaveis globais de utilizacao do programa

    velocidades_niveis dw 1000, 40000, 25000, 20000, 10000
    divisores_niveis  dw 20, 25, 40, 50, 100
    posicao_atual_nave dw 0
    asteroides dw 32 dup (0)
    posicao_atual_tiro dw 0,0

    desl_vet_asteroid dw 32
    timer dw 0 ; 130s * 20
    vida dw 10 ; hp da nave 
    
    timer_plot_ast dw 0 ; cooldown para spawn dos asteroides
    timer_plot_shield dw 0
    timer_imunidade_nave dw 0
    imune dw 0
    
    clock_jogo dw 50000
    jogando dw 0 ; status do jogo (em jogo=1; menu=0)
    vida_acabou dw 0
    
    enviar_cura dw 1
    enviar_shield dw 0
    
    posicao_cura dw 0,0
    posicao_shield dw 0,0
    
    nivel dw 1
    num_asteroides_ativos dw 0 ; numero de asteroides ativos na tela 
    
               
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
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    call ZERAR_ASTEROIDES_ATIVOS
    call BARRA_DE_TEMPO
    mov vida, 10
    mov jogando, 1
    mov vida_acabou, 0
    mov enviar_shield, 0
    mov num_asteroides_ativos, 0
    mov timer_plot_ast, 0
    mov nivel, 1
    
    mov si, offset velocidades_niveis
    mov ax, [si]
    mov clock_jogo, ax
    
    
    call LIMPAR_TELA
    mov si, offset desenho_nave
    mov di, posicao_central_nave
    call DESENHA_ELEMENTO
    call PRINT_HUD
    
    mov bx, posicao_central_nave
    mov posicao_atual_nave, bx
    mov jogando, 1
    call EM_JOGO
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
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
        cmp dx, 0
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
   
        call BARRA_DE_VIDA
        call BARRA_DE_TEMPO
  
   
    mov dx, 10 ; altura
    mov di, posicao_barra_nivel
    mov al, 0 ; cor da barra
    mov cx, 10 ; comprimento da barra
   
   call PRINT_BARRA_HUD
   
   mov dx, 2 ; altura
    mov di, poiscao_nivel_um
    mov al, 0eh ; cor da barra
    mov cx, 10 ; comprimento da barra
   
   call PRINT_BARRA_HUD
   
    ret
endp
    
    

BARRA_DE_TEMPO proc
    push ax
    push bx
    push cx
    push dx
    
    
    
    mov si, offset divisores_niveis
    mov ax, nivel
    dec ax
    mov bx, 2
    xor dx,dx
    mul bx
    mov cx,ax
    
    
    add si, cx
    mov cx, [si]
    xor dx, dx
    mov ax,  timer_do_jogo
    mul cx
    mov timer, ax
    
    
    mov dx, 10 ; altura
    mov di, posicao_barra_tempo
    mov al, 0bh ; cor da barra
    mov cx, 130 ; comprimento da barra
   
   call PRINT_BARRA_HUD
   pop dx
   pop cx
   pop bx
   pop ax
ret
endp

BARRA_DE_VIDA proc
    push ax
    push bx
    push cx
    push dx

    mov vida, 10
    mov dx, 10 ; altura
    mov di, posicao_barra_vida
    mov al, 2 ; cor da barra 
    mov cx, 130 ; comprimento da barra
   
    call PRINT_BARRA_HUD
      pop dx
   pop cx
   pop bx
   pop ax

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
    ;mov dx, 0c350h ; DEFINE OS 50ms
    mov dx, clock_jogo
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
    
    
    mov di, posicao_barra_tempo
    
    
    mov cx, nivel
    
    mov si, offset divisores_niveis
    mov ax, nivel
    dec ax
    mov cx, 2
    xor dx,dx
    mul cx
    mov cx,ax
    
    add si, cx
    mov cx, [si]
    
    xor dx,dx
    mov ax, timer
    dec ax
    mov timer, ax
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
    call PASSAR_NIVEL
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
        call LER_KEY
         
        ; Compara se o usuario apertou a arrow down
        cmp AH, 80
        jz MOVER_PARA_BAIXO
        ; Compara se o usuario apertou a arrow up
        cmp AH, 72
        jz MOVER_PARA_CIMA
        
        cmp AL, 32
        jz ATIRAR
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
        
    ATIRAR:
        cmp posicao_atual_tiro, 0
        jnz FIM_MOVIMENTO_NAVE
        
        call CRIA_TIRO
       
        
        FIM_MOVIMENTO_NAVE:
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
    ret
endp

CRIA_TIRO proc
        push ax
        push bx
        push cx
        push dx
        push si
        push di 
        
        mov si, offset posicao_atual_tiro
        mov ax, posicao_atual_nave
     
        mov bx, 166 ; 154 (coluna nave) + 12 (espa?amento para sair o tiro)
        mov [si], bx ; armazena coluna do tiro
        
        sub ax, 154
        mov cx, 320
        xor dx, dx
        div cx
        add ax, 5 ; deslocamento para centralizar o tiro 
        add si, 2 
        mov [si], ax ; armazena linha do tipo
        
        xor dx, dx
        
        mov bx, 320
        mul bx
        mov bx, ax
        sub si, 2
        mov ax, [si]
        add ax, bx
        
        mov di, ax
    
        mov ax, memoria_video
        mov ds, ax
        mov cx, 10
    
        mov [di], 0fh
            
        mov ax, @data
        mov ds, ax
        
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax 
   ret
endp

REMOVER_TIRO proc
        push ax
        push bx
        push cx
        push dx
        push si
        push di 

        mov si, offset posicao_atual_tiro
        add si, 2
        mov ax, [si]
        mov bx, 320
        xor dx,dx
        mul bx
        mov bx, ax
        sub si, 2
        mov ax, [si]
        add ax, bx 
        mov di, ax
        mov ax, memoria_video
        mov ds, ax
    
        mov [di], 0
            
        mov ax, @data
        mov ds, ax

        mov ax, [si]
        mov [si], 0
        add si,2
        mov [si], 0
        
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax 
    ret
endp

MOVER_TIRO proc
        push ax
        push bx
        push cx
        push dx
        push si
        push di 

        mov si, offset posicao_atual_tiro
        mov ax, [si]
        cmp ax, 319
        jz APAGAR_TIRO
        add si, 2
        mov ax, [si]
        cmp ax, 0
        jz FIM_MOVER_TIRO
        mov bx, 320
        xor dx,dx
        mul bx
        mov bx, ax
        sub si, 2
        mov ax, [si]
        push ax
        add ax, bx 
        
        mov di, ax
        
        mov ax, memoria_video
        mov ds, ax
        mov cx, 10
    
        mov [di], 0
        inc di
        mov [di], 0fh
            
        mov ax, @data
        mov ds, ax
        
        pop ax
        inc ax
        mov [si], ax
        
       jmp FIM_MOVER_TIRO
        
    APAGAR_TIRO:
      call REMOVER_TIRO 
        
        
  
    FIM_MOVER_TIRO:
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax 
   ret
endp

; dx - deslocamento (desl_vet_asteroid ou 2)
; si - endere?o coluna objeto na memoria
COLISAO_TIRO proc
        push ax
        push bx
        push cx
        push si
        push di 
        mov cx, dx
        mov bx, offset posicao_atual_tiro
        mov ax, [si]
        mov dx, [bx]
        dec ax
        cmp ax, dx
        ja FIM_COLISAO_TIRO
        add ax, 10
        cmp ax, dx
        jb FIM_COLISAO_TIRO
        add si, cx
        mov ax, [si]
        add bx, 2
        mov dx, [bx]
        cmp dx, ax
        jb FIM_COLISAO_TIRO
        add ax, 10
        cmp dx, ax
        ja FIM_COLISAO_TIRO
        sub si, cx
        sub bx, 2
        mov dx, 1
        call REMOVER_TIRO
    FIM_COLISAO_TIRO:
        pop di
        pop si
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
   
   cmp enviar_shield, 0
   je PLOTAR_ASTEROIDE
   mov ax, timer_plot_shield
   cmp ax, 0
   jne PLOTAR_ASTEROIDE
   mov si, offset desenho_shield
   call PRINTA_OBJETO_DIREITA
   call RESET_TIMER_ESCUDO
   mov si, offset posicao_shield
   mov [si], 308
   add si, 2
   mov [si], dx
   jmp FINAL_PLOTA_NOVO_ASTEROIDE
    
PLOTAR_ASTEROIDE:
    mov cx, num_asteroides_ativos
    mov ax, quantidade_asteroides
    cmp cx, ax
    je FINAL_PLOTA_NOVO_ASTEROIDE
    
    mov cx, quantidade_asteroides
    xor ax, ax
    mov si, offset asteroides
    
 LOOP_NOVO_AST:
    add si, desl_vet_asteroid
    mov ax, [si]
    cmp ax, 0
    jne FINAL_LOOP_NOVO_AST
    push si
    mov si, offset desenho_asteroid
    call PRINTA_OBJETO_DIREITA
    
    pop si
    mov ax, dx
    mov [si], ax
    sub si, desl_vet_asteroid
    mov ax, 308
    mov [si], ax
    mov ax, num_asteroides_ativos
    inc ax
    mov num_asteroides_ativos, ax 
    jmp FINAL_PLOTA_NOVO_ASTEROIDE
    
  FINAL_LOOP_NOVO_AST:
    sub si, desl_vet_asteroid
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
    cmp ax, 5
    ja NAO_ENVIAR_AJUDA
    call ENVIAR_AJUDA
NAO_ENVIAR_AJUDA:
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

; si recebe coluna asteroide
; cx recebe deslocamento (asteroide ou ajuda)
; coluna nave 154
CHECA_COLISAO proc
    push ax
    push cx
    push dx
    push si
    push di

    xor bx, bx
    xor dx, dx
    
    
    cmp ax, 164 ; 154 + 10 (pixel da direita)
    ja FINAL_CHECA_COLISAO
    cmp ax, 144 ; 154 - 10 (pixel da esquerda)
    jb FINAL_CHECA_COLISAO
  
    mov ax, posicao_atual_nave
    sub ax, 154
    push cx
    mov cx, 320

    div cx
    mov dx, ax
    pop cx
    add si, cx
 
    mov ax, [si]
    add ax, 10
    
    cmp ax, dx
    jb FINAL_CHECA_COLISAO
    
    sub ax, 20
    cmp ax, dx
    ja FINAL_CHECA_COLISAO
    
    mov bx, 1
    
FINAL_CHECA_COLISAO:
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
endp



;si recebe asteroide
APAGA_ASTEROIDE proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    xor dx, dx
    
    add si, desl_vet_asteroid
    mov ax, [si]
    
    mov bx, 320
    mul bx
    mov dx, ax
    sub si, desl_vet_asteroid
    mov ax, [si]
    add ax, dx 
    mov di, ax
    call REMOVE_DESENHO
    
    mov ax, 0
    mov [si], ax
    add si, desl_vet_asteroid
    mov [si], ax

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


CHECA_ASTEROID proc
mov si, offset asteroides
    mov cx, quantidade_asteroides  
LOOP_CHECAGEM_ASTEROIDES:   
    xor ax, ax
    xor dx, dx
    add si, desl_vet_asteroid
    mov ax, [si]
    sub si, desl_vet_asteroid
    cmp ax, 0
    jz FINAL_CHECAGEM_ASTEROIDE
    
    mov ax, [si]
    cmp ax, 0
    jz REMOVER_ASTEROIDE
    push cx
    mov cx, desl_vet_asteroid
    call CHECA_COLISAO
    pop cx
    cmp bx, 1
    jz COLISAO_COM_ASTEROIDE
    add si, desl_vet_asteroid
    mov ax, [si]
    mov bx, 320
    mul bx
    mov dx, ax
    sub si, desl_vet_asteroid
    mov ax, [si]
    add ax, dx
    push si
    mov si, ax
    call MOVE_OBJETO
    
    pop si
    mov ax, [si]
    dec ax
    mov [si], ax
    jmp FINAL_CHECAGEM_ASTEROIDE
    
COLISAO_COM_ASTEROIDE:
    cmp imune, 1
    je REMOVER_ASTEROIDE
    call TOMAR_DANO
REMOVER_ASTEROIDE:
    call APAGA_ASTEROIDE
    
FINAL_CHECAGEM_ASTEROIDE:
    mov dx, desl_vet_asteroid
    call COLISAO_TIRO
    cmp dx, 1
    jne FIM_LOOP_CHECAGEM_ASTEROIDES
    call APAGA_ASTEROIDE
FIM_LOOP_CHECAGEM_ASTEROIDES:
    add si, 2
    loop LOOP_CHECAGEM_ASTEROIDES
   ret
endp


;si posicao da memoria (coluna)
;cx deslocamento
;retorna em di
CALCULA_POSICAO_DE_VIDEO:
    push ax
    push bx
    push cx
    push dx
    push si

    add si, cx
    mov ax, [si]
    mov bx, 320
    xor dx, dx
    mul bx
    sub si, cx
    mov bx, [si]
    add ax, bx
    mov di, ax
 
    pop si
    pop dx
    pop cx
    pop bx
    pop ax

 ret
endp


;si = posicao_curao ou posicao_escudo
;dx = 1 (colisão)
CHECA_OBJETO:
    push ax
    push bx
    push cx
    push di
    push si
    xor dx,dx
    
    mov ax, [si]
    cmp ax, 0
    jne MOVIMENTA_OBJETO
    add si, 2
    mov ax, [si]
    cmp ax, 0
    je FIM_CHECA_OBJETO
    
    sub si, 2
    mov cx, 2 
    call CALCULA_POSICAO_DE_VIDEO
    
    call REMOVE_DESENHO
    
    xor ax, ax
    add si, 2
    mov [si], ax
    jmp FIM_CHECA_OBJETO
    
MOVIMENTA_OBJETO:
    
    mov cx, 2
    
    call CHECA_COLISAO
    cmp bx, 1
    
    jne MOVER_OBJETO 
    
    mov cx, 2 
    call CALCULA_POSICAO_DE_VIDEO
    
    call REMOVE_DESENHO
    xor ax,ax
    mov [si], ax
    add si, 2
    mov [si], ax
    
    mov dx, 1
    jmp FIM_CHECA_OBJETO

    
MOVER_OBJETO:
    add si, 2
    mov ax, [si]
    mov cx, 320
    mul cx
    sub si, 2
    mov cx, [si]
    add ax, cx
    push si
    mov si, ax
    call MOVE_OBJETO
    pop si
    dec cx
    mov [si], cx
    mov dx, 2
    call COLISAO_TIRO
    cmp dx, 1
    jne FIM_CHECA_OBJETO
    dec ax
    mov di, ax
    call REMOVE_DESENHO
    xor ax, ax
    mov [si], ax
    add si, 2
    mov [si], ax
    
    xor dx,dx
FIM_CHECA_OBJETO:
     pop di
     pop si
     pop cx
     pop bx
     pop ax
 ret
endp


CHECA_MOVIMENTO_OBJETO proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov si, offset posicao_cura
    call CHECA_OBJETO
    
    cmp dx, 1  
    jne CHECA_MOV_SHIELD  
    call BARRA_DE_VIDA

   
CHECA_MOV_SHIELD:
    
    mov si, offset posicao_shield
    call CHECA_OBJETO
    
    cmp dx, 1
    jne CHECAGEM_ASTEROIDES
    call DEIXAR_NAVE_IMUNE

CHECAGEM_ASTEROIDES:
    call CHECA_ASTEROID
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
  ret
 endp
 
 PASSAR_NIVEL proc
     push ax
     push bx
     push cx
     push dx
     push si
     push di
     mov ax, nivel
     cmp ax, 5
     je VENCEU_JOGO
     inc ax
     mov nivel, ax
     call BARRA_DE_TEMPO
     call RESET_TIMER_ESCUDO
     xor dx, dx 
     dec ax
     mov cx, 2
     mul cx
     mov si, offset velocidades_niveis
     add si, ax
     mov cx, [si]
     mov clock_jogo, cx
     
     mov enviar_cura,1
     mov enviar_shield, 1
     
     mov bx, poiscao_nivel_um
     mov cx, 320
     mul cx
     sub bx, ax

    mov dx, 2 ; altura
    mov di, bx
    mov al, 0eh ; cor da barra
    mov cx, 10 ; comprimento da barra
   
   call PRINT_BARRA_HUD
   jmp FINAL_PASSAR_NIVEL
    VENCEU_JOGO:
    mov al, 0eh
    mov bp, offset logo_venceu
    call TELA_POS_JOGO
   
FINAL_PASSAR_NIVEL:
     pop di
     pop si
     pop dx
     pop cx
     pop bx
     pop ax
 ret
 endp

 ZERAR_ASTEROIDES_ATIVOS proc
    push ax
    push bx
    push cx
    push dx
    xor ax, ax
    mov cx, desl_vet_asteroid
    mov bx, offset asteroides
    ZERA_VETOR_ASTEROIDES:
    mov [bx], ax
    add bx, 2
    loop ZERA_VETOR_ASTEROIDES
    pop dx
    pop cx
    pop bx
    pop ax
 ret
 endp
 
 
 
 ; al = cor do fundo
 TELA_POS_JOGO proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 200
    mov di, 0

    LOOP_PINTA_TELA_POS_JOGO:
    mov dx,320
LOOP_PINTA_LINHA: 
    stosb
    dec dx
    cmp dx, 0
    jne LOOP_PINTA_LINHA


    push cx
    push ax
        mov ah, 86H
        mov cx, 0
        mov dx, 25000
        int 15h

        pop ax
        pop cx

        loop LOOP_PINTA_TELA_POS_JOGO
        call LIMPAR_TELA
    mov al, 0 ; write mode
    mov bl, 0fh ; cor
    mov dh, 2 ; linha
    mov dl, 0 ; coluna
    mov cx, 278 ; tamanho da string
    call ESC_STRING

    mov bl, 15 ; cor
    mov dh, 16 ; linha
    mov dl, 17  ; coluna
    mov cx, 7 ; tamanho da string
    mov bp, offset botao_restart
    call ESC_STRING

    mov dl, 18  ; coluna
    add dh, 2 ; linha
    mov cx, 4 ; tamanho da string
    mov bp, offset botao_exit
    call ESC_STRING

    ; Chama proc para escolher opcao
    call SOLICITAR_OPCAO
    cmp DH,18
    je FIM_TELA_POS_JOGO
    cmp DH,16
    je CHAMA_REINICIO
    jmp FIM_TELA_POS_JOGO

    CHAMA_REINICIO:
        pop dx
        pop cx
        pop bx
        pop ax
        call INICIAR_JOGO 
    FIM_TELA_POS_JOGO:
        call FIM_PROGRAMA
 ret
 endp
 
 RESET_TIMER_ESCUDO proc
     push ax
    push bx
    push cx
    push dx
    mov bx, offset divisores_niveis
    mov ax, nivel
    dec ax
    mov cx, 2
    mul cx
    xor dx, dx
    add bx, ax
    mov ax, [bx]
    mov dx, cooldown_shield
    mul dx
    mov timer_plot_shield, ax
         pop dx
        pop cx
        pop bx
        pop ax  
 ret
 endp
 TIMER_ESCUDO proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    cmp enviar_shield, 0
    je FIM_TIMER_ESCUDO
    mov ax, timer_plot_shield
    cmp ax, 0
    je FIM_TIMER_ESCUDO
    dec ax
    mov timer_plot_shield, ax
 FIM_TIMER_ESCUDO:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
 ret
 endp
 
 ENVIAR_AJUDA proc
 push ax
 push bx
 push cx
 push dx
 push si
 push di
 
    mov ax, enviar_cura
    cmp ax, 0
    jz FINAL_VERIF_AJUDA
    mov ax, vida
    cmp ax, 5
    ja FINAL_VERIF_AJUDA
    
    mov si, offset desenho_cura 
    call PRINTA_OBJETO_DIREITA
    mov si, offset posicao_cura
    mov [si], 308
    add si, 2
    mov [si], dx
    mov enviar_cura, 0
    
FINAL_VERIF_AJUDA:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
 ret
 endp
 
 
TIMER_IMUNIDADE proc
     push ax
     push bx
     push cx
     push dx
     push si
     push di
     cmp imune, 0
     je FIM_TIMER_IMUNIDADE
     cmp timer_imunidade_nave,0
     je VOLTAR_NAVE_PADRAO
     mov ax, timer_imunidade_nave
     dec ax
     mov timer_imunidade_nave, ax
     jmp FIM_TIMER_IMUNIDADE
 VOLTAR_NAVE_PADRAO:
    mov imune, 0
    mov di, posicao_atual_nave
    mov si, offset desenho_nave
    call DESENHA_ELEMENTO
    
 FIM_TIMER_IMUNIDADE:
     pop di
     pop si
     pop dx
     pop cx
     pop bx
     pop ax
ret
endp
 
DEIXAR_NAVE_IMUNE proc
     push ax
     push bx
     push cx
     push dx
     push si
     push di
    mov imune, 1
    mov si, offset desenho_nave_imune
    mov di, posicao_atual_nave
    call DESENHA_ELEMENTO
    mov ax, nivel
    dec ax
    mov cx, 2
    mul cx
    mov bx, offset divisores_niveis
    add bx, ax
    mov ax, [bx]
    mov dx, tempo_imunidade_escudo
    mul dx
    mov timer_imunidade_nave, ax
      pop di
     pop si
     pop dx
     pop cx
     pop bx
     pop ax
ret
endp


 
; Proc de LOOP do jogo em funcionamento  
EM_JOGO proc

     LOOP_JOGO:
        call TIMER_ESCUDO
        call TIMER_IMUNIDADE
        call BARRA_TEMPO_JOGO
        call CHECA_MOVIMENTO_NAVE
        call LIMPA_BUFFER_TECLADO
        call PLOTA_NOVO_ASTEROIDE
        call CHECA_MOVIMENTO_OBJETO
        call MOVER_TIRO
        call BLOQUEIA_EXECUCAO_PROGRAMA
        mov bx, jogando
        cmp bx, 1
        je LOOP_JOGO    
        
        mov bx, vida_acabou
        cmp bx, 1
        
        mov al, 4
        mov bp, offset logo_perdeu 
        call TELA_POS_JOGO
        
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
