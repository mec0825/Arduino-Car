//
//  LFTAppDelegate.h
//  Arduino_MAC
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VideoController.h"

@interface LFTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) VideoController* video;

@end
