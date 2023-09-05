;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.0 #14184 (Mac OS X ppc)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_blue_low
	.globl _set_blue_high
	.globl _set_green_low
	.globl _set_green_high
	.globl _setup_led
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
	G$main$0$0 ==.
	C$main.c$5$0_0$7 ==.
;	./main.c: 5: void main(void)
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 0 bytes.
_main:
	C$main.c$8$1_0$7 ==.
;	./main.c: 8: setup_led();
; genCall
	call	_setup_led
; genLabel
00105$:
	C$main.c$12$3_0$9 ==.
;	./main.c: 12: if ((PC2_IDR & 0b00000010) != 0b00000010)
; genPointerGet
	ld	a, 0x500b
; genCast
; genAssign
	clrw	x
; genAnd
	and	a, #0x02
	ld	xl, a
	clr	a
; genCmpEQorNE
	ld	xh, a
	cpw	x, #0x0002
	jrne	00120$
	jp	00102$
00120$:
; skipping generated iCode
	C$main.c$14$4_0$10 ==.
;	./main.c: 14: set_blue_low();
; genCall
	call	_set_blue_low
	C$main.c$15$4_0$10 ==.
;	./main.c: 15: set_green_low();
; genCall
	call	_set_green_low
; genGoto
	jp	00105$
; genLabel
00102$:
	C$main.c$18$4_0$11 ==.
;	./main.c: 18: set_blue_high();
; genCall
	call	_set_blue_high
	C$main.c$19$4_0$11 ==.
;	./main.c: 19: set_green_high();
; genCall
	call	_set_green_high
; genGoto
	jp	00105$
; genLabel
00107$:
	C$main.c$24$2_0$7 ==.
;	./main.c: 24: }
; genEndFunction
	C$main.c$24$2_0$7 ==.
	XG$main$0$0 ==.
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
