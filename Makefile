# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#     Compilation Options
# Debug mode [yes/no] (allowing to debug via gdb):
DEBUG   ?= no
# Specify your favourite C compiler here:
COMPILE ?= gcc


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#     Preparations
# Compile as ANSI C code:
CFLAGS   = -xc -ansi -Wall
# Debug and optimisation (as well as -static for valgrind) are not compatible:
ifeq '$(DEBUG)' 'yes'
CFLAGS  += -g -O0
else
CFLAGS  += -O3
LFLAGS  += -static
endif

INCDIRS  = -I dep/magi/include
LIBDIRS  = -L dep/magi/build
LIBS     = -lmagi
MAGI     = dep/magi/build/libmagi.a


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#     Targets
# Produce cart CGI:
magistyle: main.c $(MAGI)
	$(COMPILE) $(CFLAGS) $(INCDIRS) $< $(LIBDIRS) $(LIBS) -o $@

$(MAGI):
	cd magi; make

.PHONY: clean
clean:
	rm -f magistyle
