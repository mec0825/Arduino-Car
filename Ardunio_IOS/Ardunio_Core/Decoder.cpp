//
//  Decoder.cpp
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#include "Decoder.h"

#include "Pin.h"
#include "Operation.h"

#define ICLASS       0
#define IOPERARION   1
#define IVALUE       2

Decoder::Decoder() {
    
}

void Decoder::startDecoder() {
    
    if(Serial.available() > 0) {
        rxBuffer[rxIndex++] = Serial.read();
        
        if(rxIndex == 3) {
            if(rxBuffer[ICLASS] == MOTOR_CLASS) {
                switch (rxBuffer[IOPERARION]) {
                    case MOTOR_CLASS_FORWARD: {
                        motor.moveForward(rxBuffer[IVALUE]);
                    } break;
                    case MOTOR_CLASS_FORWARD: {
                        motor.moveBackward(rxBuffer[IVALUE]);
                    } break;
                    case MOTOR_CLASS_LEFT: {
                        motor.turnLeft(rxBuffer[IVALUE]);
                    } break;
                    case MOTOR_CLASS_RIGHT: {
                        motor.turnRight(rxBuffer[IVALUE]);
                    } break;
                    case MOTOR_CLASS_STOP: {
                        motor.stop();
                    } break;
                    default:
                        break;
                }
            }
        }
    }
}

