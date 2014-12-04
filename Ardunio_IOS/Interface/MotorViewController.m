//
//  MotorViewController.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "MotorViewController.h"

#define MAIN_FRAME      CGRectMake(   0,   0,  50,  50)

#define STATE_FRAME     CGRectMake(   0,   0, 320,  20)

#define RIGHT_CENTER    CGPointMake( 260, 230)
#define LEFT_CENTER     CGPointMake(  60, 230)

#define FORWARD_CENTER  CGPointMake( 160, 130)
#define BACK_CENTER     CGPointMake( 160, 330)

@interface MotorViewController ()

@end

@implementation MotorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [forward_   release];
    [backward_  release];
    [left_      release];
    [right_     release];
    
    [label_     release];
    
    [redparkFlow_       release];
    [motorController_   release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    right_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [right_ setFrame:MAIN_FRAME];
    [right_ setCenter:RIGHT_CENTER];
    [right_ setTitle:@">" forState:UIControlStateNormal];
    [right_ addTarget:self action:@selector(rightPressed) forControlEvents:UIControlEventTouchDown];
    [right_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [right_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view addSubview:right_];
    
    left_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [left_ setFrame:MAIN_FRAME];
    [left_ setCenter:LEFT_CENTER];
    [left_ setTitle:@"<" forState:UIControlStateNormal];
    [left_ addTarget:self action:@selector(leftPressed) forControlEvents:UIControlEventTouchDown];
    [left_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [left_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view addSubview:left_];
    
    forward_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forward_ setFrame:MAIN_FRAME];
    [forward_ setCenter:FORWARD_CENTER];
    [forward_ setTitle:@"^" forState:UIControlStateNormal];
    [forward_ addTarget:self action:@selector(forwardPressed) forControlEvents:UIControlEventTouchDown];
    [forward_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [forward_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view addSubview:forward_];
    
    backward_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backward_ setFrame:MAIN_FRAME];
    [backward_ setCenter:BACK_CENTER];
    [backward_ setTitle:@"v" forState:UIControlStateNormal];
    [backward_ addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchDown];
    [backward_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [backward_ addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view addSubview:backward_];
    
    label_ = [[UILabel alloc] initWithFrame:STATE_FRAME];
    [label_ setText:@"waiting"];
    [self.view addSubview:label_];
    
    redparkFlow_ = [RedparkFlow shareInstance];
    
    motorController_ = [[MotorController alloc] init];
    
    isConnected = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightPressed {
    if(![redparkFlow_ isConnect]) return;
    [label_ setText:@"right"];
    [redparkFlow_ sendData:[motorController_ turnRight]];
}

- (void)leftPressed {
    if(![redparkFlow_ isConnect]) return;
    [label_ setText:@"left"];
    [redparkFlow_ sendData:[motorController_ turnLeft]];
}

- (void)forwardPressed {
    if(![redparkFlow_ isConnect]) return;
    [label_ setText:@"forward"];
    [redparkFlow_ sendData:[motorController_ moveForward]];
}

- (void)backPressed {
    if(![redparkFlow_ isConnect]) return;
    [label_ setText:@"backward"];
    [redparkFlow_ sendData:[motorController_ moveBackward]];
}

- (void)stop {
    if(![redparkFlow_ isConnect]) return;
    [label_ setText:@"stop"];
    [redparkFlow_ sendData:[motorController_ stop]];
}

@end
