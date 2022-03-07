assume cs:code

code segment
    start:      mov ah,2 ;选择 置光标 子程序
                mov bh,0 ;第0页
                mov dh,5 ;行
                mov dl,12;列
                int 10h

                mov ah,9            ;选择 光标位置显示字符 子程序
                mov al,'a'          ;字符
                mov bl,11001010b    ;颜色属性
                mov bh,0            ;第0页
                mov cx,3            ;字符重复个数
                int 10h

                mov ah,4ch ;程序返回
                mov al,0   ;返回值
                int 21h
code ends
end start