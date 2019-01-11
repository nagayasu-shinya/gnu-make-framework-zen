#**************************************************************************************************
# MIT License
#
# Copyright (c) 2017 NAGAYASU Shinya
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#---------------------------------------------------------------------------------------------------
#
# @file
# @brief Toolchain setting.
#
# @author    NAGAYASU Shinya
# @copyright 2017 NAGAYASU Shinya
#
#**************************************************************************************************

#--------------------------------------------------------------------------------------------------
# Set architecture fot GCC and GNU Binutils.
#--------------------------------------------------------------------------------------------------

GCC_ARCH :=

CC  := $(GCC_ARCH)gcc
AR  := $(GCC_ARCH)gcc
LD  := $(GCC_ARCH)gcc

#--------------------------------------------------------------------------------------------------
# For gcc.
#--------------------------------------------------------------------------------------------------
CFLAGS :=
ifeq "$(VARIANT)" "DEBUG_BUILD"
  CFLAGS += -O0
  CFLAGS += -g
else
  CFLAGS += -O3
endif
ifneq "$(VARIANT)" ""
CFLAGS += -D$(VARIANT)
endif

CFLAGS += -Wall -Wextra
CFLAGS += -MD
CFLAGS += -fPIC

ARFLAGS := -shared -fPIC

#--------------------------------------------------------------------------------------------------
# Set ccache.
#--------------------------------------------------------------------------------------------------

# "nproc" is not available in Mac OS X.
NPROCESSORS := $(shell (nproc) 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null)
MAKEFLAGS += -j$(NPROCESSORS)
CCACHE := $(shell which ccache)

#--------------------------------------------------------------------------------------------------
# Set GNU objcopy options.
# + Delete path names from symbol name.
# + Add READ ONLY attribute.
#--------------------------------------------------------------------------------------------------
OBJCOPY := $(GCC_ARCH)objcopy

# For ARM.
OBJCOPY_BFDNAME := elf32-littlearm
OBJCOPY_BFARCH  := arm

OBJCOPY_FLAGS =
OBJCOPY_FLAGS += --output-target=$(OBJCOPY_BFDNAME)
OBJCOPY_FLAGS += --binary-architecture=$(OBJCOPY_BFARCH)
OBJCOPY_FLAGS += --redefine-sym _binary_$(subst .,_,$(subst /,_,$<))_start=_binary_$(subst .,_,$(notdir $<))_start
OBJCOPY_FLAGS += --redefine-sym _binary_$(subst .,_,$(subst /,_,$<))_end=_binary_$(subst .,_,$(notdir $<))_end
OBJCOPY_FLAGS += --redefine-sym _binary_$(subst .,_,$(subst /,_,$<))_size=_binary_$(subst .,_,$(notdir $<))_size
OBJCOPY_FLAGS += --rename-section .data=.constdata,alloc,contents,load,readonly,data

#--------------------------------------------------------------------------------------------------
# set Lint.
#--------------------------------------------------------------------------------------------------

SPLINT :=

#--------------------------------------------------------------------------------------------------
# set splint options.
#--------------------------------------------------------------------------------------------------
SPLINT_FLAGS =
#SPLINT_FLAGS += -weak
SPLINT_FLAGS += +skip-sys-headers
SPLINT_FLAGS += +posixlib


IGNORE_EXIT_STATUS = || :




