//
//  Socket.h
//  Arduino_MAC
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncSocket.h"

#define VIDEO_DATA      0x01
#define CONTROL_DATA    0x02

@protocol SocketDelegate <NSObject>

- (void)didReceiveData:(NSData*)data;

@end

@interface Socket : NSObject {
    AsyncSocket*    server_;
    NSMutableArray* clients_;
    BOOL            isConnect_;
}

@property (assign, nonatomic) id <SocketDelegate> delegate;

- (void)startListenOnPort:(int)port;

- (void)writeData:(NSData*)data;

- (BOOL)isConnect;

@end
