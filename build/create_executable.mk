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
# @brief rule of make executable file.#
#
# @author    NAGAYASU Shinya
# @copyright 2017 NAGAYASU Shinya
#
#**************************************************************************************************

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

all_sources += $(local_ld_entry) $(private_sources)
all_targets += $(private_executable_file)

private_executable_file :=
private_binary_image    :=
private_executable_obj  :=
private_clean_executable_file :=
private_ld_scpirt       :=
