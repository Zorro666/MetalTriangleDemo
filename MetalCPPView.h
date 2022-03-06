#import <Cocoa/Cocoa.h>

@interface MetalCPPView : NSView <NSTextInputClient>

- (void)loaded;
- (void)draw;

@end
