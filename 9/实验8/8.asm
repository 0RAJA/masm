assume cs:code

code segment
            mov     ax,4c00h ; 0000
            int     21h
    start:  mov     ax,0
    s:      nop              ; 这里之后会变成 jmp 0000 ，因为jmp编译后的汇编代码是相对当前IP移动的字节数，所以直接复制就会相对应上移对应字节数
            nop

            mov     di,offset s
            mov     si,offset s2
            mov     ax,cs:[si]
            mov     cs:[di],ax

    s0:     jmp short s
    s1:     mov     ax,0
            int     21h
            mov     ax,0
    s2:     jmp short s1
            nop
code ends

end start