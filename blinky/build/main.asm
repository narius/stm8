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
	.globl _clock
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
	G$clock$0$0 ==.
	C$main.c$20$0_0$2 ==.
;	./main.c: 20: unsigned int clock(void)
; genLabel
;	-----------------------------------------
;	 function clock
;	-----------------------------------------
;	Register assignment might be sub-optimal.
;	Stack space usage: 4 bytes.
_clock:
	sub	sp, #4
	C$main.c$22$1_0$2 ==.
;	./main.c: 22: unsigned char h = TIM1_PCNTRH;
; genPointerGet
	ld	a, 0x52bf
	ld	xh, a
	C$main.c$23$1_0$2 ==.
;	./main.c: 23: unsigned char l = TIM1_PCNTRL;
; genPointerGet
	ld	a, 0x52c0
	C$main.c$24$1_0$2 ==.
;	./main.c: 24: return((unsigned int)(h) << 8 | l);
; genCast
; genAssign
	clrw	y
; genLeftShiftLiteral
	clr	(0x02, sp)
; genCast
; genAssign
	clr	(0x03, sp)
; genOr
	or	a, (0x02, sp)
	ld	xl, a
	ld	a, xh
	or	a, (0x03, sp)
; genReturn
	ld	xh, a
; genLabel
00101$:
	C$main.c$25$1_0$2 ==.
;	./main.c: 25: }
; genEndFunction
	addw	sp, #4
	C$main.c$25$1_0$2 ==.
	XG$clock$0$0 ==.
	ret
	G$main$0$0 ==.
	C$main.c$27$1_0$4 ==.
;	./main.c: 27: void main(void)
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
;	Stack space usage: 0 bytes.
_main:
	C$main.c$29$1_0$4 ==.
;	./main.c: 29: CLK_DIVR = 0x00; // Set the frequency to 16 MHz
; genPointerSet
	mov	0x50c0+0, #0x00
	C$main.c$30$1_0$4 ==.
;	./main.c: 30: CLK_PCKENR2 |= 0x02; // Enable clock to timer
; genPointerGet
	ld	a, 0x50c4
; genOr
	or	a, #0x02
; genPointerSet
	ld	0x50c4, a
	C$main.c$34$1_0$4 ==.
;	./main.c: 34: TIM1_PSCRH = 0x3e;
; genPointerSet
	mov	0x52c1+0, #0x3e
	C$main.c$35$1_0$4 ==.
;	./main.c: 35: TIM1_PSCRL = 0x80;
; genPointerSet
	mov	0x52c2+0, #0x80
	C$main.c$37$1_0$4 ==.
;	./main.c: 37: TIM1_CR1 = 0x01;
; genPointerSet
	mov	0x52b0+0, #0x01
	C$main.c$40$1_0$4 ==.
;	./main.c: 40: PE_DDR = 0x80;
; genPointerSet
	mov	0x5016+0, #0x80
	C$main.c$41$1_0$4 ==.
;	./main.c: 41: PE_CR1 = 0x80;
; genPointerSet
	mov	0x5017+0, #0x80
	C$main.c$43$1_0$4 ==.
;	./main.c: 43: PC_DDR = 0x80;
; genPointerSet
	mov	0x500c+0, #0x80
	C$main.c$44$1_0$4 ==.
;	./main.c: 44: PC_CR1 = 0x80;
; genPointerSet
	mov	0x500d+0, #0x80
; genLabel
00106$:
	C$main.c$48$3_0$6 ==.
;	./main.c: 48: PE_ODR &= 0x40;
; genPointerGet
	ld	a, 0x5014
; genAnd
	and	a, #0x40
; genPointerSet
	ld	0x5014, a
	C$main.c$49$3_0$6 ==.
;	./main.c: 49: if (clock() % 2000 <= 1000)
; genCall
	call	_clock
; genDivMod
	ldw	y, #0x07d0
	divw	x, y
; genCmp
; genCmpTnz
	cpw	y, #0x03e8
	jrule	00125$
	jp	00102$
00125$:
; skipping generated iCode
	C$main.c$50$3_0$6 ==.
;	./main.c: 50: PE_ODR |= 0x80;
; genPointerGet
	ld	a, 0x5014
; genOr
	or	a, #0x80
; genPointerSet
	ld	0x5014, a
; genLabel
00102$:
	C$main.c$51$3_0$6 ==.
;	./main.c: 51: PC_ODR &= 0x40;
; genPointerGet
	ld	a, 0x500a
; genAnd
	and	a, #0x40
; genPointerSet
	ld	0x500a, a
	C$main.c$52$3_0$6 ==.
;	./main.c: 52: if (clock() % 2000 <= 1000)
; genCall
	call	_clock
; genDivMod
	ldw	y, #0x07d0
	divw	x, y
; genCmp
; genCmpTnz
	cpw	y, #0x03e8
	jrule	00126$
	jp	00106$
00126$:
; skipping generated iCode
	C$main.c$53$3_0$6 ==.
;	./main.c: 53: PC_ODR |= 0x80;
; genPointerGet
	ld	a, 0x500a
; genOr
	or	a, #0x80
; genPointerSet
	ld	0x500a, a
; genGoto
	jp	00106$
; genLabel
00108$:
	C$main.c$55$2_0$4 ==.
;	./main.c: 55: }
; genEndFunction
	C$main.c$55$2_0$4 ==.
	XG$main$0$0 ==.
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
