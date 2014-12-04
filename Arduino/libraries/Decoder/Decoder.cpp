#include "Arduino.h"
#include "Decoder.h"

#include "Pin.h"
#include "Operation.h"

#define ICLASS       0
#define IOPERARION   1
#define IVALUE       2

Decoder::Decoder() {
    rxIndex = 0;
}

void Decoder::startDecoder(int val) {
    
    rxBuffer[rxIndex++] = val;
    
    if(rxIndex == 3) {
        if(rxBuffer[ICLASS] == MOTOR_CLASS) {
            switch (rxBuffer[IOPERARION]) {
                case MOTOR_CLASS_FORWARD: {
                    motor.moveForward(rxBuffer[IVALUE]);
                } break;
                case MOTOR_CLASS_BACKWARD: {
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
		rxIndex = 0;
    }
}

