//
//  RobotController.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-11.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RedparkFlow.h"
#import "MotorController.h"
#import "Video.h"
#import "Socket.h"

@interface RobotController : UIViewController <SocketDelegate, VideoDelegate, UIGestureRecognizerDelegate> {
    Video*  video_;
    Socket* socket_;
    
    RedparkFlow* redparkFlow_;
    MotorController* motorController_;
    
    NSTimer* timer_;
    
    UIView* back_;
    
    UITextField* ipText_;
    UITextField* portText_;
    
    UIButton* btn_;
    UIButton* con_;
    UIButton* stp_;
    
    NSMutableData* videoPackage_;
}

@end
