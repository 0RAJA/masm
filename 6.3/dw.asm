; 数据，代码，栈放到多个段中。
assume cs:code,ds:data,ss:stack

data segment
           dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
data ends

stack segment
            dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stack ends
;076C:0000 23 01 56 04 89 07 BC 0A-EF 0D ED OF BA 0C 87 09
;076C:0010 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00
;O76C:0020 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00

code segment
      start:                   ;初始化寄存器
      
            mov  ax,stack      ;stack == 076Dh
          
            mov  ss,ax
            mov  sp,20h        ;sp == (076Dh+20h) == 078Dh
    
            mov  ax,data       ; data == 076Ch
            mov  ds,ax
            
            mov  bx,0
            mov  cx,8          ;循环次数
      s:    
            push [bx]
            add  bx,2
            loop s

            mov  bx,0
            mov  cx,8
      s0:   pop  [bx]
            add  bx,2
            loop s0
      
            mov  ax,4c00h
            int  21h
code ends

end start