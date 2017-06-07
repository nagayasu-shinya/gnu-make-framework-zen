#--------------------------------------------------------------------------------------------------
# @file
# @brief rule of make executable file.
#
#--------------------------------------------------------------------------------------------------

private_sources := $(addprefix $(local_directory)/, $(local_sources))
private_clean_executable_file := $(addprefix clean-,$(private_executable_file))
private_executable_file := $(local_target)

$(eval $(call create-output-directories, $(private_executable_file)))

$(eval $(call create-output-directories, $(local_ld_entry)))

$(eval $(call add-includes, $(private_sources), $(local_includes) $(local_directory)))
$(eval $(call add-cflags,   $(private_sources), $(local_cflags)))

$(eval $(call add-includes, $(local_ld_entry), $(local_includes) $(local_directory)))
$(eval $(call make-executable-file, \
       $(private_executable_file), $(call source-to-object,$(local_ld_entry)), $(local_libraries), $(private_sources), $(local_ldflags)))

$(eval $(call clean-executable-file, \
       $(private_clean_executable_file), $(call source-to-object,$(local_ld_entry)), $(local_libraries)))

all_sources += $(local_ld_entry)
all_targets += $(private_executable_file)

private_executable_file :=
private_binary_image    :=
private_executable_obj  :=
private_clean_executable_file :=
private_ld_scpirt       :=
