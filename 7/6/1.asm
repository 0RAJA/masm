assume ds:data,cs:code

data segment
    db 'BaSic' ; toUpper
    db 'minIX' ; toLower
data ends

code segment
    start:  mov ax,data
            mov ds,ax
            mov bx,0
            mov cx,5
    s:      mov al,0[bx] ; [bx+0] is a byte of the first string
            and al,11011111b
            mov 0[bx],al
            mov al,5[bx] ; [bx+5] is a byte of the next string
            and al,11101111b 
            mov 5[bx],al
            inc bx
    loop s
            mov ax,4c00h
            int 21h
code ends

end start