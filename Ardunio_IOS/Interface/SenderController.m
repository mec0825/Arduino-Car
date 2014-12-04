//
//  SenderController.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "SenderController.h"

#define IPFIELD_FRAME       CGRectMake(  10,  10, 300,  50)
#define PORTFIELD_FRAME     CGRectMake(  10,  70, 300,  50)
#define DATAFIELD_FRAME     CGRectMake(  10, 130, 300,  50)

#define SEND_FRMAE          CGRectMake(  10, 400, 100,  50)
#define CONNECT_FRAME       CGRectMake( 210, 400, 100,  50)

#define BACK_FRAME          CGRectMake(   0,   0, 320, 460)

@interface SenderController ()

@end

@implementation SenderController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [socket_    release];
    
    [ipText_    release];
    [portText_  release];
    [dataText_  release];
    
    [btn_       release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    [ipText_ setPlaceholder:@"ip"];
    [self.view addSubview:ipText_];
    
    portText_ = [[UITextField alloc] initWithFrame:PORTFIELD_FRAME];
    [portText_ setBackgroundColor:[UIColor blueColor]];
    [portText_ setPlaceholder:@"port"];
    [self.view addSubview:portText_];
    
    dataText_ = [[UITextField alloc] initWithFrame:DATAFIELD_FRAME];
    [dataText_ setBackgroundColor:[UIColor blueColor]];
    [dataText_ setPlaceholder:@"data"];
    [self.view addSubview:dataText_];
    
    btn_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_ setFrame:SEND_FRMAE];
    [btn_ setTitle:@"Send" forState:UIControlStateNormal];
    [btn_ addTarget:self action:@selector(sendData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_];
    
    con_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [con_ setFrame:CONNECT_FRAME];
    [con_ setTitle:@"Connect" forState:UIControlStateNormal];
    [con_ addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:con_];
    
    socket_ = [Socket shareInstance];
}

- (void)tapped {
    [ipText_    resignFirstResponder];
    [portText_  resignFirstResponder];
    [dataText_  resignFirstResponder];
}

- (void)connect {
    NSString* port = [NSString stringWithFormat:@"%@", portText_.text];
    [socket_ connectHost:ipText_.text onPort:[port intValue]];
}

- (void)sendData {
    if(![socket_ isConnect]) return;
    
    [socket_ writeData:[dataText_.text dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
