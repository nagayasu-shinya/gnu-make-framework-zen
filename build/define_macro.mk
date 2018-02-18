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
# @brief define macros.
#
# @author    NAGAYASU Shinya
# @copyright 2017 NAGAYASU Shinya
#
#**************************************************************************************************

#--------------------------------------------------------------------------------------------------
# create objects file list(objects) from source file list(sources).
# $(call souce-to-object, source-file-list)
#--------------------------------------------------------------------------------------------------
source-to-object = $(subst   .c,.o,$(filter   %.c,$1)) \
                   $(subst .cpp,.o,$(filter %.cpp,$1)) \
                   $(subst .cxx,.o,$(filter %.cxx,$1)) \
                   $(subst   .s,.o,$(filter   %.s,$1)) \
                   $(subst .arm,.o,$(filter %.arm,$1))

source-to-dependence = $(subst   .c,.d,$(filter   %.c,$1)) \
                       $(subst .cpp,.d,$(filter %.cpp,$1)) \
                       $(subst .cxx,.d,$(filter %.cxx,$1)) \
                       $(subst   .s,.d,$(filter   %.s,$1)) \
                       $(subst .arm,.d,$(filter %.arm,$1))

#--------------------------------------------------------------------------------------------------
# all sources at directory
# $(call local-all-sources, directory)
#--------------------------------------------------------------------------------------------------
local-all-sources = $(notdir $(wildcard $(addprefix $(SOURCE_TREE_DIR)/$1/,*.c *.cpp *.cxx *.s *.arm)))

#--------------------------------------------------------------------------------------------------
# path of module.mk.
# $(subdirectory)
#--------------------------------------------------------------------------------------------------
subdirectory = $(patsubst $(SOURCE_TREE_DIR)/%/,%, $(dir $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))))

#--------------------------------------------------------------------------------------------------
# create library. (static library.)
# $(call make-library library-name, sources)
#--------------------------------------------------------------------------------------------------
define make-library
  $1: $(call source-to-object,$2)
	$(AR)  $$(ARFLAGS) $$^ -o $$@
endef

#--------------------------------------------------------------------------------------------------
# clean the specified library, and clean only .o that depend on it.
# $(call clean-library library-name, sources)
#--------------------------------------------------------------------------------------------------
define clean-library
  .PHONY: $1
  $1:
	$(QUIET)rm -f $(patsubst clean-%,lib%.so,$1) $(call source-to-object,$2) $(DEVNUL)
endef

#--------------------------------------------------------------------------------------------------
# create obj directory.
# $(call create-output-directories  sources)
#--------------------------------------------------------------------------------------------------
define create-output-directories
  output-directories += $(sort $(dir $1))
# 実際のmkdirは，全出ディレクトリをoutput-directoriesに集めた後に，
# dummy-create-output-directoriesにて行う.
endef

#--------------------------------------------------------------------------------------------------
# create executalble file.
# $(call make-executable-file exec, start_entry, libraries, sources, ldflags)
#--------------------------------------------------------------------------------------------------
define make-executable-file
  $1: $2 $(addprefix lib,$(addsuffix .so,$3)) $(call source-to-object,$4)
	$(LD) $(LDFLAGS) $(local_ldflags) $$^ -o $$@
endef

#--------------------------------------------------------------------------------------------------
# clean the specified executable file, and clean only .o/.so that depend on it.
# $(call clean-executable-file exec, start_entry, libraries)
#--------------------------------------------------------------------------------------------------
define clean-executable-file
  .PHONY: $1
  $1: $(addprefix clean-,$3)
	$(QUIET)rm -f $(patsubst clean-%,%.out,$1) $(patsubst clean-%,%.o,$1) $(patsubst clean-%,%.bin,$1) $(patsubst clean-%,%.map,$1) $2 $(DEVNUL)
endef

#--------------------------------------------------------------------------------------------------
# add include path only specified sources.
# $(call add-includes  target_src, inc-path)
#--------------------------------------------------------------------------------------------------
define add-includes
  $(call source-to-object,$1):  CFLAGS += $(addprefix -I$(SOURCE_TREE_DIR)/,$2)
endef

#--------------------------------------------------------------------------------------------------
# add cflags  only specified sources.
# $(call add-cflags  target_src, cflags-parameter)
#--------------------------------------------------------------------------------------------------
define add-cflags
  $(call source-to-object,$1): CFLAGS += $2
endef

#--------------------------------------------------------------------------------------------------
# add default cflags.  (for all sources.)
# $(call add-default-cflags  cflags_param)
#--------------------------------------------------------------------------------------------------
define add-default-cflags
  CFLAGS += $1
endef
