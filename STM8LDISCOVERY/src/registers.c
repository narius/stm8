#include "registers.h"
void set_bit_high(volatile uint8_t *reg, unsigned int mapp){
    *reg |= mapp;

}
void set_bit_low(volatile uint8_t *reg, unsigned int mapp){
    *reg &= ~mapp;
}