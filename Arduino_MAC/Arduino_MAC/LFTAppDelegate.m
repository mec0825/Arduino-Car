//
//  LFTAppDelegate.m
//  Arduino_MAC
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "LFTAppDelegate.h"

#import "Socket.h"

@implementation LFTAppDelegate

- (void)dealloc
{
    [_video release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self performSelector:@selector(delay) withObject:nil afterDelay:1];
}

- (void)delay {
    _video = [[VideoController alloc] init];
}

@end
