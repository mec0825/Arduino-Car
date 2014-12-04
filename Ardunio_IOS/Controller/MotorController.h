//
//  MotorController.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-8.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Pin.h"
#import "Data.h"
#import "Operation.h"

@interface MotorController : NSObject {
    Data* data_;
}

- (Data*)moveForward;
- (Data*)moveBackward;
- (Data*)turnRight;
- (Data*)turnLeft;
- (Data*)stop;

@end
