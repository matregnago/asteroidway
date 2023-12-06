    .model small
    .stack 1000H
    .data 
    ; Variaveis para alterar a configuracao
    quantidade_asteroides dw 16
    timer_do_jogo dw 130 ;segundos por nivel
    cooldown_shield dw 15 ;segundos
    tempo_imunidade_escudo dw 5 ;segundos
    nivel_maximo dw 5
    
    ; Constantes para pular linha
    CR EQU 13
    LF EQU 10

    ; Constantes de escrita
    
    botao_start db "Start$"
    botao_exit  db "Exit$"
    botao_restart db "Restart$"
    
    logo_inicio db "     ___      __               _    __" ,CR,LF
                db "    / _ | ___/ /____ _______  (_)__/ /" ,CR,LF
                db "   / __ |(_-< __/ -_) __/ _ \/ / _  /" ,CR,LF
                db "  /_/ |_/___|__/\__/_/  \___/_/\_,_/" ,CR,LF
                db "            _      __         ",CR,LF
                db "           | | /| / /__ ___ __",CR,LF
                db "           | |/ |/ / _ `/ // /",CR,LF
                db "           |__/|__/\_,_/\_, / ",CR,LF
                db "                       /___/  $",CR,LF
    
    logo_perdeu db "        __   _____   ___ ___ ",CR,LF
                db "        \ \ / / _ \ / __| __|",CR,LF
                db "         \ V / (_) | (__| _| ",CR,LF
                db "          \_/ \___/ \___|___|",CR,LF
                db "      ___ ___ ___ ___  ___ _   _  _ ",CR,LF
                db "     | _ \ __| _ \   \| __| | | || |",CR,LF
                db "     |  _/ _||   / |) | _|| |_| ||_|",CR,LF
                db "     |_| |___|_|_\___/|___|\___/ (_)$",CR,LF

    logo_venceu db "        __   _____   ___ ___ ",CR,LF
                db "        \ \ / / _ \ / __| __|",CR,LF
                db "         \ V / (_) | (__| _| ",CR,LF
                db "          \_/ \___/ \___|___|",CR,LF
                db "    __   _____ _  _  ___ ___ _   _ _",CR,LF
                db "    \ \ / / __| \| |/ __| __| | | | |",CR,LF
                db "     \ V /| _|| .` | (__| _|| |_| |_|",CR,LF
                db "      \_/ |___|_|\_|\___|___|\___/(_)$",CR,LF   
    
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
                 
    desenho_nave_imune db  7 , 7 , 7 , 7 , 7 , 9 , 9 , 9 , 0 , 0
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
    posicao_nivel_um equ 61915 ; posicao de print do nivel 1
    
    ; Variaveis globais de utilizacao do programa
    
    ; Controle de velocidade do jogo
    velocidades_niveis dw 50000, 40000, 25000, 20000, 10000 ; (50ms, 40ms, 25ms, 20ms, 10ms)
    divisores_niveis  dw 20, 25, 40, 50, 100
    
    ; Posicoes dos objetos do jogo
    posicao_atual_nave dw 0
    posicao_atual_tiro dw 0,0
    posicao_cura dw 0,0
    posicao_shield dw 0,0
    asteroides dw 32 dup (0) ; salva a posicao de todos os asteroides
    desl_vet_asteroid dw 32 ; deslocamento do vetor de asteroides
    num_asteroides_ativos dw 0 ; numero de asteroides ativos na tela 
    
    ; Variaveis do jogo
    timer dw 0 
    vida dw 10 
    nivel dw 1
    clock_jogo dw 0 ; clock atual do jogo
    timer_plot_ast dw 0 ; cooldown para spawn dos asteroides
    timer_plot_shield dw 0 ; cooldown para spawn do shield
    timer_imunidade_nave dw 0 ; tempo de imunidade da nave
    
    imune dw 0 ; 0 ou 1 (estado de imunidade da nave)
    jogando dw 0 ; status do jogo (em jogo=1; menu=0)
    vida_acabou dw 0 ; flag para sinalizar que o jogador esta sem vida
    enviar_cura dw 1 ; flag que permite enviar uma cura
    enviar_shield dw 0 ; flag que permite enviar os escudos
    plotar_cura dw 0 ; variavel auxiliar para evitar bug de curas
    
    .code
    
    ; Funcao para iniciar o modo de video 13h da int 10h (320x200, 256 cores)
    MODO_DE_VIDEO proc
    push ax
    mov ax, 13h
    int 10h
    pop ax
    ret
    endp
    
    
    ; Funcao para pintar toda a tela de preto (limpar)
    LIMPAR_TELA proc
    push ax
    push cx
    push dx
    
    mov di, 0
    mov al, 0
    mov cx, 64000
    rep stosb
    
    pop dx
    pop cx
    pop ax
    ret
    
    endp
    
    
    ; Funcao para desenhar os objetos
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
    
    
    ; Funcao para remover um desenho da tela
    ;DI recebe a posicao do primeiro pixel do desenho
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
    
    ; Funcao para escrever texto na tela
    ; bl: cor
    ; dh: linha
    ; dl: coluna
    ; bp: end. inicio da string
    
    ESC_STRING proc
    push es
    push ax
    push bx
    push dx
    push si
    push bp
    
    mov di, sp
    
    mov ax, ds
    mov es, ax
    
    mov bh, 0
    mov si, bp
    call CALCULA_TAM_STRING
    mov ah, 13h
    mov al, 1
    int 10h
    
    mov sp, di
    pop bp
    pop si
    pop dx
    pop bx
    pop ax
    pop es
    ret
    endp
    
    ; Funcao para calcular o tamanho total de uma string
    ;retorna em CX
    ;recebe inicio da string em si
    CALCULA_TAM_STRING proc
    push ax
    push si
    xor cx, cx
