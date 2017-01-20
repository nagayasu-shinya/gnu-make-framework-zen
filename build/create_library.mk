#--------------------------------------------------------------------------------------------------
# @file
# @brief rule of make a library.
#
#--------------------------------------------------------------------------------------------------

private_sources := $(addprefix $(local_directory)/, $(local_sources))
private_library := $(addprefix lib,$(addsuffix .so,$(local_module)))
private_clean_library := $(addprefix clean-,$(patsubst lib%.so,%,$(private_library)))

.PHONY: $(local_module)
$(local_module): $(private_library)

$(eval $(call create-output-directories, $(private_sources)))

$(eval $(call add-cflags, $(private_sources), $(local_cflags)))

$(eval $(call add-includes, $(private_sources), $(local_includes) $(local_directory)))

$(eval $(call make-library, $(private_library), $(private_sources)))

$(eval $(call clean-library, $(private_clean_library), $(private_sources)))

all_targets += $(private_library)
all_sources += $(private_sources)

private_sources :=
private_library :=
private_clean_library :=
