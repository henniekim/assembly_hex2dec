						area		projcode, code
						extern string2ascii
						extern hex2dec
						entry
__main				proc
						export __main [weak]
;-------------------------------------------------------------
						ldr	r0, hexnum
;-------------------------------------------------------------
						push {r0}
						bl string2ascii
						pop {r0}
						sub sp, #56
						ldmfd sp!, {r1-r5}
						add sp, #36
						ldr r6, =hex_string
						str r2, [r6]; hex to ascii complete
						str r3, [r6, #0x01]
						str r4, [r6, #0x02]
						str r5, [r6, #0x03]
;-------------------------------------------------------------
						push {r0}
						bl hex2dec
						pop {r0}
;						
						ldr r0, [sp, #0xFFFFFFD4]
;			
						push {r0}
						bl string2ascii
						pop {r0}
						sub sp, #56
						ldmfd sp!, {r1-r5}; parameter passing
						add sp, #36
						
						ldr r6, =dec_string
						str r1, [r6]; hex to ascii complete
						str r2, [r6, #0x01]
						str r3, [r6, #0x02]
						str r4, [r6, #0x03]
						str r5, [r6, #0x04]
;-------------------------------------------------------------						
here					b			here
						endp
						align
hexnum			dcw		0x70C5
						align
						area		projdata, data
hex_string		space 4
dec_string		space 5
				end
