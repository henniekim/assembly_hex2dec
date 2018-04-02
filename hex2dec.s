		area hex2dec_code, code
		export	hex2dec
		entry
;------------------------------------
hex2dec proc
				stmfd  sp!,{r0-r7, lr}
				ldr r5, [sp, #36] ; load the hex number from the stack
;------------------------------------
				ldr r7, =10000 
				sdiv r0, r5, r7 ; r5 / r7 = r0 , r0 means the fifth number of decimal number
				mul r6, r0, r7  ; 
				sub r5, r5, r6 ; r5 = r5 - r6 * 10000 // same mechanism below
				;
				ldr r8, =1000 
				sdiv r1, r5, r8
				mul r6, r1, r8
				sub r5, r5, r6
				;
				ldr r8, =100
				sdiv r2, r5, r8
				mul r6, r2, r8
				sub r5, r5, r6
				;
				ldr r8, =10
				sdiv r3, r5, r8
				mul r6, r3, r8
				sub r5, r5, r6
				;
				ldr r8, =1
				sdiv r4, r5, r8
;--------------------------------------				
				lsl r0, #16 ; shift the register to handle easy
				lsl r1, #12
				lsl r2, #8
				lsl r3, #4
				add r0, r0, r1
				add r0, r0, r2
				add r0, r0, r3
				add r0, r0, r4
				push {r0}
				add sp, #4
				ldmfd sp!,{r0-r7,pc}
; add code here
		endp
		end