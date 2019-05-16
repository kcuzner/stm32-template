# Common build elements for this project
#

# Binary target
BINARY = $(PROJECT)

# Project structure
SRCDIRS = src
GENSRCDIRS = src
BINDIR = bin
OBJDIR = obj
GENDIR = obj/gen
INCDIRS = include
LDINCDIRS =
CSRCDIRS = $(SRCDIRS)
SSRCDIRS = $(SRCDIRS)

# Project target
CPU = cortex-m3

# Linker
LSCRIPT = STM32F103X8.ld

# Sources
GENERATE =
SRC = $(foreach DIR,$(CSRCDIRS),$(wildcard $(DIR)/*.c))
GENSRC = $(foreach DIR,$(GENSRCDIRS),$(wildcard $(DIR)/*.c))
ASM = $(foreach DIR,$(SSRCDIRS),$(wildcard $(DIR)/*.s))

# Include directories
INCLUDE  = $(foreach DIR,$(INCDIRS),-I$(DIR)) -I$(GENDIR) -I.
LDINCLUDE = $(foreach DIR,$(LDINCDIRS),-L$(DIR))

# C Flags
GCFLAGS  = -std=c11 -Wall -Os -fno-common -mthumb -mcpu=$(CPU) -DSTM32F103xB --specs=nosys.specs --specs=nano.specs -g -Wa,-ahlms=$(addprefix $(OBJDIR)/,$(notdir $(<:.c=.lst)))
GCFLAGS += $(INCLUDE)
CFLAGS  += $(GCFLAGS)
LDFLAGS += -T$(LSCRIPT) -mthumb -mcpu=$(CPU) --specs=nosys.specs --specs=nano.specs -Wl,-Map,$(BINDIR)/$(BINARY).map -Wl,--gc-sections
LDFLAGS += $(LDINCLUDE)
ASFLAGS += -mcpu=$(CPU)

# Flashing
OCDFLAGS = -f openocd/openocd.cfg

# Output manipulation
OBJCOPY_FLAGS =

# Tools
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
AR = arm-none-eabi-ar
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size --format=SysV
OBJDUMP = arm-none-eabi-objdump
OCD = openocd
RM = rm -rf

# Code Generation
PYTHON = python3
SCRIPTDIR = ./scripts
#DESCRIPTORGEN = $(PYTHON) $(SCRIPTDIR)/descriptorgen.py
#STORAGEGEN_SCRIPT = $(SCRIPTDIR)/storagegen.py
#STORAGEGEN = $(PYTHON) $(STORAGEGEN_SCRIPT)
#FIRMWAREGEN = $(PYTHON) $(SCRIPTDIR)/firmwaregen.py

