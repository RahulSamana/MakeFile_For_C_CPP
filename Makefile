CC := g++
CFLAGS := -Wall -g
CPPFLAGS := 
BUILD_DIR := build
SRC_DIRS := src
INCLUDE := include
APP_NAME := practiseApp

# Find all C and C++ files recursively
SOURCES := $(wildcard *.cpp) $(wildcard */*.cpp)
SOURCES += $(wildcard *.c) $(wildcard */*.c)

# String substitution for every C/C++ file.
# As an example, hello.cpp turns into ./build/hello.cpp.o
OBJS := $(SOURCES:%=$(BUILD_DIR)/%.o)

# Every folder in ./src will need to be passed to GCC so that it can find header files
# Add a prefix to INC_DIRS. So moduleA would become -ImoduleA. GCC understands this -I flag
#INC_FLAGS := $(addprefix -I,$(INCLUDE))

# The -MMD and -MP flags together generate Makefiles for us!
# These files will have .d instead of .o as the output.
#CPPFLAGS := $(INC_FLAGS) -MMD -MP

# The final build command
$(BUILD_DIR)/$(APP_NAME): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Build command for C source files
$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# Build command for C++ source files
$(BUILD_DIR)/%.cpp.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: clean
clean:
	@if [ -d $(BUILD_DIR) ]; then\
		rm -r $(BUILD_DIR);\
		echo Clean Successful;\
	else\
	    echo build directory does not exist;\
	fi
