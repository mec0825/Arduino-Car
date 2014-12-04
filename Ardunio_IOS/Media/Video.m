//
//  Video.m
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-11.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#import "Video.h"

@implementation Video

- (AVCaptureDevice *)getFrontCamera {
    
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in cameras) {
        if (device.position == AVCaptureDevicePositionFront)
            return device;
    }
    
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
}

- (id)init {
    if(self = [super init]) {
        
        NSError *error = nil;
        AVCaptureDevice *videoDevice = [self getFrontCamera];
        
        AVCaptureDeviceInput *videoInput =
        [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        
        videoOutput_ = [[AVCaptureVideoDataOutput alloc] init];
        videoOutput_.alwaysDiscardsLateVideoFrames = NO;
        
        NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
        NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
        NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
        
        videoOutput_.videoSettings = videoSettings;
        
//        videoOutput_.videoSettings =    [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
        
        capSession_ = [[AVCaptureSession alloc] init];
        [capSession_ addInput:videoInput];
        [capSession_ addOutput:videoOutput_];
        
        capSession_.sessionPreset = AVCaptureSessionPresetLow;
        
        dispatch_queue_t queue = dispatch_queue_create("MyQueue", NULL);
        [videoOutput_ setSampleBufferDelegate:self queue:queue];
        dispatch_release(queue);
        
    }
    return self;
}

- (void)startSession {
    [capSession_ startRunning];
}

- (void)stopSession {
    [capSession_ stopRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    NSData* mData = UIImageJPEGRepresentation(image, 0.2);
    
    [self.delegate didOutputVideoData:mData];
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer {
    
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
	
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
	
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
	
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress,
                                                 width,
                                                 height,
                                                 8,
												 bytesPerRow,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
	
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
	
    // Create an image object from the Quartz image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
	UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationUp];
	
    // Release the Quartz image
    CGImageRelease(quartzImage);
	
    return (image);
}

@end
