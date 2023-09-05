#include <stdint.h>
#include "registers.h"
void setup_led(void){
    PE_DDR = 0x80;
	PE_CR1 = 0x80;

	PC_DDR = 0b10000000;
	PC_CR1 = 0b10000000;
PE_ODR = 0x80;
        PC_ODR = 0x80;
}

void set_green_high(void){
    PE_ODR |= 0x80;
}

void set_green_low(void){
    PE_ODR &= 0b01111111;
}

void set_blue_high(void){
    PC_ODR |= 0x80;
}

void set_blue_low(void){
    PC_ODR &= 0b01111111;
}