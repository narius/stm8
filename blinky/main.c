#include <stdint.h>
#include <stdio.h>
#include "registers.h"
#include "led.h"
#include "usart.h"
#include "interrupts.h"
//HSI selected as system clock source
// System clock source/1
#define F_SYSCLOCK 16000000UL

volatile static struct struct_BIT BUTTON_BLUE={(1<<2), &PC_DDR};
 void BLUE_BUTTON_Handler(void) __interrupt(EXTI_3){
    printf("BLUE_BUTTON_Handler");
}

void BLUE_BUTTON_setup_interrupt(void){
	printf("BLUE_BUTTON_setup_interrupt\n");
	bitclear(PC_DDR, BUTTON_BLUE.mask);
	bitset(PC_CR1, BUTTON_BLUE.mask);
	bitset(PC_CR2, BUTTON_BLUE.mask);
}
void main(void)
{
	__asm__("rim");//Enable interrupts
	printf("\n\n");
	CLK_DIVR=0x00;
	//bitset(CLK_PCKENR1, (1<<3));
	//CLK_PCKENR1=0xFF;
	PC_DDR=0x08;
	PC_CR1=0x08;
	// Configure pins
	setup_led();
	setup_usart();
	BLUE_BUTTON_setup_interrupt();
	bitset(PE_DDR, LED_GREEN.mask);
	bitset(PE_CR1, LED_GREEN.mask);
	bitclear(*(LED_GREEN.reg), LED_GREEN.mask);
	uint32_t i;
	int pressed = 0;
	printf("VREFINT_Factory_CONV: %d\n", VREFINT_Factory_CONV);
	printf("VREFINT_Factory_CONV_V90: %d\n", VREFINT_Factory_CONV_V90);
	printf("\n\n");
	for(;;)
	{
		/*if ((PC_IDR & 0b00000010) != 0b00000010)
		{
			pressed++;
			bitclear(*(LED_BLUE.reg), LED_BLUE.mask);
			//bitset(*(LED_GREEN.reg), LED_GREEN.mask);
			printf("hej %d\n", pressed);
			for(i = 0; i < 147456; i++); // Sleep
		}*/
		
	}
}


