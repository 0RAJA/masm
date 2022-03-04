assume cs:code,ds:data

data segment
	db 'welcome to masm!'
	dw 06e0h,0780h,0820h  ;显存第一页第12、13、14行的起始偏移地址
	db 02h,24h,71h        ;绿色，绿底红字，白底蓝字的属性机器码
data ends

code segment
	
start:	
		mov ax,data
		mov ds,ax		;ds 存放 data 的段地址
		
		mov ax,0B800h   
		mov es,ax		;es 存放显存第一页的段地址
		
		mov bx,0		;bx 存放 样式属性 的相对地址     
		mov bp,0		;bp 存放 行数偏移地址 的相对地址 
		
		mov cx,3		;外层循环3次
		s:	;外层循环，控制行数
		
			push cx
			mov cx,16	;内层循环16次
			mov di,0	;di 存放 data中字符偏移地址
			mov si,64	;si 存放 显存中每行存第一个字符的起始偏移地址
			
			s0:	;内层循环，控制每行的操作
			
				mov ah,ds:[bx+16h]  		;属性字节存放在 ax 高位
				mov al,ds:[di]      		;字符字节存放在 ax 低位
				
				push bx
				mov bx,ds:[bp+10h]
				mov es:[bx+si],ax		;将字符和属性组成的字形数据写入显存
				pop bx
				
				inc di   ;di 指向 data中下一个字符
				add si,2 ;si 指向 显存中下一个字符的存储位置
			loop s0
			pop cx
		
		inc bx			;单行操作结束，bx自增指向下一行的属性
		add bp,2		;单行操作结束，bp自增指向下一行起始偏移地址
		
		loop s
		mov ax,4c00h
		int 21h
		
code ends


end start
