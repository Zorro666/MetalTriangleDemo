TARGETS := MetalTriangleDemo

# Flags
CXXFLAGS += -std=c++17

SRCS_CPP := MetalDraw.cpp
SRCS_OBJC := MetalCPPView.mm MetalCPPViewController.mm main.mm
HEADERS := MetalCPPView.h MetalCPPViewController.h MetalDraw.h

SRCS_CPP += metal/official/metal-cpp.cpp
HEADERS += metal/official/metal-cpp.h

LIBS := -framework Metal -framework Quartz -framework Cocoa -lstdc++
OBJS := $(SRCS_CPP:.cpp=.o)
OBJS += $(SRCS_OBJC:.mm=.o)

%.o: %.mm
	$(CC) -o $@ -c $< $(CXXFLAGS)

all: $(TARGETS)

clean:
	@rm -rvf $(TARGETS)

MetalTriangleDemo: $(OBJS)
	$(CC) -o $@ $^ $(LIBS)

