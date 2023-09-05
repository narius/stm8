#include <stdint.h>
#include "registers.h"
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
			set_blue_low();
			set_green_low();
		}
		else{
			set_blue_high();
			set_green_high();
		}


	}
}