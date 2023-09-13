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
	.globl _setup_led
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
Fmain$LED_BLUE$0_0$0==.
_LED_BLUE:
	.ds 3
Fmain$LED_GREEN$0_0$0==.
_LED_GREEN:
	.ds 3
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
	C$main.c$14$0_0$3 ==.
;	./main.c: 14: void main(void)
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 1 bytes.
_main:
	push	a
	C$main.c$17$1_0$3 ==.
;	./main.c: 17: setup_led();
; genCall
	call	_setup_led
; genLabel
00105$:
	C$main.c$21$3_0$5 ==.
;	./main.c: 21: if ((PC2_IDR & 0b00000010) != 0b00000010)
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
	C$main.c$23$4_0$6 ==.
;	./main.c: 23: bitclear(*(LED_BLUE.reg), LED_BLUE.mask);
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _LED_BLUE+1
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	y, _LED_BLUE+1
; genPointerGet
	ld	a, (y)
	ld	(0x01, sp), a
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _LED_BLUE+0
; genCpl
	cpl	a
; genAnd
	and	a, (0x01, sp)
; genPointerSet
	ld	(x), a
	C$main.c$24$4_0$6 ==.
;	./main.c: 24: bitset(*(LED_GREEN.reg), LED_GREEN.mask);
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _LED_GREEN+1
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	y, _LED_GREEN+1
; genPointerGet
	ld	a, (y)
	ld	(0x01, sp), a
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _LED_GREEN+0
; genOr
	or	a, (0x01, sp)
; genPointerSet
	ld	(x), a
; genGoto
	jp	00105$
; genLabel
00102$:
	C$main.c$27$4_0$7 ==.
;	./main.c: 27: bitclear(*(LED_GREEN.reg), LED_GREEN.mask);
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _LED_GREEN+1
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	y, _LED_GREEN+1
; genPointerGet
	ld	a, (y)
	ld	(0x01, sp), a
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _LED_GREEN+0
; genCpl
	cpl	a
; genAnd
	and	a, (0x01, sp)
; genPointerSet
	ld	(x), a
	C$main.c$28$4_0$7 ==.
;	./main.c: 28: bitset(*(LED_BLUE.reg), LED_BLUE.mask);
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	x, _LED_BLUE+1
; skipping iCode since result will be rematerialized
; genPointerGet
	ldw	y, _LED_BLUE+1
; genPointerGet
	ld	a, (y)
	ld	(0x01, sp), a
; skipping iCode since result will be rematerialized
; genPointerGet
	ld	a, _LED_BLUE+0
; genOr
	or	a, (0x01, sp)
; genPointerSet
	ld	(x), a
; genGoto
	jp	00105$
; genLabel
00107$:
	C$main.c$33$2_0$3 ==.
;	./main.c: 33: }
; genEndFunction
	pop	a
	C$main.c$33$2_0$3 ==.
	XG$main$0$0 ==.
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
Fmain$__xinit_LED_BLUE$0_0$0 == .
__xinit__LED_BLUE:
	.db #0x80	; 128
	.dw #0x500a
Fmain$__xinit_LED_GREEN$0_0$0 == .
__xinit__LED_GREEN:
	.db #0x80	; 128
	.dw #0x5014
	.area CABS (ABS)
