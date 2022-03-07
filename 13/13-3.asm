;iret 改变CS:IP 来实现loop功能
assume cs:code

code segment
    start:      
                mov di,cs
                mov ds,di
                mov si,offset lp 
                mov di,0
                mov es,di
                mov di,200h
                mov cx,offset lpend-offset lp
                cld
                rep movsb

                mov di,0
                mov es,di
                mov es:[7ch*4],200h
                mov es:[7ch*4+2],0
                
                jmp     testmod
    lp:         dec     cx
                jcxz    m
                mov     bp,sp
                add     [bp],bx
    m:          iret
    lpend:      nop
    testmod:    mov     ax,0b800h
                mov     es,ax
                mov     di,160*12
                mov     bx,offset s-offset send ;s相对于IP的差值
                mov     cx,80
    s:          mov byte ptr    es:[di],'!' ;打印
                inc     di
                mov byte ptr    es:[di],02h 
                inc     di
                int     7ch
    send:       nop
                mov     ax,4c00h
                int     21h
code ends

end start