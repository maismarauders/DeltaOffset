.686
.MODEL FLAT,C
option casemap:none

; Required to make this compile and link with printf on VS2019
includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

; For simplicity we just link to printf
; In real shellcode we would provide a pointer
printf PROTO C :VARARG

.code 

Shellcode_ENTRY PROC PUBLIC
	; Since our data is stored in our code section we need to jmp over it
	jmp @@setup

	; Add additional data here as needed
	display_string db "It's good data but it stores like bad code!", 0ah, 0
@@setup:
	
	; This essentially pops EIP into EBP
	call @@delta
@@delta:
	pop esi

	; Subtract the difference to get a pointer we can use to locate our data
	sub esi, offset @@delta
@@real_start:
	; Using our delta offset load the address of the string into eax
	lea eax, [esi + offset display_string]

	; Push it into the stack
	push eax

	; Display the string
	call printf

	; Fix the stack
	add esp, 4

	; Return
	ret
Shellcode_ENTRY ENDP

END