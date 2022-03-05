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

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    // Setup code that might create autoreleased objects goes here.
    int width = 640;
    int height = 480;
    NSRect contentRect = NSMakeRect(0, 0, width, height);
    NSWindow *nsWindow =
        [[NSWindow alloc] initWithContentRect:contentRect
                                    styleMask:NSWindowStyleMaskTitled |
                                              NSWindowStyleMaskClosable |
                                              NSWindowStyleMaskMiniaturizable |
                                              NSWindowStyleMaskResizable
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

    view.layer = [view makeBackingLayer];
    [controller viewDidLoad];

    [nsWindow setContentView:view];
    [nsWindow makeFirstResponder:view];
    [nsWindow setTitle:@"MetalTriangleDemo"];
    [nsWindow setRestorable:NO];

    [nsWindow orderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
    [nsWindow makeKeyAndOrderFront:nil];
  }
  return NSApplicationMain(argc, argv);
}
