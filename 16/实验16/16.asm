assume cs:code

code segment
    sub1:       push    es
                push    bx
                push    cx
    sub1st:     mov     bx,0b800h
                mov     es,bx
                mov     cx,2000
                mov     bx,0
    sub1s:      mov byte ptr es:[bx],' '
                add     bx,2
                loop    sub1s
    sub1ed:     pop     cx
                pop     bx
                pop     es
                ret
    sub2:       push    es
                push    bx
                push    cx
    sub2st:     mov     bx,0b800h
                mov     es,bx
                mov     cx,2000
                mov     bx,1
    sub2s:      and byte ptr es:[bx],11111000b
                or      es:[bx],al
                add     bx,2
                loop    sub2s
    sub2ed:     pop     cx
                pop     bx
                pop     es
                ret
    sub3:       push    es
                push    bx
                push    cx
    sub3st:     mov     bx,0b800h
                mov     es,bx
                mov     cx,2000
                mov     bx,1
    sub3s:      and byte ptr es:[bx],10001111b
                or      es:[bx],al
                add     bx,2
                loop    sub3s
    sub3ed:     pop     cx
                pop     bx
                pop     es
                ret
    sub4:       push    es
                push    cx
                push    bx
                push    di
                push    ax
    sub4st:     mov     bx,0b800h
                mov     es,bx
                mov     cx,24*80
                mov     bx,0
                mov     di,160
    sub4s:      mov     ax,es:[bx][di]
                mov     es:[bx],ax
                add     bx,2
                loop    sub4s
                mov     cx,160
    sub4s1:     mov byte ptr es:[bx],' '
                inc     bx
                loop    sub4s1
    sub4ed:     pop     ax
                pop     di
                pop     bx
                pop     cx
                pop     es
                ret
    setscreen:  jmp     setst
    table:      dw sub1,sub2,sub3,sub4 ;ah 0,1,2,3
    setst:      push    bx
                cmp     ah,3
                ja      seted
                mov     bl,ah
                mov     bh,0
                add     bx,bx
                call word ptr table[bx]
    seted:      pop     bx
                iret
    ed:        nop
    start:      mov ax,cs
                mov ds,ax
                mov si,offset sub1
                mov ax,0
                mov es,ax
                mov di,200h
                mov cx,offset ed-offset sub1
                cld
                rep movsb

                mov ax,0
                mov es,ax
                mov es:[7ch*4],200h
                mov es:[7ch*4+2],0

                mov     ah,1
                mov     al,11000010b
                call    setscreen
                int     7ch
                mov     ax,4c00h
                int     21h
code ends
end start