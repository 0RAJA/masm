assume cs:code

stack segment
    db 128 dup (0)
stack ends

data segment
    dw 0,0
data ends

code segment
    start:          mov     ax,stack
                    mov     ss,ax
                    mov     sp,128

                    mov     ax,data
                    mov     ds,ax

                    mov     ax,0
                    mov     es,ax

                    push    es:[9*4]    ;保存int9的内容到ds:[0] ds:[2]
                    pop     ds:[0]
                    push    es:[9*4+2]
                    pop     ds:[2]

                    mov word ptr es:[4*9],offset int9   ;更换int9地址
                    mov word ptr es:[4*9+2],cs

                    mov     ax,0b800h
                    mov     es,ax
                    mov     ah,'a'
    s:              mov     es:[160*12+40*2],ah
                    call    delay
                    inc     ah
                    cmp     ah,'z'
                    jna     s
                    
                    mov     ax,0        ;恢复int9原来的地址
                    mov     es,ax
                    push    ds:[0]
                    pop     es:[4*9]
                    push    ds:[2]
                    pop     es:[4*9+2]

                    mov     ax,4c00h
                    int     21h
    delay:          push    ax
                    push    dx
                    mov     dx,15h
                    mov     ax,0
    s1:             sub     ax,1
                    sbb     dx,0
                    cmp     ax,0
                    jne     s1
                    cmp     dx,0
                    jne     s1
                    pop     dx
                    pop     ax
                    ret
    int9:           push    ax
                    push    bx
                    push    es

                    in      al,60h  ;接受输入

                    pushf                   ;标志寄存器入栈; IF TF = 0            
                    call dword ptr ds:[0]   ;模拟中断 
                    cmp     al,1            ;ESC
                    jne     int9end
                    mov     ax,0b800h
                    mov     es,ax
                    xor byte ptr es:[160*12+40*2+1],1  
    int9end:        pop     es
                    pop     bx
                    pop     ax
                    iret         
code ends
end start