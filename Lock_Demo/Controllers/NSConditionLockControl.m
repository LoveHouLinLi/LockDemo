//
//  NSConditionLockControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "NSConditionLockControl.h"

@interface NSConditionLockControl()
{
    NSConditionLock *lock;
}

@end


@implementation NSConditionLockControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        lock = [[NSConditionLock alloc] init];
    }
    return self;
}

#pragma mark ---- NSConditionLock 的简单测试
////  重写的方法
//- (void)getImageName
//{
//    while (true) {
//        NSString *imageName;
//        [lock lock];
//        NSLog(@"imageNames count: %ld",imageNameArray.count);
//        if (imageNameArray.count > 0) {
//            imageName = [imageNameArray firstObject];
//            [imageNameArray removeObjectAtIndex:0];
//        }else{
//            now = CFAbsoluteTimeGetCurrent();
//            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
//            return;
//        }
//        [lock unlock];
//
//    }
//}

#pragma mark ----  多线程通信 应用 lock
/*
 NSConditionLock也可以像NSCondition一样做多线程之间的任务等待调用，而且是线程安全的。
 */
- (void)getImageName:(NSMutableArray *)imageNames
{
    NSString *imageName;
    // NSConditionLock 的
    [lock lockWhenCondition:1];
    static int m = 0;   //
    NSLog(@"removeObjectBegin count: %ld\n",imageNames.count);
    if (imageNames.count > 0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
        m++;
        NSLog(@"执行了%d次删除操作",m);
    }
    NSLog(@"removeObject count: %ld\n",imageNames.count);
    
//    [lock unlockWithCondition:1];  //
    [lock unlockWithCondition:0];  // 解锁 0 的方法  也就是create 的方法  
    
}

//
- (void)createImageName:(NSMutableArray *)imageNames
{
    [lock lockWhenCondition:0];
    static int m = 0;   // m
    [imageNames addObject:@"0"];
    m++;
    NSLog(@"添加了%d次",m);
    NSLog(@"createImageName count: %ld\n",imageNames.count);
    [lock unlockWithCondition:1];
}

//

- (void)getIamgeNameWithMutiThread
{
    NSMutableArray *imageNames = [NSMutableArray array];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double then,now;
    then = CFAbsoluteTimeGetCurrent();  // 获取绝对时间
    for (int i = 0; i<1024; i++) {
        dispatch_group_async(dispatchGroup, self.syncronizationQueue, ^{
            [self getImageName:imageNames];
        });
        
        dispatch_group_async(dispatchGroup, self.syncronizationQueue, ^{
            [self createImageName:imageNames];
        });
    }
    
    //
    dispatch_group_notify(dispatchGroup, self.syncronizationQueue, ^{
        now = CFAbsoluteTimeGetCurrent();
        NSLog(@"%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNames.count);
    });
}

/*
   [lock lockWhenCondition:0]; 0 的方法的优先级别 比 1 要高
   [lock lockWhenCondition:1]; 1
   在 dispatch_group_notify 中调用的方法先调用 0 的方法 后面是1 的方法
   改变
 */


@end





















































































































