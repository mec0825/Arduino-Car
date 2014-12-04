//
//  Socket.h
//  Ardunio_IOS
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
    AsyncSocket* client_;
    BOOL         isConnect_;
}

@property (assign, nonatomic) id <SocketDelegate> delegate;

+ (Socket *)shareInstance;

- (void)connectHost:(NSString*)host onPort:(int)port;

- (void)writeData:(NSData*)data;

- (BOOL)isConnect;

@end
