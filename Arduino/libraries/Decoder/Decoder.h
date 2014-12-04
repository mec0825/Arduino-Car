#ifndef __Ardunio_IOS__Decoder__
#define __Ardunio_IOS__Decoder__

#include "Motor.h"

#define MAX_LENGTH  128

class Decoder {
 private:
    int rxBuffer[MAX_LENGTH];
    int rxIndex;
    
    Motor motor;
 public:
    Decoder();
    
    void startDecoder(int val);
};

#endif /* defined(__Ardunio_IOS__Decoder__) */
