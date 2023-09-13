                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.3.0 #14184 (Mac OS X ppc)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _setup_led
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                           000000    21 Fmain$LED_BLUE$0_0$0==.
      000001                         22 _LED_BLUE:
      000001                         23 	.ds 3
                           000003    24 Fmain$LED_GREEN$0_0$0==.
      000004                         25 _LED_GREEN:
      000004                         26 	.ds 3
                                     27 ;--------------------------------------------------------
                                     28 ; Stack segment in internal ram
                                     29 ;--------------------------------------------------------
                                     30 	.area SSEG
      00000D                         31 __start__stack:
      00000D                         32 	.ds	1
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; absolute external ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DABS (ABS)
                                     38 
                                     39 ; default segment ordering for linker
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area CONST
                                     44 	.area INITIALIZER
                                     45 	.area CODE
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; interrupt vector
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
      008000                         51 __interrupt_vect:
      008000 82 00 80 07             52 	int s_GSINIT ; reset
                                     53 ;--------------------------------------------------------
                                     54 ; global & static initialisations
                                     55 ;--------------------------------------------------------
                                     56 	.area HOME
                                     57 	.area GSINIT
                                     58 	.area GSFINAL
                                     59 	.area GSINIT
      008007 CD 80 DC         [ 4]   60 	call	___sdcc_external_startup
      00800A 4D               [ 1]   61 	tnz	a
      00800B 27 03            [ 1]   62 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   63 	jp	__sdcc_program_startup
      008010                         64 __sdcc_init_data:
                                     65 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   66 	ldw x, #l_DATA
      008013 27 07            [ 1]   67 	jreq	00002$
      008015                         68 00001$:
      008015 72 4F 00 00      [ 1]   69 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   70 	decw x
      00801A 26 F9            [ 1]   71 	jrne	00001$
      00801C                         72 00002$:
      00801C AE 00 0C         [ 2]   73 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   74 	jreq	00004$
      008021                         75 00003$:
      008021 D6 80 2C         [ 1]   76 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   77 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   78 	decw	x
      008028 26 F7            [ 1]   79 	jrne	00003$
      00802A                         80 00004$:
                                     81 ; stm8_genXINIT() end
                                     82 	.area GSFINAL
      00802A CC 80 04         [ 2]   83 	jp	__sdcc_program_startup
                                     84 ;--------------------------------------------------------
                                     85 ; Home
                                     86 ;--------------------------------------------------------
                                     87 	.area HOME
                                     88 	.area HOME
      008004                         89 __sdcc_program_startup:
      008004 CC 80 39         [ 2]   90 	jp	_main
                                     91 ;	return from main will return to caller
                                     92 ;--------------------------------------------------------
                                     93 ; code
                                     94 ;--------------------------------------------------------
                                     95 	.area CODE
                           000000    96 	G$main$0$0 ==.
                           000000    97 	C$main.c$14$0_0$3 ==.
                                     98 ;	./main.c: 14: void main(void)
                                     99 ; genLabel
                                    100 ;	-----------------------------------------
                                    101 ;	 function main
                                    102 ;	-----------------------------------------
                                    103 ;	Register assignment might be sub-optimal.
                                    104 ;	Stack space usage: 1 bytes.
      008039                        105 _main:
      008039 88               [ 1]  106 	push	a
                           000001   107 	C$main.c$17$1_0$3 ==.
                                    108 ;	./main.c: 17: setup_led();
                                    109 ; genCall
      00803A CD 80 9C         [ 4]  110 	call	_setup_led
                                    111 ; genLabel
      00803D                        112 00105$:
                           000004   113 	C$main.c$21$3_0$5 ==.
                                    114 ;	./main.c: 21: if ((PC2_IDR & 0b00000010) != 0b00000010)
                                    115 ; genPointerGet
      00803D C6 50 0B         [ 1]  116 	ld	a, 0x500b
                                    117 ; genCast
                                    118 ; genAssign
      008040 5F               [ 1]  119 	clrw	x
                                    120 ; genAnd
      008041 A4 02            [ 1]  121 	and	a, #0x02
      008043 97               [ 1]  122 	ld	xl, a
      008044 4F               [ 1]  123 	clr	a
                                    124 ; genCmpEQorNE
      008045 95               [ 1]  125 	ld	xh, a
      008046 A3 00 02         [ 2]  126 	cpw	x, #0x0002
      008049 26 03            [ 1]  127 	jrne	00120$
      00804B CC 80 74         [ 2]  128 	jp	00102$
      00804E                        129 00120$:
                                    130 ; skipping generated iCode
                           000015   131 	C$main.c$23$4_0$6 ==.
                                    132 ;	./main.c: 23: bitclear(*(LED_BLUE.reg), LED_BLUE.mask);
                                    133 ; skipping iCode since result will be rematerialized
                                    134 ; genPointerGet
      00804E CE 00 02         [ 2]  135 	ldw	x, _LED_BLUE+1
                                    136 ; skipping iCode since result will be rematerialized
                                    137 ; genPointerGet
      008051 90 CE 00 02      [ 2]  138 	ldw	y, _LED_BLUE+1
                                    139 ; genPointerGet
      008055 90 F6            [ 1]  140 	ld	a, (y)
      008057 6B 01            [ 1]  141 	ld	(0x01, sp), a
                                    142 ; skipping iCode since result will be rematerialized
                                    143 ; genPointerGet
      008059 C6 00 01         [ 1]  144 	ld	a, _LED_BLUE+0
                                    145 ; genCpl
      00805C 43               [ 1]  146 	cpl	a
                                    147 ; genAnd
      00805D 14 01            [ 1]  148 	and	a, (0x01, sp)
                                    149 ; genPointerSet
      00805F F7               [ 1]  150 	ld	(x), a
                           000027   151 	C$main.c$24$4_0$6 ==.
                                    152 ;	./main.c: 24: bitset(*(LED_GREEN.reg), LED_GREEN.mask);
                                    153 ; skipping iCode since result will be rematerialized
                                    154 ; genPointerGet
      008060 CE 00 05         [ 2]  155 	ldw	x, _LED_GREEN+1
                                    156 ; skipping iCode since result will be rematerialized
                                    157 ; genPointerGet
      008063 90 CE 00 05      [ 2]  158 	ldw	y, _LED_GREEN+1
                                    159 ; genPointerGet
      008067 90 F6            [ 1]  160 	ld	a, (y)
      008069 6B 01            [ 1]  161 	ld	(0x01, sp), a
                                    162 ; skipping iCode since result will be rematerialized
                                    163 ; genPointerGet
      00806B C6 00 04         [ 1]  164 	ld	a, _LED_GREEN+0
                                    165 ; genOr
      00806E 1A 01            [ 1]  166 	or	a, (0x01, sp)
                                    167 ; genPointerSet
      008070 F7               [ 1]  168 	ld	(x), a
                                    169 ; genGoto
      008071 CC 80 3D         [ 2]  170 	jp	00105$
                                    171 ; genLabel
      008074                        172 00102$:
                           00003B   173 	C$main.c$27$4_0$7 ==.
                                    174 ;	./main.c: 27: bitclear(*(LED_GREEN.reg), LED_GREEN.mask);
                                    175 ; skipping iCode since result will be rematerialized
                                    176 ; genPointerGet
      008074 CE 00 05         [ 2]  177 	ldw	x, _LED_GREEN+1
                                    178 ; skipping iCode since result will be rematerialized
                                    179 ; genPointerGet
      008077 90 CE 00 05      [ 2]  180 	ldw	y, _LED_GREEN+1
                                    181 ; genPointerGet
      00807B 90 F6            [ 1]  182 	ld	a, (y)
      00807D 6B 01            [ 1]  183 	ld	(0x01, sp), a
                                    184 ; skipping iCode since result will be rematerialized
                                    185 ; genPointerGet
      00807F C6 00 04         [ 1]  186 	ld	a, _LED_GREEN+0
                                    187 ; genCpl
      008082 43               [ 1]  188 	cpl	a
                                    189 ; genAnd
      008083 14 01            [ 1]  190 	and	a, (0x01, sp)
                                    191 ; genPointerSet
      008085 F7               [ 1]  192 	ld	(x), a
                           00004D   193 	C$main.c$28$4_0$7 ==.
                                    194 ;	./main.c: 28: bitset(*(LED_BLUE.reg), LED_BLUE.mask);
                                    195 ; skipping iCode since result will be rematerialized
                                    196 ; genPointerGet
      008086 CE 00 02         [ 2]  197 	ldw	x, _LED_BLUE+1
                                    198 ; skipping iCode since result will be rematerialized
                                    199 ; genPointerGet
      008089 90 CE 00 02      [ 2]  200 	ldw	y, _LED_BLUE+1
                                    201 ; genPointerGet
      00808D 90 F6            [ 1]  202 	ld	a, (y)
      00808F 6B 01            [ 1]  203 	ld	(0x01, sp), a
                                    204 ; skipping iCode since result will be rematerialized
                                    205 ; genPointerGet
      008091 C6 00 01         [ 1]  206 	ld	a, _LED_BLUE+0
                                    207 ; genOr
      008094 1A 01            [ 1]  208 	or	a, (0x01, sp)
                                    209 ; genPointerSet
      008096 F7               [ 1]  210 	ld	(x), a
                                    211 ; genGoto
      008097 CC 80 3D         [ 2]  212 	jp	00105$
                                    213 ; genLabel
      00809A                        214 00107$:
                           000061   215 	C$main.c$33$2_0$3 ==.
                                    216 ;	./main.c: 33: }
                                    217 ; genEndFunction
      00809A 84               [ 1]  218 	pop	a
                           000062   219 	C$main.c$33$2_0$3 ==.
                           000062   220 	XG$main$0$0 ==.
      00809B 81               [ 4]  221 	ret
                                    222 	.area CODE
                                    223 	.area CONST
                                    224 	.area INITIALIZER
                           000000   225 Fmain$__xinit_LED_BLUE$0_0$0 == .
      00802D                        226 __xinit__LED_BLUE:
      00802D 80                     227 	.db #0x80	; 128
      00802E 50 0A                  228 	.dw #0x500a
                           000003   229 Fmain$__xinit_LED_GREEN$0_0$0 == .
      008030                        230 __xinit__LED_GREEN:
      008030 80                     231 	.db #0x80	; 128
      008031 50 14                  232 	.dw #0x5014
                                    233 	.area CABS (ABS)