LOOP_TAM_STRING:
    xor ax, ax
    mov al, [si]
    cmp al, 36
    je FIM_TAM_STRING
    inc cx
    inc si
    
    jmp LOOP_TAM_STRING
    
FIM_TAM_STRING:
    pop si
    pop ax
    ret
    endp
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
    push ax
    push bx
    mov ah, 02                   ;Codigo da funcao
    int 10h                      ;Interrupcao
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao para trocar os [] das opcoes
    INDICADOR_OPCAO proc
    push dx
    push cx
    mov ch, dh
    cmp dh, 18
    jz APAGA_CIMA
    
    add dh, 2
    jmp LIMPA_INDICADOR
    
APAGA_CIMA:                   ; apagar as [ ] da linha de cima
    sub dh, 2
    
LIMPA_INDICADOR:
    call POS_CURSOR
    mov cl, dl
    sub dh, 2
    mov dl, 32
    call ESC_CHAR
    mov dl, 26
    add dh, 2
    call POS_CURSOR
    mov dl, 32
    call ESC_CHAR
    
    mov dx, cx
    call POS_CURSOR
    
    mov dl, 91
    call ESC_CHAR
    mov dl, 26
    call POS_CURSOR
    mov dl, 93
    CALL ESC_CHAR
    
    mov dl, 31
    call POS_CURSOR
    
    pop cx
    pop dx
    ret
    endp
    
    ; Funcao destinada ao menu inicial, retorna a opcao selecionada (jogar ou sair)
    SOLICITAR_OPCAO proc
    push ax
    mov dh, 16
    mov dl, 14
    call INDICADOR_OPCAO
    
LER_TECLA:
    mov dl, 14
    call LER_KEY
    ; Compara se o usuario apertou a arrow down
    cmp ah, 80
    je DOWN_ARROW
    ; Compara se o usuario apertou a arrow up
    cmp ah, 72
    je UP_ARROW
    
    cmp ah, 28
    je FIM_SOLICITAR_OPCAO
    
    jmp LER_TECLA
UP_ARROW:
    cmp dh, 16
    jbe LER_TECLA
    
    sub dh, 2
    jmp FIM_LER_TECLA
    
DOWN_ARROW:
    cmp dh, 18
    jae LER_TECLA
    
    add dh, 2
    
