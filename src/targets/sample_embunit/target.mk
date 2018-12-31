#**************************************************************************************************
#
# @brief submakefile to create a executable file.
#
#**************************************************************************************************

local_directory := $(subdirectory)
include $(CLEAR_LOCAL_VARIABLE)

local_target    := sample_embunit


local_libraries := embunit 
local_ld_entry  := $(local_directory)/AllTests.c
local_sources   :=
local_sources   += counter.c
local_sources   += counterTest.c
local_sources   += person.c
local_sources   += personTest.c

local_includes  := modules/embunit

include $(CREATE_EXECUTABLE)
