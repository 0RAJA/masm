assume cs:code

code segment
    ; 说明：将一个全是字母的以0结尾的字符串全部大写化
    ; 参数：ds:[si]指向字符串首地址
    ; 返回值：无
    capital:        push    cx ;保存外界寄存器内容
                    push    si

    change:         mov     cl,[si]
                    mov     ch,0
                    jcxz    ok
                    and byte ptr [si],11011111b
                    inc     si
                    jmp     change

    ok:             pop     cx
                    pop     si
                    ret
code ends
end