//
//  MotorViewController.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RedparkFlow.h"
#import "MotorController.h"

@interface MotorViewController : UIViewController {
    UIButton *forward_;
    UIButton *backward_;
    UIButton *left_;
    UIButton *right_;
    
    UILabel *label_;
    
    RedparkFlow* redparkFlow_;
    MotorController* motorController_;
    
    BOOL      isConnected;
}

@end
