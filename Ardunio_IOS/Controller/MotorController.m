//
//  MotorController.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-8.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "MotorController.h"

#define HIGH    1
#define LOW     0

@implementation MotorController

- (id)init {
    if(self = [super init]) {
        data_ = [[Data alloc] init];
    }
    return self;
}

- (Data *)moveForward {
    
    [data_ clearAllData];
    
    ADD(data_, MOTOR_CLASS, MOTOR_CLASS_FORWARD, 0xff);
    
    return data_;
}

- (Data *)moveBackward {
    
    [data_ clearAllData];
    
    ADD(data_, MOTOR_CLASS, MOTOR_CLASS_BACKWARD, 0xff);
    
    return data_;
}

- (Data *)turnRight {
    
    [data_ clearAllData];
    
    ADD(data_, MOTOR_CLASS, MOTOR_CLASS_RIGHT, 0xff);
    
    return data_;
}

- (Data *)turnLeft {
    
    [data_ clearAllData];
    
    ADD(data_, MOTOR_CLASS, MOTOR_CLASS_LEFT, 0xff);
    
    return data_;
}

- (Data *)stop {
    
    [data_ clearAllData];
    
    ADD(data_, MOTOR_CLASS, MOTOR_CLASS_STOP, 0x00);
    
    return data_;
}

@end
