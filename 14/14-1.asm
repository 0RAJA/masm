assume cs:code

code segment
    start:          mov al,2
                    out 70h,al
                    ; in  al,71h ;读取
                    mov al,0
                    out 70h,al ;写入

                    mov ax,4c00h
                    int 21h
code ends
end start