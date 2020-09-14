gnu-make-framework-zen
==========================

This is a GNU makefile framework which helps your development in environment without support of IDE.

# Features

This gnu-make-framework-zen has these features,

+ Make dependencies automatically
+ Make library at each directory
+ Separating Source and Binary
+ Supporting Multiple Binary Trees
+ Multi platform, GNU/Linux, Mac OS X, MSYS2（Windows）


# Directories structure

## File tree

File tree is as following. It have sample programs, simple spinner and embunit.
（embunit is a test framework for embedded systems)


```
├── GNUmakefile        --- Top Makfile
├── LICENSE.txt        --- License file
├── README.md          --- This file
├── build
│   ├── clean_all.mk            --- To clean all generated objects
│   ├── clear_local_variable.mk --- To initialize variables of submakefiles
│   ├── create_executable.mk    --- Define macro that create executable files
│   ├── create_library.mk       --- Define macro that create libraries
│   ├── define_macro.mk         --- Define util macros
│   ├── define_pattern_rule.mk  --- Define pattern rules
│   ├── define_suffix_rule.mk   --- Define suffix rules
│   └── set_toolchain.mk        --- Set toolchain
└── src
    ├── modules
    │   ├── embunit
    │   │   ├── module.mk       --- Set libraries name and set sources that depend it
    │   │   ├── *.c
    │   │   └── *.h
    │   └── spinner_progressbar
    │       ├── module.mk
    │       ├── *.c
    │       └── *.h
    └── targets
        ├── sample_embunit
        │   ├── target.mk       --- Set executable file name and set source or libraries that depend it
        │   ├── *.c
        │   └── *.h
        └── sample_spinner
            ├── target.mk
            └── *.c
```
# How to use

## make libraries

+ Make directory under src/modules/
+ Put sources at it
+ Make module.mk

### what's module.mk

For example, embunit's module.mk is as following.

```makefile
local_directory := $(subdirectory)
include $(CLEAR_LOCAL_VARIABLE)

local_module    := embunit

local_sources   := AssertImpl.c
local_sources   += TestCaller.c
local_sources   += TestResult.c
local_sources   += TestSuite.c
local_sources   += RepeatedTest.c
local_sources   += TestCase.c
local_sources   += TestRunner.c
local_sources   += stdImpl.c

local_includes  := $(local_directory)
local_cflags    :=
local_libraries :=

include $(CREATE_LIBRARY)
```

First, don't change top of 2 lines, "local_directory := $(subdirectory)", "include $(CLEAR_LOCAL_VARIABLE) ". And, don't change last line, "include $(CREATE_LIBRARY)".
Other lines should be set as following.

| name            | description                                 |
| --------------  | ----------------------------------          |
| local_module    | Library name, prefix ".so" is added by makefile |
| local_sources   | Source files |
| local_includes  | Include path, compiler option "-I" |
| local_cflags    | Compiler option |


## make executable files

+ Make directory under src/targets/
+ Put sources at it
+ Make module.mk

### target.mk の書き方

For example, sample embunit's module.mk is as following.

```makefile

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
```

First, don't change top of 2 lines, "local_directory := $(subdirectory)", "include $(CLEAR_LOCAL_VARIABLE)". And, don't change last line, "include $(CREATE_EXECUTABLE)".
Other lines should be set as following.

| name            | description                                 |
| --------------  | ----------------------------------   |
| local_target    | Executable file name |
| local_library   | Dependencies, don't need prefix ".so" |
| local_ld_entry  | A Source that contain entry point, in general, main function or reset vector |
| local_sources   | Source files |
| local_includes  | Include path, compiler option "-I" |

# How to build sample programs

```sh
$ mkdir outputs
$ cd outputs
$ make -f ../GNUmakefile
$ export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
$ ./sample_programs
```


# License


## Overall license

MIT License

Copyright (c) [2017] [NAGAYASU Shinya]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## Files derived from other sources

### src/modules/embunit/*

MIT/X Consortium License

http://embunit.sourceforge.net/embunit/

# References

https://www.oreilly.com/openbook/make3/book/index.csp
