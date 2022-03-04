assume cs:codesg,ss:stacksg,ds:datasg

stacksg segment
    dw 0,0,0,0,0,0,0,0
stacksg ends
; 将下列字符串前4个字符转为大写
datasg segment
    db '1. display......'
    db '2. brows........'
    db '3. replace......'
    db '4. modify.......'
datasg ends

codesg segment
    start:
            mov     ax,stacksg
            mov     ss,ax
            mov     sp,16

            mov     ax,datasg
            mov     ds,ax

            mov     cx,4
            mov     bx,0 ; bx 记录行数
    s:      push    cx
            mov     cx,4
            mov     di,0 ; di 记录列数
    s1:     mov     al,[bx][di].3 ; 注意第一个只能是bx
            and     al,11011111b
            mov     [bx][di].3,al
            inc     di
        loop    s1
            pop     cx
            add     bx,16
        loop    s
            mov     ax,4c00h
            int     21h

codesg ends

end start