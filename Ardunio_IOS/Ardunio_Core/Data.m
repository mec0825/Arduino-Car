//
//  Data.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-7.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "Data.h"

#import "Pin.h"
#import "Operation.h"

@implementation Data

- (id)init {
    if(self = [super init]) {
        memset(self.data, 0, sizeof(self.data));
        ptr_ = 0;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)addClass:(UInt8)opr
       operation:(UInt8)adr
           value:(UInt8)val {
    
    if(ptr_ == DATA_LENGTH) {
        //  handle error
        return NO;
    }
    
    data_[ptr_++] = opr;
    data_[ptr_++] = adr;
    data_[ptr_++] = val;
    
    return YES;
}

- (UInt8 *)data {
    return data_;
}

- (int)dataLength {
    return ptr_;
}

- (void)clearAllData {
    ptr_ = 0;
}

- (void)printAllData {
    NSLog(@"------------------------------");
    NSLog(@"|      Operation Package     |");
    NSLog(@"------------------------------");
    NSLog(@"|   cls  |   opr   |   val   |");
    NSLog(@"------------------------------");
    for(int i = 0; i < ptr_/3; i++) {
        NSLog(@"| %04x: | 0x%02x | 0x%02x | 0x%02x |", i, data_[i*3+0], data_[i*3+1], data_[i*3+2]);
    }
    NSLog(@"------------------------------");
}

@end
