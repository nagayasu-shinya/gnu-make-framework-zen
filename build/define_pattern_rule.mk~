#**************************************************************************************************
#
# @brief standard pattern rules.
#
#**************************************************************************************************

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $*.o

%.o : %.bin
	$(OBJCOPY) -I binary -O elf32-littlearm -B arm $(OBJCOPY_FLAGS)  $< $*.o

## this rule is not nessary. dont use.
#%.d : %.c
#	$(CC) $(CFLAGS) -c $< -o $*.o
