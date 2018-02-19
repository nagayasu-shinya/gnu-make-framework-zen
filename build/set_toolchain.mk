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
# @brief toolchain setting.
#
# @author    NAGAYASU Shinya
# @copyright 2017 NAGAYASU Shinya
#
#**************************************************************************************************

#--------------------------------------------------------------------------------------------------
# set architecture fot GCC and GNU Binutils.
#--------------------------------------------------------------------------------------------------

GCC_ARCH :=

CC  := $(GCC_ARCH)gcc
AR  := $(GCC_ARCH)gcc
LD  := $(GCC_ARCH)gcc

#--------------------------------------------------------------------------------------------------
# for gcc.
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


NPROCESSORS :=
ifneq "$(shell which nproc)" ""
    NPROCESSORS  = $(shell nproc)
else ifneq "$(shell which getconf _NPROCESSORS_ONLN))" ""
# Mac OS X is not available nproc.
    NPROCESSORS = $(shell getconf _NPROCESSORS_ONLN)
endif

MAKEFLAGS += -j$(NPROCESSORS)

#--------------------------------------------------------------------------------------------------
# set objcopy.
#--------------------------------------------------------------------------------------------------
OBJCOPY := $(GCC_ARCH)objcopy

#--------------------------------------------------------------------------------------------------
# set GNU objcopy options.
# + delete path names from symbol name.
# + add READ ONLY attribute.
#--------------------------------------------------------------------------------------------------
OBJCOPY_FLAGS =
OBJCOPY_FLAGS += --redefine-sym _binary_$(subst .,_,$(subst /,_,$<))_start=_binary_$(subst .,_,$(notdir $<))_start
OBJCOPY_FLAGS += --redefine-sym _binary_$(subst .,_,$(subst /,_,$<))_end=_binary_$(subst .,_,$(notdir $<))_end
OBJCOPY_FLAGS += --redefine-sym _binary_$(subst .,_,$(subst /,_,$<))_size=_binary_$(subst .,_,$(notdir $<))_size
OBJCOPY_FLAGS += --rename-section .data=.constdata,alloc,contents,load,readonly,data
