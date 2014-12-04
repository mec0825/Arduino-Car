//
//  Motor.cpp
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#include "Motor.h"

#include "Pin.h"

Motor::Motor() {
    
}

void Motor::moveForward(int val) {
    digitalWrite(PIN_M1, LOW);
    digitalWrite(PIN_M2, LOW);
    analogWrite(ANA_E1, val);
    analogWrite(ANA_E2, val);
}

void Motor::moveBackward(int val) {
    digitalWrite(PIN_M1, HIGH);
    digitalWrite(PIN_M2, HIGH);
    analogWrite(ANA_E1, val);
    analogWrite(ANA_E2, val);
}

void Motor::turnRight(int val) {
    digitalWrite(PIN_M1, LOW);
    digitalWrite(PIN_M2, HIGH);
    analogWrite(ANA_E1, val);
    analogWrite(ANA_E2, val);
}

void Motor::turnLeft(int val) {
    digitalWrite(PIN_M1, HIGH);
    digitalWrite(PIN_M2, LOW);
    analogWrite(ANA_E1, val);
    analogWrite(ANA_E2, val);
}

void Motor::stop() {
    digitalWrite(PIN_M1, HIGH);
    digitalWrite(PIN_M2, HIGH);
    analogWrite(ANA_E1, 0x00);
    analogWrite(ANA_E2, 0x00);
}