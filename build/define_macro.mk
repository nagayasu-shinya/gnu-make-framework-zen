#**************************************************************************************************
#
# @brief define macros.
#
#**************************************************************************************************

#--------------------------------------------------------------------------------------------------
# create objects file list(objects) from source file list(sources).
# $(call souce-to-object, source-file-list)
#--------------------------------------------------------------------------------------------------
source-to-object = $(subst .c,.o,$(filter %.c,$1)) \
                   $(subst .s,.o,$(filter %.s,$1)) \
                   $(subst .arm,.o,$(filter %.arm,$1))

source-to-dependence = $(subst .c,.d,$(filter %.c,$1)) \
                       $(subst .s,.d,$(filter %.s,$1)) \
                       $(subst .arm,.d,$(filter %.arm,$1))

#--------------------------------------------------------------------------------------------------
# path of module.mk.
# $(subdirectory)
#--------------------------------------------------------------------------------------------------
subdirectory = $(patsubst $(SOURCE_TREE_DIR)/%/,%, $(dir $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))))

get-local-dir = $(patsubst $(SOURCE_TREE_DIR)/%/,%, $(dir $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))))

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
# $(call make-executable-file exec, start_entry, libraries, ldflags)
#--------------------------------------------------------------------------------------------------
define make-executable-file
  $1: $2 $(addprefix lib,$(addsuffix .so,$3))
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
