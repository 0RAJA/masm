assume cs:code,ds:data,ss:stack
stack segment
    dd 0,0,0,0,0,0,0,0
stack ends

data segment
    db 10 dup (0)
data ends

code segment
    start:          mov     ax,12666
                    mov     bx,data
                    mov     ds,bx
                    mov     bx,stack
                    mov     ss,bx
                    mov     bx,32
                    mov     sp,bx
                    
                    mov     si,0
                    call    dtoc

                    mov     dh,24
                    mov     dl,0
                    mov     cl,2
                    call    show_str

                    mov     ax,4c00h
                    int     21h
    ;将word型数据转换位表示10进制的字符串并以0结尾
    ;（ax）= word型数据,ds:si 指向字符串的首地址。
    dtoc:           push    bx  ;保存寄存器值
                    push    cx
                    push    dx
                    push    di
                    push    si
                    mov     dx,0
                    mov     di,0

    change1:        mov     cx,ax
                    jcxz    s1
                    mov     bl,10
                    mov     bh,0
                    div     bx
                    push    dx  ;将余数入栈
                    mov     dx,0
                    inc     di  ;记录位数
                    jmp     change1
                    
    s1:             mov     cx,di ;出栈的次数
    s2:             pop     ax
                    mov     ds:[si],al
                    add     ds:[si],30h
                    inc     si
                    loop    s2
                    mov     ds:[si],0

                    pop     si ;恢复寄存器值
                    pop     di
                    pop     dx
                    pop     cx
                    pop     bx
                    ret
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
    change2:        mov     al,dh      ;计算偏移值(bx = dh*A0h+dl*2),然后每次在此基础上+2即可
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