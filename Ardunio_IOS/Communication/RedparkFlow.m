//
//  RedparkFlow.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-8.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "RedparkFlow.h"

@implementation RedparkFlow

static RedparkFlow* redparkFlow_ = nil;

+ (RedparkFlow *)shareInstance {
    @synchronized(self) {
        if(redparkFlow_ == nil) {
            redparkFlow_ = [[self alloc] init];
        }
    }
    return redparkFlow_;
}

- (id)init {
    if(self = [super init]) {
        rscMgr_ = [[RscMgr alloc] init];
        [rscMgr_ setDelegate:self];
        
        isConnect_ = NO;
    }
    return self;
}

- (void)sendData:(Data *)data {
    [rscMgr_ write:data.data Length:data.dataLength];
}

- (BOOL)isConnect {
    return isConnect_;
}

#pragma mark - RscMgrDelegate

- (void)cableConnected:(NSString *)protocol {
    isConnect_ = YES;
}

- (void)cableDisconnected {
    
}

- (void)portStatusChanged {
    
}

- (void)readBytesAvailable:(UInt32)length {
    //
}

- (void)didReceivePortConfig {
    
}

@end
