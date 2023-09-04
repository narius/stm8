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
                                     12 	.globl _clock
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; Stack segment in internal ram
                                     23 ;--------------------------------------------------------
                                     24 	.area SSEG
      000001                         25 __start__stack:
      000001                         26 	.ds	1
                                     27 
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; interrupt vector
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
      008000                         45 __interrupt_vect:
      008000 82 00 80 07             46 	int s_GSINIT ; reset
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
      008007 CD 80 B4         [ 4]   54 	call	___sdcc_external_startup
      00800A 4D               [ 1]   55 	tnz	a
      00800B 27 03            [ 1]   56 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   57 	jp	__sdcc_program_startup
      008010                         58 __sdcc_init_data:
                                     59 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   60 	ldw x, #l_DATA
      008013 27 07            [ 1]   61 	jreq	00002$
      008015                         62 00001$:
      008015 72 4F 00 00      [ 1]   63 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   64 	decw x
      00801A 26 F9            [ 1]   65 	jrne	00001$
      00801C                         66 00002$:
      00801C AE 00 00         [ 2]   67 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   68 	jreq	00004$
      008021                         69 00003$:
      008021 D6 80 2C         [ 1]   70 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   71 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   72 	decw	x
      008028 26 F7            [ 1]   73 	jrne	00003$
      00802A                         74 00004$:
                                     75 ; stm8_genXINIT() end
                                     76 	.area GSFINAL
      00802A CC 80 04         [ 2]   77 	jp	__sdcc_program_startup
                                     78 ;--------------------------------------------------------
                                     79 ; Home
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area HOME
      008004                         83 __sdcc_program_startup:
      008004 CC 80 46         [ 2]   84 	jp	_main
                                     85 ;	return from main will return to caller
                                     86 ;--------------------------------------------------------
                                     87 ; code
                                     88 ;--------------------------------------------------------
                                     89 	.area CODE
                           000000    90 	G$clock$0$0 ==.
                           000000    91 	C$main.c$20$0_0$2 ==.
                                     92 ;	./main.c: 20: unsigned int clock(void)
                                     93 ; genLabel
                                     94 ;	-----------------------------------------
                                     95 ;	 function clock
                                     96 ;	-----------------------------------------
                                     97 ;	Register assignment might be sub-optimal.
                                     98 ;	Stack space usage: 4 bytes.
      00802D                         99 _clock:
      00802D 52 04            [ 2]  100 	sub	sp, #4
                           000002   101 	C$main.c$22$1_0$2 ==.
                                    102 ;	./main.c: 22: unsigned char h = TIM1_PCNTRH;
                                    103 ; genPointerGet
      00802F C6 52 BF         [ 1]  104 	ld	a, 0x52bf
      008032 95               [ 1]  105 	ld	xh, a
                           000006   106 	C$main.c$23$1_0$2 ==.
                                    107 ;	./main.c: 23: unsigned char l = TIM1_PCNTRL;
                                    108 ; genPointerGet
      008033 C6 52 C0         [ 1]  109 	ld	a, 0x52c0
                           000009   110 	C$main.c$24$1_0$2 ==.
                                    111 ;	./main.c: 24: return((unsigned int)(h) << 8 | l);
                                    112 ; genCast
                                    113 ; genAssign
      008036 90 5F            [ 1]  114 	clrw	y
                                    115 ; genLeftShiftLiteral
      008038 0F 02            [ 1]  116 	clr	(0x02, sp)
                                    117 ; genCast
                                    118 ; genAssign
      00803A 0F 03            [ 1]  119 	clr	(0x03, sp)
                                    120 ; genOr
      00803C 1A 02            [ 1]  121 	or	a, (0x02, sp)
      00803E 97               [ 1]  122 	ld	xl, a
      00803F 9E               [ 1]  123 	ld	a, xh
      008040 1A 03            [ 1]  124 	or	a, (0x03, sp)
                                    125 ; genReturn
      008042 95               [ 1]  126 	ld	xh, a
                                    127 ; genLabel
      008043                        128 00101$:
                           000016   129 	C$main.c$25$1_0$2 ==.
                                    130 ;	./main.c: 25: }
                                    131 ; genEndFunction
      008043 5B 04            [ 2]  132 	addw	sp, #4
                           000018   133 	C$main.c$25$1_0$2 ==.
                           000018   134 	XG$clock$0$0 ==.
      008045 81               [ 4]  135 	ret
                           000019   136 	G$main$0$0 ==.
                           000019   137 	C$main.c$27$1_0$4 ==.
                                    138 ;	./main.c: 27: void main(void)
                                    139 ; genLabel
                                    140 ;	-----------------------------------------
                                    141 ;	 function main
                                    142 ;	-----------------------------------------
                                    143 ;	Register assignment is optimal.
                                    144 ;	Stack space usage: 0 bytes.
      008046                        145 _main:
                           000019   146 	C$main.c$29$1_0$4 ==.
                                    147 ;	./main.c: 29: CLK_DIVR = 0x00; // Set the frequency to 16 MHz
                                    148 ; genPointerSet
      008046 35 00 50 C0      [ 1]  149 	mov	0x50c0+0, #0x00
                           00001D   150 	C$main.c$30$1_0$4 ==.
                                    151 ;	./main.c: 30: CLK_PCKENR2 |= 0x02; // Enable clock to timer
                                    152 ; genPointerGet
      00804A C6 50 C4         [ 1]  153 	ld	a, 0x50c4
                                    154 ; genOr
      00804D AA 02            [ 1]  155 	or	a, #0x02
                                    156 ; genPointerSet
      00804F C7 50 C4         [ 1]  157 	ld	0x50c4, a
                           000025   158 	C$main.c$34$1_0$4 ==.
                                    159 ;	./main.c: 34: TIM1_PSCRH = 0x3e;
                                    160 ; genPointerSet
      008052 35 3E 52 C1      [ 1]  161 	mov	0x52c1+0, #0x3e
                           000029   162 	C$main.c$35$1_0$4 ==.
                                    163 ;	./main.c: 35: TIM1_PSCRL = 0x80;
                                    164 ; genPointerSet
      008056 35 80 52 C2      [ 1]  165 	mov	0x52c2+0, #0x80
                           00002D   166 	C$main.c$37$1_0$4 ==.
                                    167 ;	./main.c: 37: TIM1_CR1 = 0x01;
                                    168 ; genPointerSet
      00805A 35 01 52 B0      [ 1]  169 	mov	0x52b0+0, #0x01
                           000031   170 	C$main.c$40$1_0$4 ==.
                                    171 ;	./main.c: 40: PE_DDR = 0x80;
                                    172 ; genPointerSet
      00805E 35 80 50 16      [ 1]  173 	mov	0x5016+0, #0x80
                           000035   174 	C$main.c$41$1_0$4 ==.
                                    175 ;	./main.c: 41: PE_CR1 = 0x80;
                                    176 ; genPointerSet
      008062 35 80 50 17      [ 1]  177 	mov	0x5017+0, #0x80
                           000039   178 	C$main.c$43$1_0$4 ==.
                                    179 ;	./main.c: 43: PC_DDR = 0x80;
                                    180 ; genPointerSet
      008066 35 80 50 0C      [ 1]  181 	mov	0x500c+0, #0x80
                           00003D   182 	C$main.c$44$1_0$4 ==.
                                    183 ;	./main.c: 44: PC_CR1 = 0x80;
                                    184 ; genPointerSet
      00806A 35 80 50 0D      [ 1]  185 	mov	0x500d+0, #0x80
                                    186 ; genLabel
      00806E                        187 00106$:
                           000041   188 	C$main.c$48$3_0$6 ==.
                                    189 ;	./main.c: 48: PE_ODR &= 0x40;
                                    190 ; genPointerGet
      00806E C6 50 14         [ 1]  191 	ld	a, 0x5014
                                    192 ; genAnd
      008071 A4 40            [ 1]  193 	and	a, #0x40
                                    194 ; genPointerSet
      008073 C7 50 14         [ 1]  195 	ld	0x5014, a
                           000049   196 	C$main.c$49$3_0$6 ==.
                                    197 ;	./main.c: 49: if (clock() % 2000 <= 1000)
                                    198 ; genCall
      008076 CD 80 2D         [ 4]  199 	call	_clock
                                    200 ; genDivMod
      008079 90 AE 07 D0      [ 2]  201 	ldw	y, #0x07d0
      00807D 65               [ 2]  202 	divw	x, y
                                    203 ; genCmp
                                    204 ; genCmpTnz
      00807E 90 A3 03 E8      [ 2]  205 	cpw	y, #0x03e8
      008082 23 03            [ 2]  206 	jrule	00125$
      008084 CC 80 8F         [ 2]  207 	jp	00102$
      008087                        208 00125$:
                                    209 ; skipping generated iCode
                           00005A   210 	C$main.c$50$3_0$6 ==.
                                    211 ;	./main.c: 50: PE_ODR |= 0x80;
                                    212 ; genPointerGet
      008087 C6 50 14         [ 1]  213 	ld	a, 0x5014
                                    214 ; genOr
      00808A AA 80            [ 1]  215 	or	a, #0x80
                                    216 ; genPointerSet
      00808C C7 50 14         [ 1]  217 	ld	0x5014, a
                                    218 ; genLabel
      00808F                        219 00102$:
                           000062   220 	C$main.c$51$3_0$6 ==.
                                    221 ;	./main.c: 51: PC_ODR &= 0x40;
                                    222 ; genPointerGet
      00808F C6 50 0A         [ 1]  223 	ld	a, 0x500a
                                    224 ; genAnd
      008092 A4 40            [ 1]  225 	and	a, #0x40
                                    226 ; genPointerSet
      008094 C7 50 0A         [ 1]  227 	ld	0x500a, a
                           00006A   228 	C$main.c$52$3_0$6 ==.
                                    229 ;	./main.c: 52: if (clock() % 2000 <= 1000)
                                    230 ; genCall
      008097 CD 80 2D         [ 4]  231 	call	_clock
                                    232 ; genDivMod
      00809A 90 AE 07 D0      [ 2]  233 	ldw	y, #0x07d0
      00809E 65               [ 2]  234 	divw	x, y
                                    235 ; genCmp
                                    236 ; genCmpTnz
      00809F 90 A3 03 E8      [ 2]  237 	cpw	y, #0x03e8
      0080A3 23 03            [ 2]  238 	jrule	00126$
      0080A5 CC 80 6E         [ 2]  239 	jp	00106$
      0080A8                        240 00126$:
                                    241 ; skipping generated iCode
                           00007B   242 	C$main.c$53$3_0$6 ==.
                                    243 ;	./main.c: 53: PC_ODR |= 0x80;
                                    244 ; genPointerGet
      0080A8 C6 50 0A         [ 1]  245 	ld	a, 0x500a
                                    246 ; genOr
      0080AB AA 80            [ 1]  247 	or	a, #0x80
                                    248 ; genPointerSet
      0080AD C7 50 0A         [ 1]  249 	ld	0x500a, a
                                    250 ; genGoto
      0080B0 CC 80 6E         [ 2]  251 	jp	00106$
                                    252 ; genLabel
      0080B3                        253 00108$:
                           000086   254 	C$main.c$55$2_0$4 ==.
                                    255 ;	./main.c: 55: }
                                    256 ; genEndFunction
                           000086   257 	C$main.c$55$2_0$4 ==.
                           000086   258 	XG$main$0$0 ==.
      0080B3 81               [ 4]  259 	ret
                                    260 	.area CODE
                                    261 	.area CONST
                                    262 	.area INITIALIZER
                                    263 	.area CABS (ABS)
