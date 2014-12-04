#include "Arduino.h"
#include "Motor.h"

#include "Pin.h"

Motor::Motor() {
    pinMode(PIN_M1, OUTPUT);
	pinMode(PIN_M2, OUTPUT);
	pinMode(ANA_E1, OUTPUT);
	pinMode(ANA_E2, OUTPUT);
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
    digitalWrite(PIN_M1, HIGH);
    digitalWrite(PIN_M2, LOW);
    analogWrite(ANA_E1, val);
    analogWrite(ANA_E2, val);
}

void Motor::turnLeft(int val) {
    digitalWrite(PIN_M1, LOW);
    digitalWrite(PIN_M2, HIGH);
    analogWrite(ANA_E1, val);
    analogWrite(ANA_E2, val);
}

void Motor::stop() {
    digitalWrite(PIN_M1, HIGH);
    digitalWrite(PIN_M2, HIGH);
    analogWrite(ANA_E1, 0x00);
    analogWrite(ANA_E2, 0x00);
}
