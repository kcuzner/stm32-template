# Generic Makefile for STM32 firmwares
#
# Kevin Cuzner
#

#
# Settings
#

include common/common-top.mak

PROJECT = firmware
BINARY = $(PROJECT)

# Project Structure
SRCDIRS = src cmsis/src common/src
GENSRCDIRS = src common/src
INCDIRS = include cmsis/include common/include

# Sources
GENERATE =

# Linker
LSCRIPT = STM32F103X8.ld

# Flashing
OCDFLAGS = -f openocd/openocd.cfg

# Tools
GDB = arm-none-eabi-gdb

GCFLAGS += -DUSB_DEBUG

all:: $(BINDIR)/$(PROJECT).bin $(BINDIR)/$(PROJECT).hex $(BINDIR)/$(BINARY).bin $(BINDIR)/$(BINARY).hex

install: flash

flash: $(BINDIR)/$(PROJECT).bin $(BINDIR)/openocd.pid
	cat openocd/flash.cfg | nc localhost 4444

gdb: $(BINDIR)/openocd.pid
	$(GDB) -ex "target remote localhost:3333" -ex "add-symbol-file $(BOOT_BINDIR)/$(BOOT_BINARY).elf 0x08000000" $(BINDIR)/$(BINARY).elf

start: $(BINDIR)/openocd.pid

stop:
	-echo shutdown | nc localhost 4444

clean: stop

#
# Debug
#

$(BINDIR)/openocd.pid:
	@mkdir -p $(dir $@)
	openocd/run-openocd-server.sh $(OCD) $@

include common/common-bot.mak

