//
//  Decoder.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#ifndef __Ardunio_IOS__Decoder__
#define __Ardunio_IOS__Decoder__

#include <iostream>
#include "Motor.h"

#define MAX_LENGTH  128

class Decoder {
 private:
    int rxBuffer[MAX_LENGTH];
    int rxIndex = 0;
    
    Motor motor;
 public:
    Decoder();
    
    void startDecoder();
};

#endif /* defined(__Ardunio_IOS__Decoder__) */
