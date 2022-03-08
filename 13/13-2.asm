;安装7ch中断例程
assume cs:code

code segment
    start:      mov ax,cs
                mov ds,ax
                mov si,offset sqr
                mov ax,0
                mov es,ax
                mov di,200h
                mov cx,offset sqrend-offset sqr
                cld
                rep movsb

                mov ax,0
                mov es,ax
                mov es:[7ch*4],200h
                mov es:[7ch*4+2],0
                jmp testmod
    sqr:        mul ax
                iret ;pop IP;pop CS
    sqrend:     nop
    testmod:    mov ax,3456
                int 7ch
                add ax,ax
                adc dx,dx
                mov ax,4c00h
                int 21h
code ends

end start