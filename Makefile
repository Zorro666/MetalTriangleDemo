TARGETS := MetalTriangleCPP.app

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
	@rm -rvf $(TEMP_OUTPUT)

$(TEMP_OUTPUT)/MetalTriangleCPP: $(SRCS) $(HEADERS) Makefile
	mkdir -p $(TEMP_OUTPUT)
	mkdir -p MetalTriangleCPP.app/Contents/MacOS
	mkdir -p MetalTriangleCPP.app/Contents/Resources
	$(CC) -arch $(ARCH) $(CFLAGS) $(SRCS) -o $@ $(LIBS)
#	ibtool --errors --warnings --notices --output-format human-readable-text --compile MetalTriangleCPP.app/Contents/Resources/en.lproj/MainMenu.nib en.lproj/MainMenu.xib


MetalTriangleCPP.app: $(TEMP_OUTPUT)/MetalTriangleCPP Makefile
	cp $(TEMP_OUTPUT)/MetalTriangleCPP $@/Contents/MacOS/MetalTriangleCPP
	cp ./Info.plist $@/Contents
	cp -r ./Resources $@/Contents
	rm -f $(TEMP_OUTPUT)/MetalTriangleCPP
	touch $@
