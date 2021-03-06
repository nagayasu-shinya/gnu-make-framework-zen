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
# @brief Top of Makefiles
#
# If you build the project, make directory for outputs.
# This Makefiles doesn't change source trees.
# $ mkdir outputs
# $ cd outputs
# $ make -f ../GNUmakefile
#
# If you want to clean all binary files genarated from sources,  do as following.
# $ make -f ../GNUmakefile clean
# Ohter one, just delete all files at output directory.
#
# If you want to clean object files that depend on a module,
# use a target named "clean-MODULE".
# For example, to clean object files that depend on a bsp, do as following.
# $ make -f ../GNUmakefile clean-bsp
#
# When debugging makefiles, it is useful arugment "QUIET=".
# As following, makefile echoes command line.
# $ make -f ../GNUmakefile QUIET=
#
# @author    NAGAYASU Shinya
# @copyright 2017 NAGAYASU Shinya
# @attention Do NOT edit this file if you do not know what you are doing.
#
#**************************************************************************************************

#--------------------------------------------------------------------------------------------------
# Initialize variables for directory that is relative path of CURDIR.
# CURDIR is direcoty where exists this file.
#--------------------------------------------------------------------------------------------------

# Direcoty where exists this file.
TOP_DIR := $(patsubst %/,%,$(dir $(firstword $(MAKEFILE_LIST))))

# Top of source trees.
SOURCE_TREE_DIR := $(TOP_DIR)/src

# Top of external libraries.
LIBRARY_TREE_DIR := $(TOP_DIR)/lib

# Submakefiles that is needed to build using this makefile.
BUILD_DIR := $(TOP_DIR)/build

#--------------------------------------------------------------------------------------------------
# When debugging makefiles, it is useful arugment "QUIET=".
#--------------------------------------------------------------------------------------------------

QUIET := @
ifeq "$(QUIET)"  "@"
DEVNUL := > /dev/null 2>&1
else
DEVNUL :=
endif

#--------------------------------------------------------------------------------------------------
# Target "all" is used when make doesn't have any targets at arguments.
#--------------------------------------------------------------------------------------------------

all:

#--------------------------------------------------------------------------------------------------
# Setting debug level.
#
# release: RELEASE_BUILD
# debug  : DEBUG_BUILD (default)
#
# If you want to set RELEASE_BUILD, do make as following.
# $ make -f ../GNUmakefile VARIANT=RELEASE_BUILD
#--------------------------------------------------------------------------------------------------
VARIANT := DEBUG_BUILD

include $(BUILD_DIR)/set_toolchain.mk
include $(BUILD_DIR)/define_macro.mk
include $(BUILD_DIR)/define_suffix_rule.mk
include $(BUILD_DIR)/define_pattern_rule.mk
include $(BUILD_DIR)/clean_all.mk

#--------------------------------------------------------------------------------------------------
# Initialize modules of submakefiles.
#--------------------------------------------------------------------------------------------------

CLEAR_LOCAL_VARIABLE := $(BUILD_DIR)/clear_local_variable.mk
CREATE_LIBRARY       := $(BUILD_DIR)/create_library.mk
CREATE_EXECUTABLE    := $(BUILD_DIR)/create_executable.mk

#--------------------------------------------------------------------------------------------------
# Check the process environment.
#--------------------------------------------------------------------------------------------------

$(if $(filter $(notdir $(TOP_DIR)),$(notdir $(CURDIR))),$(error Please run the makefile from the binary tree.))
ifeq "$(TOP_DIR)" "."
$(error Please run the makefile from the binary tree.)
endif

#--------------------------------------------------------------------------------------------------
# Set search path for source trees.
#--------------------------------------------------------------------------------------------------

vpath %.so  $(LIBRARY_TREE_DIR)
vpath %.c   $(SOURCE_TREE_DIR)
vpath %.s   $(SOURCE_TREE_DIR)

#==================================================================================================
# These variables have each module.mk files information.
#==================================================================================================

# Note: Set a path from top of source trees.

module-submake-list := $(shell find $(SOURCE_TREE_DIR) -name module.mk)
target-submake-list := $(shell find $(SOURCE_TREE_DIR) -name target.mk)

all_targets :=
all_objects :=
all_sources :=
all_dependencies :=
output-directories :=

#--------------------------------------------------------------------------------------------------
# Include submakefiles.
#--------------------------------------------------------------------------------------------------

include $(target-submake-list)
include $(module-submake-list)

# Dummy variable to make directory.
# The "clean" target doesn't need to make directory.
ifneq "$(MAKECMDGOALS)" "clean"
  dummy-create-output-directories := \
    $(shell for f in $(output-directories); do test -d $$f || mkdir -p $$f; done)
endif


.PHONY: all
all: $(all_targets)
all_objects      += $(call source-to-object,    $(all_sources))
all_dependencies += $(call source-to-dependence,$(all_sources))

#--------------------------------------------------------------------------------------------------
# Include dependencies.
#--------------------------------------------------------------------------------------------------

ifneq "$(MAKECMDGOALS)" "clean"
  -include $(all_dependencies)
endif
