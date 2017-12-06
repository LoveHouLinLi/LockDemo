//
//  NSConditionControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "NSConditionControl.h"

@implementation NSConditionControl
{
    //
    NSCondition *conditionLock;
//    NSMutableArray *imageNames;
}

- (instancetype)init
{
    //
    self = [super init];
    if (self) {
        conditionLock = [[NSCondition alloc] init];
//        imageNames = [NSMutableArray array];  // 初始化 imageNames
    }
    return self;
}

#pragma mark ---- 仅仅测试 NSCondition 的使用  和 下面那个测试一次只能有一个
//  重写的方法
//- (void)getImageName
//{
//    // 笔者认为 conditionLock  和 Lock 和 Condition 的区别
//    while (true) {
//        NSString *imageName;
//        [conditionLock lock];
//        NSLog(@"imageNames count: %ld",imageNameArray.count);
//        if (imageNameArray.count > 0) {
//            imageName = [imageNameArray firstObject];
//            [imageNameArray removeObjectAtIndex:0];
//        }else{
//            now = CFAbsoluteTimeGetCurrent();
//            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
//
//            return;
//        }
//        [conditionLock unlock];
//
//    }
//}

#pragma mark ---- NSCondition  多线程通信测试

/**
 这个方法 没法  新的方法 这是一个必现的 闪退的方法 但是通过 GCD 并没有出现崩溃
 有意思的是！！！  
 
 @param imageNames 操作的图片的名陈
 */
- (void)newGetImageName:(NSMutableArray *)imageNames
{
    // 这并不是一个 while true 循环
    NSString *imageName;
    [conditionLock lock];
    static int m = 0;
    static int n = 0;
    static int p = 0;
    NSLog(@"removeObjectBegin count: %ld\n",imageNameArray.count);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
        m++;
        NSLog(@"执行了%d次删除操作",m);
    }else{
        p++;
        NSLog(@"执行了%d次等待",p);
        [conditionLock wait];  //
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
        
        /**
         *  有时候点击取出图片会崩溃
         */
        n++;
        NSLog(@"执行了%d次继续操作",n);
    }
    
    NSLog(@"removeObject count: %ld\n",imageNames.count);
    [conditionLock unlock];     //解锁
}


- (void)createImageName:(NSMutableArray *)imageNames
{
    [conditionLock lock];
    static int m = 0;
    [imageNames addObject:@"0"];
    m++;
    NSLog(@"添加了%d次",m);
    [conditionLock signal];  // 单个线程 不需要等待
    // 唤醒所有的 多线程 取消等待继续执行
//    [conditionLock broadcast];
    NSLog(@"createImageName count: %ld\n",imageNames.count);
    [conditionLock unlock];
}


/**
 多线程 取出图片后删除   
 */
- (void)getIamgeNameWithMutiThread
{
    [conditionLock broadcast];
    NSMutableArray *imageNames = [NSMutableArray array];
    // 创建一个 GCD Group
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double now ,then;
    then = CFAbsoluteTimeGetCurrent();
    for (int i = 0;i<10;i++){
        dispatch_group_async(dispatchGroup, self.syncronizationQueue, ^{
            [self newGetImageName:imageNames];
        });
        
        dispatch_group_async(dispatchGroup, self.syncronizationQueue, ^{
            [self createImageName:imageNames];
        });
    }
    //
    dispatch_group_notify(dispatchGroup, self.syncronizationQueue, ^{
        now = CFAbsoluteTimeGetCurrent();
        NSLog(@"thread_lock: %f sec\nimageNames count: %ld\n", now-then,imageNames.count);
    });
    
}


@end



















