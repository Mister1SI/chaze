# Targets:
#   release   | Compile and link in release mode: make release
#   debug     | Compile and link in debug mode: make debug
#   crelease  | Compile in release mode: make crelease
#   cdebug    | Compile in debug mode: make cdebug
#   clean     | remove all files in obj/ and bin/
#
# Vars to modify:
#   SOURCES--
#     SOURCES_INCLUDE_TYPE  | `include` or `exclude`. Will default to `exclude`
#     SOURCES_INCLUDE       | The only source files you want to include
#     SOURCES_EXCLUDE       | The only source files you do not want to include
#   DEBUG--
#     DBG_EXE       | Name of your debug executable
#     DBG_FLAGS     | Flags used to compile and link in debug mode
#     DBG_CFLAGS    | Additional flags used only to compile in debug mode
#     DBG_LDFLAGS   | Additional flags used only to link in debug mode
#     DBG_LIBS      | Libraries to link into debug mode
#     DBG_LD        | Compiler and linker used for debug mode
#   RELEASE--
#     RLS_EXE       | Name of your release executable
#     RLS_FLAGS     | Flags used to compile and link in release mode
#     RLS_CFLAGS    | Additional flags used only to compile in release mode
#     RLS_LDFLAGS   | Additional flags used only to link in release mode
#     RLS_LIBS      | Libraries to link into release mode
#     RLS_LD        | Compiler and linker used for release mode

# SOURCES
SOURCES_INCLUDE_TYPE = include
SOURCES_INCLUDE = type_example.c
SOURCES_EXCLUDE = type_sizes.c

# DEBUG
DBG_EXE = debug
DBG_FLAGS = -std=c11 -I./include/ -gdwarf-2 -Wall -Wextra -Wpedantic -Werror -fsanitize=address
DBG_CFLAGS =
DBG_LDFLAGS =
DBG_LIBS =
DBG_LD = clang

# RELEASE
RLS_EXE = release
RLS_FLAGS = -std=c11 -I./include/ -O3
RLS_CFLAGS =
RLS_LDFLAGS =
RLS_LIBS =
RLS_LD = gcc

# targets
clean:
	rm -f bin/*
	rm -f obj/rls/*.o
	rm -f obj/dbg/*.o

ifeq ($(SOURCES_INCLUDE_TYPE), include) 
SOURCES = $(patsubst %.c,src/%.c, $(SOURCES_INCLUDE))
else
SOURCES = $(filter-out $(patsubst %.c,src/%.c, $(SOURCES_EXCLUDE)), $(wildcard src/*.c))
endif

# debug mode make targets
DBG_OBJECTS =$(patsubst src/%.c,obj/dbg/%.o, $(SOURCES))

cdebug: $(DBG_OBJECTS)

debug: $(DBG_OBJECTS)
	$(DBG_LD) $(DBG_FLAGS) $(DBG_LDFLAGS) $(DBG_OBJECTS) -o bin/$(DBG_EXE) $(DBG_LIBS)

obj/dbg/%.o: src/%.c
	$(DBG_LD) $(DBG_FLAGS) $(DBG_CFLAGS) -c $< -o $@

# release mode make targets
RLS_OBJECTS =$(patsubst src/%.c,obj/rls/%.o, $(SOURCES))

crelease: $(RLS_OBJECTS)

release: $(RLS_OBJECTS)
	$(RLS_LD) $(RLS_FLAGS) $(RLS_LDFLAGS) $(RLS_OBJECTS) -o bin/$(RLS_EXE) $(RLS_LIBS)

obj/rls/%.o: src/%.c
	$(RLS_LD) $(RLS_FLAGS) $(RLS_CFLAGS) -c $< -o $@

