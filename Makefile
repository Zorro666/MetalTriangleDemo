TARGETS := MetalTriangleCPP

# Flags
CFLAGS += -std=c++17

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

x86_64_app: $(SRCS) $(HEADERS) Makefile
	$(CC) $(CFLAGS) $(SRCS) -o $@ $(LIBS) -target x86_64-apple-macos10.12

arm64_app: $(SRCS) $(HEADERS) Makefile
	$(CC) $(CFLAGS) $(SRCS) -o $@ $(LIBS) -target arm64-apple-macos11

MetalTriangleCPP: x86_64_app arm64_app
	lipo -create -output MetalTriangleCPP x86_64_app arm64_app