FIM_LER_TECLA:
    call INDICADOR_OPCAO
    jmp LER_TECLA
    
FIM_SOLICITAR_OPCAO:
    pop ax
    ret
    endp
    
    ; Funcao do menu inicial do jogo
    TELA_INICIAL proc
    ; PRINTA LOGO JOGO
    mov bl, 2                    ; cor
    mov dh, 0                    ; linha
    mov dl, 0                    ; coluna
    mov bp, offset logo_inicio
    call ESC_STRING
    
    ; Printa desenhos do menu
    
    mov si, offset desenho_nave
    mov di, 28560                ; posicao na tela
    call DESENHA_ELEMENTO
    
    mov si, offset desenho_asteroid
    mov di, 28610                ; posicao na tela
    call DESENHA_ELEMENTO
    
    mov si, offset desenho_shield
    mov di, 28660                ; posicao na tela
    call DESENHA_ELEMENTO
    
    mov si, offset desenho_cura
    mov di, 28710                ; posicao na tela
    call DESENHA_ELEMENTO
    
    ; PRINTA BOTOES JOGAR E SAIR
    mov bl, 15                   ; cor
    mov dh, 16                   ; linha
    mov dl, 18                   ; coluna
    mov bp, offset botao_start
    call ESC_STRING
    add dh, 2                    ; linha
    mov bp, offset botao_exit
    call ESC_STRING
    
    ; Chama proc para escolher opcao
    call SOLICITAR_OPCAO
    
    ; Compara se a linha selecionada foi a 18 (SAIR)
    cmp dh, 18
    je FIM_TELA_INICIAL
    ; Compara se a linha selecionada foi a 16 (JOGAR)
    cmp dh, 16
    je CHAMA_INICIO
    jmp FIM_TELA_INICIAL
    
CHAMA_INICIO:
    call INICIAR_JOGO
FIM_TELA_INICIAL:
    call FIM_PROGRAMA
    ret
    endp
    
    ; Funcao para gerar a tela final do jogo
    ; bp = Escrita de Vitoria ou Derrota
    ; al = cor do fundo
    TELA_POS_JOGO proc
    push ax
    push bx
    push cx
    push dx
    
    mov cx, 200
    mov di, 0
    
LOOP_PINTA_TELA_POS_JOGO:
    mov dx, 320
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
    mov bl, 0fh                  ; cor
    mov dh, 2                    ; linha
    mov dl, 0                    ; coluna
    call ESC_STRING
    
    mov bl, 15                   ; cor
    mov dh, 16                   ; linha
    mov dl, 17                   ; coluna
    mov bp, offset botao_restart
    call ESC_STRING
    
    mov dl, 18                   ; coluna
    add dh, 2                    ; linha
    mov bp, offset botao_exit
    call ESC_STRING
    
    ; Chama proc para escolher opcao
    call SOLICITAR_OPCAO
    cmp DH, 18
    je FIM_TELA_POS_JOGO
    cmp DH, 16
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
    
    
    ; Funcao destinada a inicializar o jogo
    INICIAR_JOGO proc
    push ax
    push bx
    push si
    push di
    call ZERAR_ASTEROIDES_ATIVOS
    call RESETA_BARRA_DE_TEMPO
    ; Reseta as variaveis do jogo
    mov vida, 10
    mov jogando, 1
    mov vida_acabou, 0
    mov enviar_shield, 0
    mov num_asteroides_ativos, 0
    mov timer_plot_ast, 0
    mov nivel, 1
    ; Seta o clock do nivel 1
    mov si, offset velocidades_niveis
    mov ax, [si]
    mov clock_jogo, ax
    ; Escreve os elementos principais da tela de jogo
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
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao para reinicio do jogo, ela zera o vetor de asteroides
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
    
    ; Realiza o calculo para transformar os valores de linha em coluna na posicao correta na memoria de video
    ;si posicao da memoria (coluna)
    ;cx deslocamento, vetor de asteroides ou ajuda
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
    
    ; Funcao para escrever uma barra da HUD do jogo
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
    mov dx, 20                   ; altura da barra principal
    
