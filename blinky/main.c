#include <stdint.h>
#include <stdio.h>
//#include "registers.h"
#include "led.h"
#include "usart.h"
//HSI selected as system clock source
// System clock source/1
#define F_SYSCLOCK 16000000UL

void main(void)
{
	CLK_DIVR=0x00;
	//bitset(CLK_PCKENR1, (1<<3));
	//CLK_PCKENR1=0xFF;
	PC_DDR=0x08;
	PC_CR1=0x08;
	// Configure pins
	setup_led();
	setup_usart();
	//PC1=Blå knapp
	bitset(PE_DDR, LED_GREEN.mask);
	bitset(PE_CR1, LED_GREEN.mask);
	bitclear(*(LED_GREEN.reg), LED_GREEN.mask);
	uint32_t i;
	/*for(;;)
	{
		*LED_GREEN.reg^=LED_GREEN.mask;
		for(i=0;i<((F_SYSCLOCK/18000UL)*500);i++){
			__asm__("nop");
		}
	}*/
	for(;;)
	{
		if ((PC2_IDR & 0b00000010) != 0b00000010)
		{
			bitclear(*(LED_BLUE.reg), LED_BLUE.mask);
			//bitset(*(LED_GREEN.reg), LED_GREEN.mask);
			printf("hej\n");
			for(i = 0; i < 147456; i++); // Sleep
		}
		else{
			//bitclear(*(LED_GREEN.reg), LED_GREEN.mask);
			bitset(*(LED_BLUE.reg), LED_BLUE.mask);
		}
	}
}