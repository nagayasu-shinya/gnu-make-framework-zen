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
# @brief rule of make a library.
#
# @author    NAGAYASU Shinya
# @copyright 2017 NAGAYASU Shinya
#
#**************************************************************************************************

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