LOOP_HUD_FUNDO:
    mov al, 8                    ; cor cinza
    mov cx, 320                  ; numero de colunas
    rep stosb
    dec dx
    cmp dx, bx
    jne LOOP_HUD_FUNDO
    
    call BARRA_DE_VIDA
    call RESETA_BARRA_DE_TEMPO
    
    
    mov dx, 10                   ; altura
    mov di, posicao_barra_nivel
    mov al, 0                    ; cor da barra
    mov cx, 10                   ; comprimento da barra
    
    call PRINT_BARRA_HUD
    
    mov dx, 2                    ; altura
    mov di, posicao_nivel_um
    mov al, 0eh                  ; cor da barra
    mov cx, 10                   ; comprimento da barra
    
    call PRINT_BARRA_HUD
    
    ret
    endp
    
    
    ; Funcao para reiniciar o timer do jogo e a barra do timer
    RESETA_BARRA_DE_TEMPO proc
    push ax
    push bx
    push cx
    push dx
    
    mov si, offset divisores_niveis
    mov ax, nivel
    dec ax
    mov bx, 2
    xor dx, dx
    mul bx
    mov cx, ax
    
    add si, cx
    mov cx, [si]
    xor dx, dx
    mov ax, timer_do_jogo
    mul cx
    mov timer, ax
    
    
    mov dx, 10                   ; altura
    mov di, posicao_barra_tempo
    mov al, 0bh                  ; cor da barra
    mov cx, 130                  ; comprimento da barra
    
    call PRINT_BARRA_HUD
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao para restaurar a barra de vida do jogador
    BARRA_DE_VIDA proc
    push ax
    push bx
    push cx
    push dx
    
    mov vida, 10
    mov dx, 10                   ; altura
    mov di, posicao_barra_vida
    mov al, 2                    ; cor da barra
    mov cx, 130                  ; comprimento da barra
    
    call PRINT_BARRA_HUD
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
    endp
    
    
    
    
    ; Funcao para pintar de preto a barra do tempo a cada segundo
    BARRA_TEMPO_JOGO proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    mov cx, nivel
    
    mov si, offset divisores_niveis
    mov ax, nivel
    dec ax
    mov cx, 2
    xor dx, dx
    mul cx
    mov cx, ax
    
    add si, cx
    mov cx, [si]
    
    xor dx, dx
    mov ax, timer
    dec ax
    mov timer, ax
    push ax
    div cx
    
    mov bx, timer_do_jogo
    
    cmp bx, 65
    ja SEM_MULTIPLICACAO
    
    xor dx, dx
    mov cx, 2
    mul cx
SEM_MULTIPLICACAO:            ; caso utilize valores maiores que 65s, ira pintar apenas 1px de cada vez
    mov di, posicao_barra_tempo
    add di, ax
    mov cx, 130
    sub cx, ax
    mov dx, 10                   ; altura
    mov al, 0                    ; cor da barra
    call PRINT_BARRA_HUD
    pop ax
    cmp ax, 0
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
    
    
    ; Funcao destinada a mover a nave para cima
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
    
    ;Funcao destinada a mover a nave para baixo
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
    add di, 2880                 ; inicio da ultima linha da nave
    add si, 2880                 ; inicio da linha de baixo da nave
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
    
    
    ;Funcao destinada a checar a tecla digitada e direcionar a nave para as proc de mover
    ; para cima, baixo e checa a barra de espaco para atirar
    CHECA_MOVIMENTO_NAVE proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ah, 01h
    int 16h
    jz FIM_MOVIMENTO_NAVE
    call LER_KEY
    
    ; Compara se o usuario apertou a arrow down
    cmp ah, 80
    jz MOVER_PARA_BAIXO
    ; Compara se o usuario apertou a arrow up
    cmp ah, 72
    jz MOVER_PARA_CIMA
    ; Compara se o usuario apertou a barra de espaco
    cmp al, 32
    jz ATIRAR
    jmp FIM_MOVIMENTO_NAVE
    
