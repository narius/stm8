// PC4 = I2C1_SMB
// PC1 = I2C1_SCL
// PC0 = I2C1_SDA
#define BLINK   00<<6
#define BLINKF  00<<3
#define DUTY    00<<2
#define B2      0
#define PON     001<<5
#define HD      1<<4
#define CC      001<<1
#define VSEL    0
#define LCDEN   1<<6
#define SOFIE   0<<5
#define SOF     0<<4
#define SOFC    1<<3
#define DEAD    000
#define PAGE_COM    0<<2

/*
* To update the LCD_RAM content, proceed as follow:
* 1 Clear SOF flag by setting SOFC bit in LCD_CR3
* 2 Wait until SOF active (start of new frame) by polling SOF bit in LCD_CR3 until it is asserted or waiting until the LCD Interrupt is serviced (if the SOFIE bit is set)
* 3 Update LCD_RAM buffer
*/
