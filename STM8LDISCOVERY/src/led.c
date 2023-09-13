#include "led.h"


void setup_led(void)
{
    /*LED_BLUE.mask=1<<7;
LED_BLUE.reg= &PC_ODR;
LED_GREEN.mask=1<<7;
LED_GREEN.reg=&PE_ODR;*/

    PE_DDR = 0x80;
    PE_CR1 = 0x80;

    PC_DDR = 0b10000000;
    PC_CR1 = 0b10000000;
    PE_ODR = 0x80;
    PC_ODR = 0x80;
}