MOVER_PARA_CIMA:
    cmp posicao_atual_nave, 474
    jz FIM_MOVIMENTO_NAVE
    call MOVE_NAVE_CIMA
    jmp FIM_MOVIMENTO_NAVE
    
    
MOVER_PARA_BAIXO:
    cmp posicao_atual_nave, 54234
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
    
    ; Funcao que cria o tiro na tela de jogo
    CRIA_TIRO proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    mov si, offset posicao_atual_tiro
    mov ax, posicao_atual_nave
    
    mov bx, 166                  ; 154 (coluna nave) + 12 (espa?amento para sair o tiro)
    mov [si], bx                 ; armazena coluna do tiro
    
    sub ax, 154
    mov cx, 320
    xor dx, dx
    div cx
    add ax, 5                    ; deslocamento para centralizar o tiro
    add si, 2
    mov [si], ax                 ; armazena linha do tipo
    
    xor dx, dx
    
    mov bx, 320
    mul bx
    mov bx, ax
    sub si, 2
    mov ax, [si]
    add ax, bx
    
    mov di, ax
    mov dx, 0fh
    
    mov ax, memoria_video
    mov ds, ax
    mov cx, 10
    
    mov [di], dx
    
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
    
    ; Funcao que remove o tiro da tela de jogo
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
    xor dx, dx
    mul bx
    mov bx, ax
    sub si, 2
    mov ax, [si]
    add ax, bx
    mov di, ax
    mov ax, memoria_video
    mov ds, ax
    xor dx, dx
    mov [di], dx
    
    mov ax, @data
    mov ds, ax
    
    mov ax, [si]
    
    mov [si], dx
    add si, 2
    mov [si], dx
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao que move o tiro para a direita
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
    
    sub si, 2
    
    mov cx, 2
    call CALCULA_POSICAO_DE_VIDEO
    
    xor dx, dx
    mov bx, 0fh
    mov ax, memoria_video
    mov ds, ax
    mov cx, 10
    
    mov [di], dx
    inc di
    mov [di], bx
    
    mov ax, @data
    mov ds, ax
    
    mov ax, [si]
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
    
    ; Funcao que checa a colisao do tiro com outro objeto
    ; dx - deslocamento (desl_vet_asteroid ou 2)
    ; si - endereco coluna objeto na memoria
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
    
    
    ; Funcao para limpar o buffer do teclado (utiliza a interrupcao 16h)
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
    
    
    ; Funcao que gera um numero aleatorio
    GERA_NUMERO_ALEATORIO proc
    push dx
    mov ah, 2Ch                  ; Hora da bios
    int 21h
    mov ax, dx                   ; Move para ax os ms retornados da interrupcao em dl
    pop dx
    ret
    endp
    
    
    
    ; Funcao que verifica se um objeto esta sendo plotado em cima de um asteroide ja existente
    ; DX: 0 se houve sobreposicao ou retorna o valor inicial de dx
    VERIFICA_SOBREPOSICAO proc
    push ax
    push cx
    push si
    push di
    push bx
    ;dx LINHA DO POSSIVEL SPAWN
    
    mov si, offset asteroides
    mov cx, quantidade_asteroides
LOOP_VERIFICA_SOBREPOSICAO:
    mov ax, [si]
    cmp ax, 277
    jb FIM_LOOP_SOBREPOSICAO
    add si, desl_vet_asteroid
    mov ax, [si]
    sub ax, 10
    sub si, desl_vet_asteroid
    cmp dx, ax
    jb FIM_LOOP_SOBREPOSICAO
    add ax, 20
    cmp dx, ax
    ja FIM_LOOP_SOBREPOSICAO
    xor dx, dx
    jmp FINAL_CHECA_SOBREPOSICAO
FIM_LOOP_SOBREPOSICAO:
    add si, 2
    loop LOOP_VERIFICA_SOBREPOSICAO
    
