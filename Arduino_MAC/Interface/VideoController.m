//
//  VideoController.m
//  Arduino_MAC
//
//  Created by MEC0825 on 12-11-11.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "VideoController.h"

@implementation VideoController

static UInt8 ctl[1];
static UInt8 opr[3];
static UInt8 stp[3];

- (id)init {
    if(self = [super init]) {
        
        ctl[0] = CONTROL_DATA;
        controlPackage_ = [[NSMutableData alloc] init];
        
        NSEvent * (^monitorHandler)(NSEvent *);
        monitorHandler = ^NSEvent * (NSEvent * theEvent){
            
            [controlPackage_ setLength:0];
            [controlPackage_ appendBytes:ctl length:1];
            
            switch (theEvent.keyCode) {
                case 126: {
                    opr[0] = MOTOR_CLASS;
                    opr[1] = MOTOR_CLASS_FORWARD;
                    opr[2] = 0xff;
                } break;
                case 125: {
                    opr[0] = MOTOR_CLASS;
                    opr[1] = MOTOR_CLASS_BACKWARD;
                    opr[2] = 0xff;
                } break;
                case 124: {
                    opr[0] = MOTOR_CLASS;
                    opr[1] = MOTOR_CLASS_RIGHT;
                    opr[2] = 0xff;
                } break;
                case 123: {
                    opr[0] = MOTOR_CLASS;
                    opr[1] = MOTOR_CLASS_LEFT;
                    opr[2] = 0xff;
                } break;
                default:
                    break;
            }
            
            [controlPackage_ appendBytes:opr length:3];
            
            [socket_ writeData:controlPackage_];
            
            return theEvent;
        };
        
        [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:monitorHandler];
        
        NSWindow* window = [[NSApplication sharedApplication] keyWindow];
        
        NSRect r = [[NSScreen mainScreen] visibleFrame];
        [window setFrame:NSMakeRect(0, 0, 300, 300) display:YES];
        
        [window setFrameOrigin:NSMakePoint((r.size.width-[window frame].size.width)/2,
                                           (r.size.height-[window frame].size.height)/2)];
        [window setStyleMask: NSTitledWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask];
        
        videoFrame_ = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 300, 300)];
        [videoFrame_ setImage: [NSImage imageNamed: @"刀刀-6.jpg"]];
        [videoFrame_ setImageScaling:2];
        [window.contentView addSubview:videoFrame_];
        
        socket_ = [[Socket alloc] init];
        [socket_ setDelegate:self];
        [socket_ startListenOnPort:50000];
    }
    return self;
}

-(void)dealloc {
    [videoFrame_    release];
    [socket_        release];
    
    [super dealloc];
}

- (void)didReceiveData:(NSData *)data {
    
    UInt8* bits = (UInt8*)[data bytes];
    if(bits[0] != VIDEO_DATA) return;
    
    NSData* ndata = [data subdataWithRange:NSMakeRange(1, [data length]-1)];
    
    if([self isJPEGValid:ndata] == NO) return;
    
    NSImage* image = [[NSImage alloc] initWithData:ndata];
    [image setCacheMode:NSImageCacheNever];
    
    [videoFrame_ setImage:image];
    [image release];
    
}

- (BOOL)isJPEGValid:(NSData *)jpeg {
    if ([jpeg length] < 4) return NO;
    
    const unsigned char * bytes = (const unsigned char *)[jpeg bytes];
    
    if (bytes[0] != 0xFF || bytes[1] != 0xD8) return NO;
    if (bytes[[jpeg length] - 2] != 0xFF ||
        bytes[[jpeg length] - 1] != 0xD9) return NO;
    
    return YES;
}

@end
