//
//  JotImageWriteOperation.m
//  JotUI
//
//  Created by Adam Wulf on 10/30/14.
//  Copyright (c) 2014 Adonit. All rights reserved.
//

#import "JotImageWriteOperation.h"

@implementation JotImageWriteOperation{
    UIImage* imageToWrite;
    NSString* pathToWriteImageTo;
    void(^notifyBlock)();
    BOOL isRunning;
    NSObject* lock;
}

/** Initialize with the provided block. */
- (id) initWithImage:(UIImage*)image andPath:(NSString*)path andNotifyBlock:(void(^)(JotImageWriteOperation*))block{
    if ((self = [super init])){
        pathToWriteImageTo = path;
        imageToWrite = image;
        notifyBlock = block;
        lock = [[NSObject alloc] init];
    }
    return self;
}

-(NSString*) path{
    return pathToWriteImageTo;
}

-(UIImage*) image{
    return imageToWrite;
}

// from NSOperation
- (void) main {
    @synchronized(lock) {
        if([self isCancelled]){
            if(notifyBlock){
                notifyBlock(self);
            }
            return;
        }else{
            isRunning = YES;
        }
    }
    if(![self isCancelled]){
        if(imageToWrite){
//                DebugLog(@"wrote image to: %@", self.path);
            
            [UIImagePNGRepresentation(imageToWrite) writeToFile:pathToWriteImageTo atomically:YES];
        }else{
//                DebugLog(@"nil image, deleting file at: %@", self.path);
            [[NSFileManager defaultManager] removeItemAtPath:pathToWriteImageTo error:nil];
        }
    }else{
        DebugLog(@"cancelled write to: %@", self.path);
    }
    if(notifyBlock){
        notifyBlock(self);
    }
}

-(void) cancel{
    @synchronized(lock){
        if(!isRunning){
            [super cancel];
        }
    }
}


@end
