assume cs:code,ds:data

data segment
    db 1,2,3,0,3
data ends

code segment
    start:  mov     ax,data
            mov     ds,ax
            mov     bx,0
    s:      mov     cx,0  
            mov     cl,[bx]
            jcxz    ok
            inc     bx
            jmp short s
    ok:     mov     dx,bx
            mov ax,4c00h
            int 21h 
    
code ends

end start