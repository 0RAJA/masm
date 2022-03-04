; 复制字符串
assume cs:code,ds:data

data segment
    db 'welcome to masm'
    db 'enter your name'
data ends

code segment
    start:
        mov ax,data
        mov ds,ax
        mov si,0
        mov cx,8 
    s:  mov di,0[si]
        mov [si].15,di
        add si,2
    loop s

        mov ax,4c00h
        int 21h
code ends

end start