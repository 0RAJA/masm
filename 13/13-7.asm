;int21h中断例程的显示字符串功能
assume cs:code,ds:data

data segment
    db 'Welcome to Masm!','$'
data ends

code segment
    start:      mov ah,2 ;选择 置光标 子程序
                mov bh,0 ;第0页
                mov dh,5 ;行
                mov dl,12;列
                int 10h
                ;在光标位置处显示字符串(字符串需要以$结尾),ds:[dx]指向字符串
                mov ax,data
                mov ds,ax
                mov dx,0
                mov ah,9 ;选择显示字符串子程序
                int 21h

                mov ax,4c00h
                int 21h
code ends
end start