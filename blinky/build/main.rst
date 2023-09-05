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
                                     12 	.globl _set_blue_low
                                     13 	.globl _set_blue_high
                                     14 	.globl _set_green_low
                                     15 	.globl _set_green_high
                                     16 	.globl _setup_led
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; Stack segment in internal ram
                                     27 ;--------------------------------------------------------
                                     28 	.area SSEG
      000001                         29 __start__stack:
      000001                         30 	.ds	1
                                     31 
                                     32 ;--------------------------------------------------------
                                     33 ; absolute external ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DABS (ABS)
                                     36 
                                     37 ; default segment ordering for linker
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area CONST
                                     42 	.area INITIALIZER
                                     43 	.area CODE
                                     44 
                                     45 ;--------------------------------------------------------
                                     46 ; interrupt vector
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
      008000                         49 __interrupt_vect:
      008000 82 00 80 07             50 	int s_GSINIT ; reset
                                     51 ;--------------------------------------------------------
                                     52 ; global & static initialisations
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area GSINIT
      008007 CD 80 54         [ 4]   58 	call	___sdcc_external_startup
      00800A 4D               [ 1]   59 	tnz	a
      00800B 27 03            [ 1]   60 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   61 	jp	__sdcc_program_startup
      008010                         62 __sdcc_init_data:
                                     63 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   64 	ldw x, #l_DATA
      008013 27 07            [ 1]   65 	jreq	00002$
      008015                         66 00001$:
      008015 72 4F 00 00      [ 1]   67 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   68 	decw x
      00801A 26 F9            [ 1]   69 	jrne	00001$
      00801C                         70 00002$:
      00801C AE 00 00         [ 2]   71 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   72 	jreq	00004$
      008021                         73 00003$:
      008021 D6 80 2C         [ 1]   74 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   75 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   76 	decw	x
      008028 26 F7            [ 1]   77 	jrne	00003$
      00802A                         78 00004$:
                                     79 ; stm8_genXINIT() end
                                     80 	.area GSFINAL
      00802A CC 80 04         [ 2]   81 	jp	__sdcc_program_startup
                                     82 ;--------------------------------------------------------
                                     83 ; Home
                                     84 ;--------------------------------------------------------
                                     85 	.area HOME
                                     86 	.area HOME
      008004                         87 __sdcc_program_startup:
      008004 CC 80 2D         [ 2]   88 	jp	_main
                                     89 ;	return from main will return to caller
                                     90 ;--------------------------------------------------------
                                     91 ; code
                                     92 ;--------------------------------------------------------
                                     93 	.area CODE
                           000000    94 	G$main$0$0 ==.
                           000000    95 	C$main.c$5$0_0$7 ==.
                                     96 ;	./main.c: 5: void main(void)
                                     97 ; genLabel
                                     98 ;	-----------------------------------------
                                     99 ;	 function main
                                    100 ;	-----------------------------------------
                                    101 ;	Register assignment might be sub-optimal.
                                    102 ;	Stack space usage: 0 bytes.
      00802D                        103 _main:
                           000000   104 	C$main.c$8$1_0$7 ==.
                                    105 ;	./main.c: 8: setup_led();
                                    106 ; genCall
      00802D CD 00 00         [ 4]  107 	call	_setup_led
                                    108 ; genLabel
      008030                        109 00105$:
                           000003   110 	C$main.c$12$3_0$9 ==.
                                    111 ;	./main.c: 12: if ((PC2_IDR & 0b00000010) != 0b00000010)
                                    112 ; genPointerGet
      008030 C6 50 0B         [ 1]  113 	ld	a, 0x500b
                                    114 ; genCast
                                    115 ; genAssign
      008033 5F               [ 1]  116 	clrw	x
                                    117 ; genAnd
      008034 A4 02            [ 1]  118 	and	a, #0x02
      008036 97               [ 1]  119 	ld	xl, a
      008037 4F               [ 1]  120 	clr	a
                                    121 ; genCmpEQorNE
      008038 95               [ 1]  122 	ld	xh, a
      008039 A3 00 02         [ 2]  123 	cpw	x, #0x0002
      00803C 26 03            [ 1]  124 	jrne	00120$
      00803E CC 80 4A         [ 2]  125 	jp	00102$
      008041                        126 00120$:
                                    127 ; skipping generated iCode
                           000014   128 	C$main.c$14$4_0$10 ==.
                                    129 ;	./main.c: 14: set_blue_low();
                                    130 ; genCall
      008041 CD 00 00         [ 4]  131 	call	_set_blue_low
                           000017   132 	C$main.c$15$4_0$10 ==.
                                    133 ;	./main.c: 15: set_green_low();
                                    134 ; genCall
      008044 CD 00 00         [ 4]  135 	call	_set_green_low
                                    136 ; genGoto
      008047 CC 80 30         [ 2]  137 	jp	00105$
                                    138 ; genLabel
      00804A                        139 00102$:
                           00001D   140 	C$main.c$18$4_0$11 ==.
                                    141 ;	./main.c: 18: set_blue_high();
                                    142 ; genCall
      00804A CD 00 00         [ 4]  143 	call	_set_blue_high
                           000020   144 	C$main.c$19$4_0$11 ==.
                                    145 ;	./main.c: 19: set_green_high();
                                    146 ; genCall
      00804D CD 00 00         [ 4]  147 	call	_set_green_high
                                    148 ; genGoto
      008050 CC 80 30         [ 2]  149 	jp	00105$
                                    150 ; genLabel
      008053                        151 00107$:
                           000026   152 	C$main.c$24$2_0$7 ==.
                                    153 ;	./main.c: 24: }
                                    154 ; genEndFunction
                           000026   155 	C$main.c$24$2_0$7 ==.
                           000026   156 	XG$main$0$0 ==.
      008053 81               [ 4]  157 	ret
                                    158 	.area CODE
                                    159 	.area CONST
                                    160 	.area INITIALIZER
                                    161 	.area CABS (ABS)
