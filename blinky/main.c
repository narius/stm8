#include <stdint.h>
//#include "registers.h"
#include "led.h"
void main(void)
{
	// Configure pins
	setup_led();
	//PC1=Blå knapp
	for(;;)
	{
		if ((PC2_IDR & 0b00000010) != 0b00000010)
		{
			set_bit_low(&LED_GREENP.reg, LED_GREENP.mask);
		}
		else{
			set_bit_high(&LED_GREENP.reg, LED_GREENP.mask);
		}


	}
}