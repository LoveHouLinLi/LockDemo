//
//  NSRecursiveLockControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "NSRecursiveLockControl.h"

@implementation NSRecursiveLockControl
{
    // 递归锁
    NSRecursiveLock *lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

// 获取 imageNames
- (void)getImageName:(NSMutableArray *)imageNames
{
    NSString *imageName;
    [lock lock];
    if (imageNames.count > 0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
        // 循环删除   这点和
        [self getImageName:imageNames];
    }
    [lock unlock];
}

//
- (void)getIamgeNameWithMutiThread
{
    //
    dispatch_group_t dispatchGroup = dispatch_group_create();
    NSLog(@"开始删除数组");
    then = CFAbsoluteTimeGetCurrent();
    
    //  递归方法 递归锁
    dispatch_group_async(dispatchGroup, self.syncronizationQueue, ^{
        [self getImageName:imageNameArray];
    });
    
    //
    dispatch_group_notify(dispatchGroup, self.syncronizationQueue, ^{
        now = CFAbsoluteTimeGetCurrent();
        printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
    });
}




@end


















































































