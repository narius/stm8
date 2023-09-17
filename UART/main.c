#include <stdint.h>
#include <stdio.h>
#include "registers.h"


#define USART_CR2_TEN (1 << 3)
#define USART_CR3_STOP2 (1 << 5)
#define USART_CR3_STOP1 (1 << 4)
#define USART_SR_TXE (1 << 7)

int putchar(int c)
{
	while(!(USART1_SR & USART_SR_TXE));

	USART1_DR = c;

	return(c);
}

void main(void)
{
	unsigned long i = 0;

	CLK_DIVR = 0x00; // Set the frequency to 16 MHz
	CLK_PCKENR1 = 0xff; // Enable peripherals

	PC_DDR = 0x08; // Put TX line on
	PC_CR1 = 0x08;

	USART1_CR2 = USART_CR2_TEN; // Allow TX and RX
	USART1_CR3 &= ~(USART_CR3_STOP1 | USART_CR3_STOP2); // 1 stop bit
	USART1_BRR2 = 0x03; USART1_BRR1 = 0x68; // 9600 baud

	for(;;)
	{
		printf("Hello World!\n");
		for(i = 0; i < 147456; i++); // Sleep
	}
}