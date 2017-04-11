#**************************************************************************************************
#
# @brief サンプルコードのサブメイクファイル
#
#**************************************************************************************************

local_directory := $(subdirectory)
include $(CLEAR_LOCAL_VARIABLE)

local_target    := sample_program
local_libraries := spinner_progressbar

local_ld_entry  := $(local_directory)/main.c
local_includes  := modules/spinner_progressbar

include $(CREATE_EXECUTABLE)
