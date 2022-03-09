TARGETS := MetalTriangleDemo

# Flags
CFLAGS += -std=c++17

SRCS_CPP := MetalDraw.cpp
SRCS_OBJC := MetalCPPView.mm MetalCPPViewController.mm main.mm
HEADERS := MetalCPPView.h MetalCPPViewController.h MetalDraw.h

SRCS_CPP += metal/official/metal-cpp.cpp
HEADERS += metal/official/metal-cpp.h

LIBS := -framework Metal -framework Quartz -framework Cocoa -lstdc++
SRCS := $(SRCS_CPP) $(SRCS_OBJC)

all: $(TARGETS)

clean:
	@rm -rvf $(TARGETS)

MetalTriangleDemo: $(SRCS) $(HEADERS) Makefile
	$(CC) $(CFLAGS) $(SRCS) -o $@ $(LIBS)

