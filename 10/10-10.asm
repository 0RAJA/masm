assume cs:code,ds:data

data segment
    dw 1,2,3,4,5,6,7,8
    dd 0,0,0,0,0,0,0,0
data ends

code segment
    start:      mov     ax,data
                mov     ds,ax
                mov     si,0 ;第一组word单元
                mov     di,16 ;第二组dword单元

                mov     cx,8
    s:          mov     bx,[si]
                call    cube
                mov     [di],ax
                mov     [di].2,dx
                add     si,2
                add     di,4
                loop    s

                mov     ax,4c00h
                int     21h
    ; 计算bx的3次方，结果保存在ax(低)和dx(高)
    cube:       mov     ax,bx  
                mul     bx ;(16位相乘ax*bx ==> 高位在dx 低位在ax)(8位相乘 al*bl ==> 结果在ax)
                mul     bx
                ret
code ends

end start