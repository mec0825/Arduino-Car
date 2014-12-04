//
//  SenderController.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-10.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Socket.h"

@interface SenderController : UIViewController <UIGestureRecognizerDelegate>{
    Socket* socket_;
    
    UIView* back_;
    
    UITextField* ipText_;
    UITextField* portText_;
    UITextField* dataText_;
    
    UIButton* btn_;
    UIButton* con_;
}

@end