FINAL_CHECA_SOBREPOSICAO:
    pop bx
    pop di
    pop si
    pop cx
    pop ax
    ret
    endp
    
    ;Funcao que plota um objeto na extrema direita da tela.
    ;SI: RECEBE O OFFSET DO DESENHO (asteroide, shield ou cura)
    ;Retonar linha do objeto em dx
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
    call VERIFICA_SOBREPOSICAO
    cmp dx, 0
    je FIM_PRINTA_OBJETO_DIREITA
    mov ax, dx                   ; Retorno da linha em DX
    push dx
    mov bx, 320                  ; linha * 320
    mul bx
    mov bx, 308                  ; coluna 308
    add ax, bx
    xor di, di
    mov di, ax
    pop dx
    call DESENHA_ELEMENTO
FIM_PRINTA_OBJETO_DIREITA:
    pop bx
    pop di
    pop si
    pop cx
    pop ax
    ret
    endp
    
    ; Funcao para verificar se precisa enviar uma cura(utiliza a proc geral PRINTA_OBJETO_DIREITA)
    VERIFICA_CURA proc
    push ax
    push bx
    push dx
    push si
    push di
    mov cx, 0
    mov ax, vida
    cmp ax, 5
    ja FINAL_VERIF_CURA
    
    mov si, offset desenho_cura
    call PRINTA_OBJETO_DIREITA
    cmp dx, 0
    je FINAL_VERIF_CURA
    mov si, offset posicao_cura
    mov [si], 308
    add si, 2
    mov [si], dx
    mov enviar_cura, 0
    mov plotar_cura, 0
    mov cx, 1
    
FINAL_VERIF_CURA:
    pop di
    pop si
    pop dx
    pop bx
    pop ax
    ret
    endp
    
    
    
    ; Funcao para plotar um escudo na tela (utiliza a funcao PRINTA_OBJETO_DIREITA)
    PLOTAR_SHIELD proc
    push ax
    push si
    push dx
    mov cx, 0
    mov ax, timer_plot_shield
    cmp ax, 0
    jne FIM_PLOTAR_SHIELD
    mov si, offset desenho_shield
    call PRINTA_OBJETO_DIREITA
    call RESET_TIMER_ESCUDO
    cmp dx, 0
    je FIM_PLOTAR_SHIELD
    mov si, offset posicao_shield
    mov [si], 308
    add si, 2
    mov [si], dx
    mov cx, 1
FIM_PLOTAR_SHIELD:
    pop dx
    pop si
    pop ax
    ret
    endp
    
    ; Funcao para plotar um asteroide na tela (utiliza a funcao PRINTA_OBJETO_DIREITA)
    PLOTAR_ASTEROIDE_NOVO proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
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
    cmp dx, 0
    je FINAL_PLOTA_NOVO_ASTEROIDE
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
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao para verificar se eh hora de enviar um novo objeto na tela
    ; e define prioriza os objetos a serem plotados na tela
    ; Primeiro cura, depois escudo e por fim o escudo
    PLOTA_NOVO_OBJETO proc
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
    je FINAL_PLOTA_NOVO_OBJETO
    
    mov timer_plot_ast, ax
    
    cmp enviar_shield, 0
    je PLOTAR_CURA_VIDA
    call PLOTAR_SHIELD
    cmp cx, 1
    je FINAL_PLOTA_NOVO_OBJETO
    
PLOTAR_CURA_VIDA:
    mov ax, plotar_cura
    cmp ax, 0
    jz PLOTAR_ASTEROIDE
    call VERIFICA_CURA
    cmp cx, 1
    je FINAL_PLOTA_NOVO_OBJETO
    
PLOTAR_ASTEROIDE:
    call PLOTAR_ASTEROIDE_NOVO
    
