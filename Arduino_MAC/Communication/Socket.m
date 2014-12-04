//
//  Socket.m
//  Arduino_MAC
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
        server_ = [[AsyncSocket alloc] initWithDelegate:self];
        clients_ = [[NSMutableArray alloc] initWithCapacity:1];
        
        [server_ setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];

    }
    return self;
}

- (void)dealloc {
    [server_    release];
    [clients_   release];
    
    [super dealloc];
}

- (void)startListenOnPort:(int)port {
    NSError *err = nil;
    if([server_ acceptOnPort:port error:&err]) {
        NSLog(@"Accept");
    }
    else {
        NSLog(@"Failed %@", [err description]);
        for(int i = 0; i < [clients_ count]; i++) {
			// Call disconnect on the socket,
			// which will invoke the onSocketDidDisconnect: method,
			// which will remove the socket from the list.
			[[clients_ objectAtIndex:i] disconnect];
		}
    }
}

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket {
    NSLog(@"Add new socket");
    [clients_ addObject:newSocket];
}


- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"Did connect");
    isConnect_ = YES;
    server_ = sock;
    
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"Did write data");
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
//    NSLog(@"Did read data %ld", tag);
    [self.delegate didReceiveData:data];
    
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    NSLog(@"Will disconnect");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"Did disconnect");
	[clients_ removeObject:sock];
}

- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket {
    return [NSRunLoop currentRunLoop];
}

- (void)writeData:(NSData *)data {
    [server_ writeData:data withTimeout:-1 tag:0];
}

- (BOOL)isConnect {
    return isConnect_;
}

@end
