			area		string2ascii_code ,code
			export string2ascii
			entry
;----------------------------------------------
string2ascii proc 
				stmfd sp!, {r0-r6, lr} 
				ldr	r5, [sp, #32]
				ldr r6, =asc_table	; load asc_table address
;---------------------------------------------				
				cmp r5, #0x0; if the number is 0
				beq	all_zero
				cmp r5, #0x10 ;if the number is between 1~f then branch to
				blt	four_zero
				cmp r5, #0x100 ; 10~ff
				blt	three_zero
				cmp r5, #0x1000 ;100~fff
				blt	two_zero
				cmp r5, #0x10000; 1000~ffff
				blt	one_zero
;---------------------------------------------
						and	r0, r5, #0x000F0000 ; get hex 4
						asr r0, #16 ;						shift right to handle easy
						ldrb r0, [r6,r0]	;				load r0 from [table address + offset]
;		
first_zero			and	r1, r5, #0x0000F000 ; get hex 3
						asr r1, #12;						shit right to handle easy
						ldrb r1, [r6,r1]
;
second_zero	and	r2, r5, #0x00000F00 ; get hex 2
						asr r2, #8
						ldrb r2, [r6,r2]
;				
third_zero		and 	r3, r5, #0x000000F0 ; get hex 1
						asr r3, #4
						ldrb r3, [r6,r3]
;		
fourth_zero		and	r4, r5, #0x0000000F ; get hex 0
						ldrb r4, [r6,r4]
;
everything_zero   stmfd sp!, {r0-r4}
							add sp, #20
							ldmfd sp!,{r0-r6, pc}; subroutine ends here	
;----to make the first '0' strings to '0' not '0x30'---------
all_zero 	mov r0, #0
				mov r1, #0
				mov r2, #0
				mov r3, #0
				mov r4, #0
				b everything_zero
four_zero mov r0, #0
				mov r1, #0
				mov r2, #0
				mov r3, #0
				b fourth_zero
three_zero mov r0, #0
				  mov r1, #0
				  mov r2, #0
				  b third_zero
two_zero	mov r0, #0
				mov r1, #0
				b second_zero
one_zero	mov r0, #0
				b first_zero
;------------------------------------------------
asc_table		; table for string to ascii
	dcb 0x30 ;0
	dcb 0x31;1
	dcb 0x32;2
	dcb 0x33;3
	dcb 0x34;4
	dcb 0x35;5
	dcb 0x36;6
	dcb 0x37;7
	dcb 0x38;8
	dcb 0x39;9
	dcb 0x41;A
	dcb 0x42;B
	dcb 0x43;C
	dcb 0x44;D
	dcb 0x45;E
	dcb 0x46;F
;------------------------------------------------
	endp
	area asciidata, data
	end