//@import Metal;

#import "MetalCPPView.h"
#import "MetalDraw.h"
#import <QuartzCore/CAMetalLayer.h>

extern int closeWindow;

@implementation MetalCPPView {
  CVDisplayLinkRef displayLink;
  CAMetalLayer *metalLayer;
  MetalDraw *metalDraw;
}

- (BOOL)wantsUpdateLayer {
  return YES;
}

+ (Class)layerClass {
  return [CAMetalLayer class];
}

- (CALayer *)makeBackingLayer {

  CALayer *layer = [self.class.layerClass layer];
  CGSize viewScale = [self convertSizeToBacking:CGSizeMake(1.0, 1.0)];
  layer.contentsScale = MIN(viewScale.width, viewScale.height);
  return layer;
}

- (void)viewDidEndLiveResize {
  CGSize viewScale = [self convertSizeToBacking:CGSizeMake(1.0, 1.0)];
  self.layer.contentsScale = MIN(viewScale.width, viewScale.height);
}

- (void)loaded {
  @autoreleasepool {
    NSLog(@"view loaded");
    metalDraw = CreateMetalDraw();

    metalDraw->Loaded();
    metalLayer = (CAMetalLayer *)[self layer];
    assert(metalLayer);
    metalLayer.device = (__bridge id<MTLDevice>)metalDraw->device;
    metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    metalLayer.framebufferOnly = YES;
  }
}

- (void)draw {
  @autoreleasepool {
    id<CAMetalDrawable> drawable = [metalLayer nextDrawable];
    CA::MetalDrawable *pMetalCppDrawable =
        (__bridge CA::MetalDrawable *)drawable;
    metalDraw->Draw(pMetalCppDrawable);
  }
}

- (void)keyDown:(NSEvent *)event {
  const int key = [event keyCode];
  NSLog(@"KEYDOWN %d", key);
  [self interpretKeyEvents:@[ event ]];
  if (key == 0x35) {
    NSLog(@"KEYDOWN ESCAPE");
    closeWindow = 1;
  }
}

- (void)insertText:(id)string replacementRange:(NSRange)replacementRange {
}

- (void)setMarkedText:(id)string
        selectedRange:(NSRange)selectedRange
     replacementRange:(NSRange)replacementRange {
}

- (void)unmarkText {
}

- (NSRange)selectedRange {
  return {NSNotFound, 0};
}

- (NSRange)markedRange {
  return {NSNotFound, 0};
}

- (BOOL)hasMarkedText {
  return NO;
}

- (NSAttributedString *)attributedSubstringForProposedRange:(NSRange)range
                                                actualRange:(NSRangePointer)
                                                                actualRange {
  return nil;
}

- (NSArray *)validAttributesForMarkedText {
  return [NSArray array];
}

- (NSRect)firstRectForCharacterRange:(NSRange)range
                         actualRange:(NSRangePointer)actualRange {
  //  const NSRect frame = [window->view frame];
  //  return NSMakeRect(frame.origin.x, frame.origin.y, 0.0, 0.0);
  return NSMakeRect(0, 0, 0.0, 0.0);
}

- (NSUInteger)characterIndexForPoint:(NSPoint)point {
  return 0;
}

@end
