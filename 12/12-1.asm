;自定义0号中断
assume cs:code

code segment
    start:      
                ;do0安装程序
                mov     ax,cs ;代码do0源地址
                mov     ds,ax
                mov     si,offset   do0

                mov     ax,0 ;目标地址0:[200h]
                mov     es,ax
                mov     di,200h

                mov     cx,offset do0end-offset do0 ;代码长度

                cld      ;传输方向为正
                rep     movsb     
                
                ;设置中断向量表
                mov     ax,0
                mov     es,ax
                mov word ptr es:[0*4],200h
                mov word ptr es:[0*4+2],0

                ; mov     ax,4c00h
                ; int     21h
                jmp     testdiv

    ;显示字符串           
    do0:        jmp     do0start
                db      'overflow!'
    do0start:   mov     ax,cs
                mov     ds,ax
                mov     si,202h

                mov     ax,0b800h
                mov     es,ax
                mov     di,12*160+36*2

                mov     cx,9
    s:          mov     al,[si]
                mov     es:[di],al
                inc     si
                add     di,2
                loop    s
                
                mov     ax,4c00h
                int     21h
    do0end:     nop
    ;模拟div溢出程序
    testdiv:    mov     ax,1000
                mov     bl,0
                div     bl

                mov     ax,4c00h
                int     21h
                
code ends

end start