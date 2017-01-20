#**************************************************************************************************
#
# @brief  各モジュールのサブメイクファイル.
#
#**************************************************************************************************

local_directory := $(subdirectory)

include $(CLEAR_LOCAL_VARIABLE)

local_module    := sample_spinner_progressbar

local_sources   := sample_progressbar.c sample_spinner.c
local_includes  := $(local_directory)
local_cflags    :=
local_libraries :=

include $(CREATE_LIBRARY)
