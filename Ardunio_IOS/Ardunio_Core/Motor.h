//
//  Motor.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#ifndef __Ardunio_IOS__Motor__
#define __Ardunio_IOS__Motor__

#include <iostream>

class Motor {
 private:
    
 public:
    Motor();
    
    void moveForward(int val);
    void moveBackward(int val);
    void turnRight(int val);
    void turnLeft(int val);
    void stop();
};

#endif /* defined(__Ardunio_IOS__Motor__) */
