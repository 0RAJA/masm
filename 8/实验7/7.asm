assume cs:code,es:table,ss:stack

data segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'

    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
data ends

table segment
    db 336 dup (0) ;为了方便看(都是0)
table ends

stack segment
    db 16 dup (0) ;存放临时变量的栈
stack ends

code segment
    start:  mov     ax,stack
            mov     ss,ax
            mov     sp,16

            mov     ax,data
            mov     ds,ax
            
            mov     ax,table
            mov     es,ax

            mov     bx,0 ; year offset (add bx,2)
            mov     si,0 ; summ offset (add si,4)
            mov     di,0 ; ne offset (add di,2)
            mov     bp,0 ; ?? offset (add 5,5,3,3)
            
            mov     cx,21 ;循环次数
        s:  mov     ax,ds:[bx] ;复制年份
            mov     es:[bp],ax
            mov     ax,ds:[bx].2
            mov     es:[bp].2,ax
            add     bp,5

            mov     ax,ds:[si].84 ;复制收入 同时把低8位放到ax，高8位放入dx，为之后的div做准备
            mov     es:[bp],ax
            mov     dx,ds:[si].86
            mov     es:[bp].2,dx
            add     bp,5
            push    ax  ;ax在之后还充当了中间变量，所以保存下其值
            
            mov     al,ds:[di].168 ;复制员工数
            mov     es:[bp],al
            add     bp,3

            pop     ax             ;计算均值
            push    cx
            mov     cx,ds:[di].168 
            div     cx             ;32位/16位 (dx<<4+ax)/(cx) -> 商:ax 余数:dx ;16位/8位 (ax)/(cx) -> 商:al,余数:ah
            pop     cx             ;恢复下循环次数
            mov     es:[bp],ax
            
            add     bx,4           ;增加对应的offset
            add     si,4
            add     di,2
            add     bp,3
            loop    s              ;循环21次
            
            mov     ax,4c00h       ;结束
            int     21h
code ends

end start