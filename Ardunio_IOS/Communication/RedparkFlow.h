//
//  RedparkFlow.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-8.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Data.h"
#import "RscMgr.h"

@interface RedparkFlow : NSObject <RscMgrDelegate> {
    RscMgr* rscMgr_;
    BOOL    isConnect_;
}

+ (RedparkFlow *)shareInstance;

- (void)sendData:(Data*)data;
- (BOOL)isConnect;

@end
