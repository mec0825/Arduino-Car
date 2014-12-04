//
//  LFTAppDelegate.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-7.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MotorViewController.h"
#import "SenderController.h"
#import "VideoController.h"
#import "RobotController.h"

@interface LFTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RobotController *controller;

@end