FINAL_PLOTA_NOVO_OBJETO:
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao para mover um objeto 1px para a esqueda
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
    
    ; Funcao que remove pontos de vida caso haja colisao
    ; com um asteroide
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
    cmp enviar_cura, 1
    jne NAO_ENVIAR_AJUDA
    
    mov si, offset posicao_cura
    add si, 2
    mov bx, [si]
    cmp bx, 0
    jne NAO_ENVIAR_AJUDA
    
    mov plotar_cura, 1
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
    
    ; Funcao para checar se um objeto colidiu com a nave
    ; si recebe coluna do objeto
    ; cx recebe deslocamento (asteroide ou ajuda)
    CHECA_COLISAO proc
    push ax
    push cx
    push dx
    push si
    push di
    
    xor bx, bx
    xor dx, dx
    
    cmp ax, 164                  ; coluna da nave (154) + 10 (pixel da direita)
    ja FINAL_CHECA_COLISAO
    cmp ax, 144                  ; coluna da nave (154) - 10 (pixel da esquerda)
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
    
    
    ; Funcao para apagar o asteroide
    ;si recebe asteroide
    APAGA_OBJETO proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    push cx
    call CALCULA_POSICAO_DE_VIDEO
    
    call REMOVE_DESENHO
    pop cx
    xor ax, ax
    mov [si], ax
    add si, cx
    mov [si], ax
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
    endp
    
    ; funcao para checagem dos asteroides
    CHECA_ASTEROIDE proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov si, offset asteroides
    mov cx, quantidade_asteroides
    
LOOP_CHECAGEM_ASTEROIDES:
    xor ax, ax
    xor dx, dx
    add si, desl_vet_asteroid
    mov ax, [si]
    sub si, desl_vet_asteroid
    cmp ax, 0
    jz FIM_LOOP_CHECAGEM_ASTEROIDES
    
    mov ax, [si]
    cmp ax, 0
    jz REMOVER_ASTEROIDE
    push cx
    mov cx, desl_vet_asteroid
    call CHECA_COLISAO
    pop cx
    cmp bx, 1
    jz COLISAO_COM_ASTEROIDE
    
    push cx
    mov cx, desl_vet_asteroid
    call CALCULA_POSICAO_DE_VIDEO
    pop cx
    
    push si
    mov si, di
    call MOVE_OBJETO
    pop si
    
    mov ax, [si]
    dec ax
    mov [si], ax
    
    jmp TESTE_COLISAO_COM_TIRO
    
COLISAO_COM_ASTEROIDE:
    cmp imune, 1
    je REMOVER_ASTEROIDE
    call TOMAR_DANO
REMOVER_ASTEROIDE:
    push cx
    mov cx, desl_vet_asteroid
    call APAGA_OBJETO
    pop cx
    
    mov ax, num_asteroides_ativos
    dec ax
    mov num_asteroides_ativos, ax
    jmp FIM_LOOP_CHECAGEM_ASTEROIDES
    
    
TESTE_COLISAO_COM_TIRO:
    
    mov dx, desl_vet_asteroid
    call COLISAO_TIRO
    cmp dx, 1
    jne FIM_LOOP_CHECAGEM_ASTEROIDES
    
    push cx
    mov cx, desl_vet_asteroid
    call APAGA_OBJETO
    pop cx
    
    mov ax, num_asteroides_ativos
    dec ax
    mov num_asteroides_ativos, ax
    
    
FIM_LOOP_CHECAGEM_ASTEROIDES:
    add si, 2
    loop LOOP_CHECAGEM_ASTEROIDES
    
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    
    ; Funcao para checar o movimento de uma ajuda. Chama a funcao CHECA_COLISAO para checagem da colisao
    ;si = posicao_curao ou posicao_escudo
    ;dx = 1 (colisao)
CHECA_AJUDA:
    push ax
    push bx
    push cx
    push di
    push si
    xor dx, dx
    
    mov ax, [si]
    cmp ax, 0
    jne REMOVER_AJUDA
    add si, 2
    mov ax, [si]
    cmp ax, 0
    je FIM_CHECA_AJUDA
    
    sub si, 2
    
    mov cx, 2
    
    call APAGA_OBJETO
    
    jmp FIM_CHECA_AJUDA
    
REMOVER_AJUDA:
    
    mov cx, 2
    
    call CHECA_COLISAO
    cmp bx, 1
    
    jne MOVER_AJUDA
    
    mov cx, 2
    call APAGA_OBJETO
    mov dx, 1
    
    jmp FIM_CHECA_AJUDA
    
