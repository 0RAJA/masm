assume cs:code

code segment
    start:          mov     ax,1000
                    mov     dx,0
                    mov     cx,1
                    call    divdw
                    mov     ax,4c00h
                    int     21h
    ;(ax) = dd数据低16位
    ;(dx) = dd数据高16位
    ;(cx) = 除数
    ;返回值: (dx)=结果高16位，(ax)=结果低16位
    ;       (cx)=余数    
    divdw:          push    bx
    change:         push    ax
                    mov     ax,dx
                    mov     dx,0
                    div     cx
                    mov     bx,ax
                    
                    pop     ax
                    div     cx
                    mov     cx,dx
                    mov     dx,bx
                    ret
code ends

end start