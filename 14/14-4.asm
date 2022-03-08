;显示当前时间
assume cs:code,ds:data
data segment
    db '024789'
    db '// :: '
data ends

code segment
    start:          mov     ax,data
                    mov     ds,ax
                    mov     bx,0
                    mov     cx,6
    s:              mov     al,ds:[bx]
                    sub     al,'0'
                    call    cal
                    push    ax
                    inc     bx
                    loop    s

                    mov     ax,ds
                    mov     es,ax
                    mov     dh,24 ;行
                    mov     dl,0  ;列
                    mov     cx,6  ;循环次数
    s1:             pop     ax
                    push    cx
                    mov     ch,2    ;颜色
                    mov     cl,ah   ;先输出十位
                    call    print
                    inc     dl
                    mov     cl,al   ;再输出个位
                    call    print
                    inc     dl
                    mov     cl,es:[bx]  ;再输出连接符
                    call    print
                    inc     bx
                    inc     dl
                    pop     cx
                    loop    s1

                    mov     ax,4c00h
                    int     21h
    ;从CMOS RAM中读取一个字节的数据，然后转换为十进制数码
    ;参数:al 读取的单元地址
    ;返回值:ax 为转换后的十进制数码(两位数，高地址表示十位，低地址表示个位)
    cal:            push    cx
    calstart:       out     70h,al
                    in      al,71h

                    mov     ah,al
                    mov     cl,4
                    shr     ah,cl
                    and     al,00001111b

                    add     al,30h
                    add     ah,30h
    calend:         pop     cx
                    ret
    ;显示一个字符
    ;参数: (dh)=行号[0,24] (dl)=列号[0,79] (ch)=颜色 (cl)=字符
    ;返回值:无
    print:          push    cx
                    push    ax
                    push    es
                    push    bx
    printstart:     mov     ax,0b800h
                    mov     es,ax
                    mov     al,dh
                    mov     ah,0A0h
                    mul     ah
                    mov     bx,ax
                    mov     al,dl
                    mov     ah,2
                    mul     ah
                    add     bx,ax
                    mov     es:[bx],cx
    printend:       pop     bx          ;恢复外界寄存器值
                    pop     es
                    pop     ax
                    pop     cx
                    ret
code ends

end start