MOVER_AJUDA:
    mov cx, 2
    call CALCULA_POSICAO_DE_VIDEO
    mov cx, [si]
    push si
    mov si, di
    call MOVE_OBJETO
    pop si
    
    dec cx
    mov [si], cx
    mov dx, 2
    call COLISAO_TIRO
    cmp dx, 1
    jne FIM_CHECA_AJUDA
    dec di
    
    mov cx, 2
    call APAGA_OBJETO            ; remove a ajuda caso haja colisao
    
    xor dx, dx
FIM_CHECA_AJUDA:
    pop di
    pop si
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    ; Funcao que checa o movimento dos objetos (funcao que chama a proc CHECA_AJUDA e CHECA_ASTEROIDE para cada elemento do programa)
    CHECA_MOVIMENTO_OBJETO proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov si, offset posicao_cura
    call CHECA_AJUDA
    
    cmp dx, 1
    jne CHECA_MOV_SHIELD
    call BARRA_DE_VIDA
    
    
CHECA_MOV_SHIELD:
    
    mov si, offset posicao_shield
    call CHECA_AJUDA
    
    cmp dx, 1
    jne CHECAGEM_ASTEROIDES
    call DEIXAR_NAVE_IMUNE
    
CHECAGEM_ASTEROIDES:
    call CHECA_ASTEROIDE
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    ; Funcao para passar as fases do jogo
    PASSAR_NIVEL proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ax, nivel
    inc ax
    mov nivel, ax
    cmp ax, nivel_maximo
    ja VENCEU_JOGO
    call RESETA_BARRA_DE_TEMPO
    call RESET_TIMER_ESCUDO
    xor dx, dx
    dec ax
    mov cx, 2
    mul cx
    mov si, offset velocidades_niveis
    add si, ax
    mov cx, [si]
    mov clock_jogo, cx
    
    mov enviar_cura, 1
    mov enviar_shield, 1
    
    mov bx, posicao_nivel_um
    mov cx, 320
    mul cx
    sub bx, ax
    
    mov dx, 2                    ; altura
    mov di, bx
    mov al, 0eh                  ; cor da barra
    mov cx, 10                   ; comprimento da barra
    
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
    
    ; Funcao para resetar o timer que calcula o cooldown de nascimento dos escudos
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
    
    ; Funcao para controlar os timers relacionados ao escudo (chama a proc TIMER_IMUNIDADE)
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
    call TIMER_IMUNIDADE
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    endp
    
    
    ; Funcao que testa e atualiza o tempo de imunidade da nave
    TIMER_IMUNIDADE proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    cmp imune, 0
    je FIM_TIMER_IMUNIDADE
    cmp timer_imunidade_nave, 0
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
    
    ; Funcao que atribui as caracteristicas de imunidade para a nave
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
    
    
    ;Funcao para bloqueia a execucaoo do programa dependendo do clock do jogo
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
    
    ; Funcao para finalizar o programa
    FIM_PROGRAMA proc
    mov ah, 4ch
    mov al, 0
    int 21h
    ret
    endp
    
    ; Proc de LOOP do jogo em funcionamento
    EM_JOGO proc
LOOP_JOGO:
    call TIMER_ESCUDO
    call BARRA_TEMPO_JOGO
    call CHECA_MOVIMENTO_NAVE
    call LIMPA_BUFFER_TECLADO
    call PLOTA_NOVO_OBJETO
    call CHECA_MOVIMENTO_OBJETO
    call MOVER_TIRO
    call BLOQUEIA_EXECUCAO_PROGRAMA
    mov bx, jogando
    cmp bx, 1
    je LOOP_JOGO
    
    mov al, 4
    mov bp, offset logo_perdeu
    call TELA_POS_JOGO
    
    ret
    endp
    
    ; Funcao principal (inicio do programa)
inicio:
    mov ax, @data
    mov ds, ax
    mov ax, memoria_video
    mov es, ax
    call MODO_DE_VIDEO
    call TELA_INICIAL
    
    end inicio
