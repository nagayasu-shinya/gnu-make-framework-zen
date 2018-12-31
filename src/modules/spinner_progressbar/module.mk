#**************************************************************************************************
#
# @brief Submakefile to create a library file.
#
#**************************************************************************************************

local_directory := $(subdirectory)

include $(CLEAR_LOCAL_VARIABLE)

local_module    := spinner_progressbar

local_sources   := progressbar.c spinner.c
local_includes  := $(local_directory)
local_cflags    :=
local_libraries :=

include $(CREATE_LIBRARY)
