#include <stdint.h>
#include "registers.h"

/*//#define LED_GREEN (1<<7)*/
/*struct struct_LED {
  uint8_t mask;
  volatile char *reg;
};

struct struct_LED LED_GREENP;*/
struct struct_BIT {
  uint8_t mask;
  volatile char* reg;
};

volatile static struct struct_BIT LED_BLUE={(1<<7), &PC_ODR};
volatile static struct struct_BIT LED_GREEN={(1<<7), &PE_ODR};

void setup_led(void);
