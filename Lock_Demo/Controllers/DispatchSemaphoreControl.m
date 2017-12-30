//
//  DispatchSemaphoreControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//  

#import "DispatchSemaphoreControl.h"

@interface DispatchSemaphoreControl()
{
    dispatch_semaphore_t semaphore;
}

@end

@implementation DispatchSemaphoreControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        semaphore = dispatch_semaphore_create(1);
    }
    return  self;
}


/**
 dispatch_semaphore_tGCD中信号量，也可以解决资源抢占问题,支持信号通知和信号等待。每当发送一个信号通知，则信号量+1；每当发送一个等待信号时信号量-1,；如果信号量为0则信号会处于等待状态，直到信号量大于0开始执行。
 */
- (void)getImageName
{
    while (true) {
        NSString *imageName;
        
        /**
         *  semaphore：等待信号
         DISPATCH_TIME_FOREVER：等待时间
         wait之后信号量-1，为0
         */
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
//        NSLog(@"imageNames count: %ld",imageNameArray.count);
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
//            dispatch_semaphore_signal(semaphore);
            return;
        }
        
        /**
         *  发送一个信号通知，这时候信号量+1，为1 这样别的线程就可以访问了
         */
        dispatch_semaphore_signal(semaphore);
    }
}




@end






































