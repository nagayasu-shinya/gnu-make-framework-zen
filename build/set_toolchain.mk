#**************************************************************************************************
#
# @brief toolchain setting.
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
