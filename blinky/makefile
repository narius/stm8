# STM8 device (for supported devices see stm8s.h)
DEVICE       =stm8l152c6
MCU          =stm8l152c6

SDCC         =sdcc

# Add process specific arguments here
CFLAGS       =-lstm8
CFLAGS      +=-mstm8
CFLAGS      +=--opt-code-size
CFLAGS      +=--std-sdcc99
CFLAGS      +=--nogcse
#CFLAGS      +=--vc --debug

CFLAGS      +=--out-fmt-elf

CFLAGS       = -mstm8 --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --fverbose-asm  --float-reent --no-peep
#CFLAGS      +=--all-callee-saves
#CFLAGS      +=--debug
#CFLAGS      +=--verbose
#CFLAGS      +=--stack-auto
#CFLAGS      +=--fverbose-asm
#CFLAGS      +=--float-reent
#CFLAGS      +=--no-peep

SOURCE       =main
SOURCE_DIR   =.
REPO_ROOT = ..
OUTPUT_DIR   =$(SOURCE_DIR)/build
STM8LDISCOVERY = $(REPO_ROOT)/STM8LDISCOVERY
#StdPeriph    =$(SOURCE_DIR)/STM8S_StdPeriph_Driver

# Add include paths here
INCLUDEPATH  =-I$(SOURCE_DIR)/
INCLUDEPATH =-I$(STM8LDISCOVERY)/include
#INCLUDEPATH +=-I$(StdPeriph)/inc

def: compile flash

all: clean compile_obj compile flash

compile: 
	mkdir -p $(OUTPUT_DIR)
	$(SDCC) $(CFLAGS) $(INCLUDEPATH) -D $(DEVICE) -o $(OUTPUT_DIR)/ $(SOURCE_DIR)/$(SOURCE).c --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --fverbose-asm  --float-reent --no-peep \
	$(OUTPUT_DIR)/led.rel \
	$(OUTPUT_DIR)/lcd.rel \
	$(OUTPUT_DIR)/registers.rel \
	$(OUTPUT_DIR)/usart.rel \
	$(OUTPUT_DIR)/interrupts.rel \
	

compile_obj:
	mkdir -p $(OUTPUT_DIR)
	$(SDCC) $(CFLAGS) $(INCLUDEPATH) -D $(DEVICE) -o $(OUTPUT_DIR)/ -c --verbose $(STM8LDISCOVERY)/src/led.c
	$(SDCC) $(CFLAGS) $(INCLUDEPATH) -D $(DEVICE) -o $(OUTPUT_DIR)/ -c --verbose $(STM8LDISCOVERY)/src/lcd.c
	$(SDCC) $(CFLAGS) $(INCLUDEPATH) -D $(DEVICE) -o $(OUTPUT_DIR)/ -c --verbose $(STM8LDISCOVERY)/src/registers.c
	$(SDCC) $(CFLAGS) $(INCLUDEPATH) -D $(DEVICE) -o $(OUTPUT_DIR)/ -c --verbose $(STM8LDISCOVERY)/src/usart.c
	$(SDCC) $(CFLAGS) $(INCLUDEPATH) -D $(DEVICE) -o $(OUTPUT_DIR)/ -c --verbose $(STM8LDISCOVERY)/src/interrupts.c

clean:
	rm -Rrf $(OUTPUT_DIR)

flash:
	stm8flash -c stlinkv2 -p $(MCU) -w $(OUTPUT_DIR)/$(SOURCE).ihx

#sdcc -mstm8 --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --fverbose-asm  --float-reent --no-peep -I../STM8LDISCOVERY/include -D stm8l152c6 -o ./build/ ./main.c --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --fverbose-asm  --float-reent --no-peep