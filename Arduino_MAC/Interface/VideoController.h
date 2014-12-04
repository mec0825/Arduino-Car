//
//  VideoController.h
//  Arduino_MAC
//
//  Created by MEC0825 on 12-11-11.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Socket.h"
#import "Operation.h"

@interface VideoController : NSObject <SocketDelegate>{
    NSImageView* videoFrame_;
    Socket*      socket_;
    
    NSMutableData* controlPackage_;
}

@end
