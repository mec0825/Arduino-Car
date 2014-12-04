//
//  Video.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-11.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>

@protocol VideoDelegate <NSObject>

- (void)didOutputVideoData:(NSData*)data;

@end

@interface Video : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>{
    AVCaptureVideoDataOutput*   videoOutput_;
    AVCaptureSession*           capSession_;
}

@property (assign, nonatomic) id <VideoDelegate> delegate;

- (void)startSession;
- (void)stopSession;

@end
