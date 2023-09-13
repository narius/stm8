#include <stdint.h>
//#include "registers.h"
#include "led.h"
//#define bitset(reg,mask)   (reg |=  mask)
//#define bitclear(reg,mask) (reg &= ~mask)
/*struct struct_LED {
  uint8_t mask;
  volatile char* reg;
};
*/
//extern static volatile struct struct_LED LED_BLUE;
//extern static volatile struct struct_LED LED_GREEN;

void main(void)
{
	// Configure pins
	setup_led();
	//PC1=Blå knapp
	for(;;)
	{
		if ((PC2_IDR & 0b00000010) != 0b00000010)
		{
			bitclear(*(LED_BLUE.reg), LED_BLUE.mask);
			bitset(*(LED_GREEN.reg), LED_GREEN.mask);
		}
		else{
			bitclear(*(LED_GREEN.reg), LED_GREEN.mask);
			bitset(*(LED_BLUE.reg), LED_BLUE.mask);
		}


	}
}