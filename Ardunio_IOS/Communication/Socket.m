//
//  Socket.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "Socket.h"

@implementation Socket

static Socket* socket_ = nil;

+ (Socket *)shareInstance {
    @synchronized(self) {
        if(socket_ == nil) {
            socket_ = [[self alloc] init];
        }
    }
    return socket_;
}

- (id)init {
    if(self = [super init]) {
        client_ = [[AsyncSocket alloc] initWithDelegate:self];
        
        [client_ setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
    return self;
}

- (void)connectHost:(NSString *)host onPort:(int)port {
    NSError *err = nil;
    if([client_ connectToHost:host onPort:port error:&err]) {
        NSLog(@"Socket Connect");
    }
    else {
        NSLog(@"Failed %@", [err description]);
    }
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"Did read data");
    [self.delegate didReceiveData:data];
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"Did connect to host");
    isConnect_ = YES;
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
//    NSLog(@"Did write data");
//    [sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];
    [sock readDataWithTimeout:-1 tag:0];
}

- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
    return [NSRunLoop currentRunLoop];
}

- (void)writeData:(NSData *)data {
    [client_ writeData:data withTimeout:-1 tag:0];
}

- (BOOL)isConnect {
    return isConnect_;
}

@end
