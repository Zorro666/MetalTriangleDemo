TARGETS := MetalTriangleCPP

# Flags
CFLAGS += -std=c++17

ARCH := arm64

SRCS_CPP := MetalDraw.cpp
SRCS_OBJC := MetalCPPView.mm MetalCPPViewController.mm main.mm
HEADERS := MetalCPPView.h MetalCPPViewController.h MetalDraw.h

SRCS_CPP += metal/official/metal-cpp.cpp
HEADERS += metal/official/metal-cpp.h

LIBS := -framework Metal -framework Quartz -framework Cocoa -lstdc++
SRCS := $(SRCS_CPP) $(SRCS_OBJC)
TEMP_OUTPUT := temp

all: $(TARGETS)

clean:
	@rm -rvf $(TARGETS)

MetalTriangleCPP: $(SRCS) $(HEADERS) Makefile
	$(CC) -arch $(ARCH) $(CFLAGS) $(SRCS) -o $@ $(LIBS)
