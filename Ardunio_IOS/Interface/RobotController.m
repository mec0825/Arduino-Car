//
//  RobotController.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-11.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "RobotController.h"

#define IPFIELD_FRAME       CGRectMake(  10,  10, 300,  50)
#define PORTFIELD_FRAME     CGRectMake(  10,  70, 300,  50)

#define SEND_FRMAE          CGRectMake(  10, 400,  80,  50)
#define CONNECT_FRAME       CGRectMake( 230, 400,  80,  50)
#define STOP_FRAME          CGRectMake( 120, 400,  80,  50)

#define BACK_FRAME          CGRectMake(   0,   0, 320, 460)

@implementation RobotController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [video_     release];
    [socket_    release];
    
    [ipText_    release];
    [portText_  release];
    
    [btn_       release];
    
    [super dealloc];
}

static UInt8 video[1];

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    video[0] = VIDEO_DATA;
    
    back_ = [[UIView alloc] initWithFrame:BACK_FRAME];
    [back_ setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:back_];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapped)];
    [tap setDelegate:self];
    [back_ addGestureRecognizer:tap];
    [tap release];
    
    ipText_ = [[UITextField alloc] initWithFrame:IPFIELD_FRAME];
    [ipText_ setBackgroundColor:[UIColor blueColor]];
    //    [ipText_ setPlaceholder:@"ip"];
    [ipText_ setText:@"192.168.0.100"];
    [self.view addSubview:ipText_];
    
    portText_ = [[UITextField alloc] initWithFrame:PORTFIELD_FRAME];
    [portText_ setBackgroundColor:[UIColor blueColor]];
    //    [portText_ setPlaceholder:@"port"];
    [portText_ setText:@"50000"];
    [self.view addSubview:portText_];
    
    btn_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_ setFrame:SEND_FRMAE];
    [btn_ setTitle:@"Start" forState:UIControlStateNormal];
    [btn_ addTarget:self action:@selector(startSession) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_];
    
    stp_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stp_ setFrame:STOP_FRAME];
    [stp_ setTitle:@"Stop" forState:UIControlStateNormal];
    [stp_ addTarget:self action:@selector(stopSession) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stp_];
    
    con_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [con_ setFrame:CONNECT_FRAME];
    [con_ setTitle:@"Connect" forState:UIControlStateNormal];
    [con_ addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:con_];
    
    socket_ = [Socket shareInstance];
    [[Socket shareInstance] setDelegate:self];
    
    video_ = [[Video alloc] init];
    video_.delegate = self;
    
    videoPackage_ = [[NSMutableData alloc] init];
    
    redparkFlow_ = [RedparkFlow shareInstance];
    
    motorController_ = [[MotorController alloc] init];
}

- (void)tapped {
    [ipText_    resignFirstResponder];
    [portText_  resignFirstResponder];
}

- (void)connect {
    NSString* port = [NSString stringWithFormat:@"%@", portText_.text];
    [socket_ connectHost:ipText_.text onPort:[port intValue]];
}

- (void)stopSession {
    if(![socket_ isConnect]) return;
    
    [video_ stopSession];
}

- (void)startSession {
    if(![socket_ isConnect]) return;
    
    [video_ startSession];
}

- (void)didOutputVideoData:(NSData *)data {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [videoPackage_ setLength:0];
        [videoPackage_ appendBytes:video length:1];
        [videoPackage_ appendData:data];
        [socket_ writeData:videoPackage_];
        
    });
}

static bool hasData_ = 0;
static int count = 0;

- (void)didReceiveData:(NSData *)data {
    
    count++;
    
    UInt8* bits = (UInt8*)[data bytes];
    if(bits[0] != CONTROL_DATA) return;
    
    NSData* ndata = [data subdataWithRange:NSMakeRange(1, [data length]-1)];
    
    UInt8* nbits = (UInt8*)[ndata bytes];
    
    switch (nbits[1]) {
        case MOTOR_CLASS_FORWARD: {
            NSLog(@"forward");
//            if(![redparkFlow_ isConnect]) return;
            [redparkFlow_ sendData:[motorController_ moveForward]];
        } break;
        case MOTOR_CLASS_BACKWARD: {
            NSLog(@"backward");
//            if(![redparkFlow_ isConnect]) return;
            [redparkFlow_ sendData:[motorController_ moveBackward]];
        } break;
        case MOTOR_CLASS_LEFT: {
            NSLog(@"left");
//            if(![redparkFlow_ isConnect]) return;
            [redparkFlow_ sendData:[motorController_ turnLeft]];
        } break;
        case MOTOR_CLASS_RIGHT: {
            NSLog(@"right");
//            if(![redparkFlow_ isConnect]) return;
            [redparkFlow_ sendData:[motorController_ turnRight]];
        } break;
//        case MOTOR_CLASS_STOP: {
//            NSL2---og(@"stop");
//            [redparkFlow_ sendData:[motorController_ stop]];
//        } break;
        default:
            break;
    }
    
    [self performSelector:@selector(stop:) withObject:[NSNumber numberWithInt:count] afterDelay:0.5];
//    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stop:) userInfo:[NSNumber numberWithInt:count] repeats:NO];
}

- (void)stop:(NSNumber*)sender {
    if(count > [sender intValue]) return;
    NSLog(@"stop~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    [redparkFlow_ sendData:[motorController_ stop]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
