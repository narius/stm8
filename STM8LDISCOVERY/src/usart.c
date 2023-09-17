#include "usart.h"
#define USART_CR2_TEN (1 << 3)
#define USART_CR3_STOP2 (1 << 5)
#define USART_CR3_STOP1 (1 << 4)
#define USART_SR_TXE (1 << 7)

/*
* 1Program the M bit in USART_CR1 to define the word length.
* 2. Program the number of STOP bits in USART_CR3.
* 3. Select DMA enable (DMAT) in USART_CR5 if Multibuffer communication is to take place. Configure the DMA register as explained in Section 29.3.12: Continuous communication using DMA on page 544.
*4. Select the desired baud rate by programming the baud rate registers in the following order: 
*   a) USART_BRR2
*   b) USART_BRR1 
* 5. Set the TEN bit in USART_CR2 to enable transmitter mode.
* 6. Write the data to send in the USART_DR register (this clears the TXE bit). Repeat this for each data to be transmitted in case of single buffer.
* 7. Once the last data is written to the USART_DR register, wait until TC is set to ‘1’,
*/

void setup_usart(void){
CLK_PCKENR1 = 0xff; // Enable peripherals

	PC_DDR = 0x08; // Put TX line on
	PC_CR1 = 0x08;

	USART1_CR2 = USART_CR2_TEN; // Allow TX and RX
	USART1_CR3 &= ~(USART_CR3_STOP1 | USART_CR3_STOP2); // 1 stop bit
	USART1_BRR2 = 0x03; USART1_BRR1 = 0x68; // 9600 baud
}

int putchar(int c)
{
	while(!(USART1_SR & USART_SR_TXE));

	USART1_DR = c;

	return(c);
}