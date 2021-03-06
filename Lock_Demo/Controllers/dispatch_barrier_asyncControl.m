//
//  dispatch_barrier_asyncControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/5.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "dispatch_barrier_asyncControl.h"

@implementation dispatch_barrier_asyncControl

/*
 dispatch_barrier_async/dispatch_barrier_sync在一定的基础上也可以做线程同步，会在线程队列中打断其他线程执行当前任务，也就是说只有用在并发的线程队列中才会有效，因为串行队列本来就是一个一个的执行的，你打断执行一个和插入一个是一样的效果。两个的区别是是否等待任务执行完成。
 */
- (void)getImageName
{
    while (true) {
        NSString *imageName;
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,(unsigned long)imageNameArray.count);
            break;
        }
    }
}

- (void)getIamgeNameWithMutiThread
{
    NSLog(@"开始 删除 数组");
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0;i<3;i++){
        dispatch_barrier_async(self.syncronizationQueue, ^{
            [self getImageName];
        });
    }
    
}

@end
