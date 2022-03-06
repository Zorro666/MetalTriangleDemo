//
//  main.m
//  MetalTriangleCPP
//
//  Created by Jake on 09/12/2021.
//  Copyright © 2021 Apple. All rights reserved.
//

#include "MetalCPPView.h"
#include "MetalCPPViewController.h"
#import <Cocoa/Cocoa.h>

int closeWindow = 0;

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (NSApplicationTerminateReply)applicationShouldTerminate:
    (NSApplication *)sender {
  closeWindow = 1;
  return NSTerminateCancel;
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  @autoreleasepool {
    NSEvent *event = [NSEvent otherEventWithType:NSEventTypeApplicationDefined
                                        location:NSMakePoint(0, 0)
                                   modifierFlags:0
                                       timestamp:0
                                    windowNumber:0
                                         context:nil
                                         subtype:0
                                           data1:0
                                           data2:0];
    [NSApp postEvent:event atStart:YES];
    [NSApp stop:nil];
  }
}

@end

@interface WindowDelegate : NSObject {
}
@end

@implementation WindowDelegate

- (BOOL)windowShouldClose:(id)sender {
  closeWindow = 1;
  return NO;
}
@end

void Poll() {
  @autoreleasepool
  {
    for(;;)
    {
      NSEvent *event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                          untilDate:[NSDate distantPast]
                                             inMode:NSDefaultRunLoopMode
                                            dequeue:YES];
      if(event == nil)
        break;

      [NSApp sendEvent:event];
    }
  }
}

void DeleteWindow(NSWindow *window) {
  if(window == nil)
    return;

  @autoreleasepool
  {
    [window orderOut:nil];
    [window setDelegate:nil];

    NSView *view = window.contentView;
    [view release];
    window.contentView = nil;

    [window close];

    Poll();
  }
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {

    AppDelegate *nsAppDelegate = [AppDelegate new];
    assert(nsAppDelegate);

    [NSApp setDelegate:nsAppDelegate];

    if (![[NSRunningApplication currentApplication] isFinishedLaunching])
      [NSApp run];

    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    int width = 640;
    int height = 480;
    NSRect contentRect = NSMakeRect(0, 0, width, height);
    NSWindow *nsWindow =
        [[NSWindow alloc] initWithContentRect:contentRect
                                    styleMask:NSWindowStyleMaskTitled |
                                              NSWindowStyleMaskClosable |
                                              NSWindowStyleMaskMiniaturizable
                                      backing:NSBackingStoreBuffered
                                        defer:NO];

    assert(nsWindow);
    [nsWindow center];

    MetalCPPView *view = [MetalCPPView new];
    NSLog(@"view %p", view);

    MetalCPPViewController *controller = [MetalCPPViewController new];
    NSLog(@"controller %p", controller);

    controller.view = view;
    NSLog(@"controller.view %p", controller.view);

    id windowDelegate = [WindowDelegate new];
    assert(windowDelegate);

    view.layer = [view makeBackingLayer];
    [controller viewDidLoad];

    [nsWindow setContentView:view];
    [nsWindow makeFirstResponder:view];
    [nsWindow setTitle:@"MetalTriangleDemo"];
    [nsWindow setDelegate:windowDelegate];
    [nsWindow setRestorable:NO];

    [nsWindow orderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
    [nsWindow makeKeyAndOrderFront:nil];

    while (!closeWindow) {
      Poll();
    }
    DeleteWindow(nsWindow);
  }
  exit(EXIT_SUCCESS);
}
