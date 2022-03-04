assume cs:code,ds:data

data segment
    db 'Welcome to masm!',0
data ends

code segment
    start:          mov     dh,24
                    mov     dl,0
                    mov     cl,2
                    mov     ax,data
                    mov     ds,ax
                    mov     si,0
                    call    show_str
                    
                    mov     ax,4c00h
                    int     21h
    ; 功能：在指定位置用指定颜色显示一个用0结尾的字符串
    ; 参数：(dh)=行号(0~24) (dl)=列号(0~79)
    ;      (cl)=颜色,ds:[si]指向字符串的首地址
    ; 返回值：无
    show_str:       push    ax         ;保存外界寄存器
                    push    es
                    push    bx
                    push    cx

                    mov     ax,0B800h  ;es = 显存首地址
                    mov     es,ax
    change:         mov     al,dh      ;计算偏移值(bx = dh*A0h+dl*2),然后每次在此基础上+2即可
                    mov     ah,0A0h
                    mul     ah
                    mov     bx,ax
                    mov     al,dl
                    mov     ah,2
                    mul     ah
                    add     bx,ax

                    mov     ah,cl       ;保存颜色到ah
    s:              mov     cl,ds:[si]  ;判断是否到达结尾0
                    mov     ch,0
                    jcxz    ok
                    mov     al,ds:[si]  ;保存字符到al
                    mov     es:[bx],ax  ;将ax移动至es:[bx]显存区
                    inc     si          ;移动字符串下标
                    add     bx,2        ;更新偏移值
                    jmp     s           ;循环
    ok:             pop     cx          ;恢复外界寄存器值
                    pop     bx
                    pop     es
                    pop     ax
                    ret
code ends
end start