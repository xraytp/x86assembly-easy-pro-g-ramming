%include "linux64.equ"
%include "printInt.sbr"
%include "crdPrint.mac"

section .data
	fizz db "Fizz"
	buzz db "Buzz"
section .bss
	fbed resb 1
section .text
	global _start

_start:
	mov rcx, 1
	push rcx
_loop:
	pop rax
	push rax
	mov rbx, 3
	mov rdx, 0
	div rbx

	cmp rdx, 0
	jne _noFizz
	crdPrint fizz, 4
	mov rbx, 1 
	mov [fbed], rbx
_noFizz:
	pop rax
	push rax
	mov rbx, 5
	mov rdx, 0
	div rbx

	cmp rdx, 0
	jne _noBuzz
	crdPrint buzz, 4
	mov rbx, 1 
	mov [fbed], rbx
_noBuzz:
	mov rbx, [fbed]
	cmp rbx, 1
	je _fizzbuzzed
	
	pop rax
	push rax
	call _printInt
_fizzbuzzed:
	mov rbx, 0
	mov [fbed], rbx

	mov rax, 10
	push rax
	crdPrint rsp, 1
	pop rax

	pop rcx
	inc rcx
	cmp rcx, 101
	je _exit
	push rcx
	jmp _loop
_exit:
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
