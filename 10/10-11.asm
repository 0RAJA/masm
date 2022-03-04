assume cs:code,ds:data

data segment
    db 'test'
data ends

code segment
    start:      mov     ax,data
                mov     ds,ax
                mov     si,0
                mov     cx,4
                call    capital

                mov     ax,4c00h
                int     21h
    ; 参数si表示偏移量，cx循环次数。结果：小写变大写。
    capital:    and byte ptr [si],11011111b
                inc     si
                loop    capital
                ret
code ends

end start