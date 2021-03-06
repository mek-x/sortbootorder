##
## This file is part of the libpayload project.
##
## Copyright (C) 2008 Advanced Micro Devices, Inc.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions
## are met:
## 1. Redistributions of source code must retain the above copyright
##    notice, this list of conditions and the following disclaimer.
## 2. Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimer in the
##    documentation and/or other materials provided with the distribution.
## 3. The name of the author may not be used to endorse or promote products
##    derived from this software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
## ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
## ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
## FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
## DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
## OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
## LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
## OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
## SUCH DAMAGE.
##

# Sample libpayload Makefile.

COREBOOT_ROOT ?= ../../..
include $(COREBOOT_ROOT)/payloads/libpayload/.xcompile
include $(COREBOOT_ROOT)/payloads/libpayload/.config

ARCH-$(CONFIG_LP_ARCH_ARMV)    := arm
ARCH-$(CONFIG_LP_ARCH_POWERPC) := powerpc
ARCH-$(CONFIG_LP_ARCH_X86)     := i386

CC := $(CC_$(ARCH-y))
AS := $(AS_$(ARCH-y))
LIBPAYLOAD_DIR := $(COREBOOT_ROOT)/payloads/libpayload/install/libpayload
XCC := CC="$(CC)" $(LIBPAYLOAD_DIR)/bin/lpgcc
XAS := AS="$(AS)" $(LIBPAYLOAD_DIR)/bin/lpas
CFLAGS := -Wall -Werror -Os
TARGET := sortbootorder
OBJS := $(patsubst %.c,%.o,$(wildcard *.c))

all: $(TARGET).elf

$(TARGET).elf: $(OBJS)
	$(XCC) -o $@ $(OBJS)

%.o: %.c
	$(XCC) $(CFLAGS) -c -o $@ $<

%.S.o: %.S
	$(XAS) --32 -o $@ $<

clean:
	rm -f $(TARGET).elf *.o

distclean: clean

