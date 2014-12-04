#ifndef __Ardunio_IOS__Motor__
#define __Ardunio_IOS__Motor__

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
