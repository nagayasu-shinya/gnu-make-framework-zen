#**************************************************************************************************
#
# @brief Submakefile to create a library file.
#
#**************************************************************************************************

local_directory := $(subdirectory)

include $(CLEAR_LOCAL_VARIABLE)

local_module    := embunit

local_sources    := $(call local-all-sources,$(local_directory))
#local_sources   += AssertImpl.c
#local_sources   += TestCaller.c
#local_sources   += TestResult.c
#local_sources   += TestSuite.c
#local_sources   += RepeatedTest.c
#local_sources   += TestCase.c
#local_sources   += TestRunner.c
#local_sources   += stdImpl.c

local_includes  := $(local_directory)
local_cflags    :=
local_libraries :=

include $(CREATE_LIBRARY)
