//
//  BaseControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/2.
//  Copyright © 2017年 DeLongYang. All rights reserved.
/*
 
 */

#import "BaseControl.h"

static NSString *queueString = @"com.delong.baseControl";

@implementation BaseControl
{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 同步的 queue
        _syncronizationQueue = dispatch_queue_create([queueString cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
        imageNameArray = [NSMutableArray array];
        int count = 1024;
        for (int i = 0; i<count; i++) {
            [imageNameArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        //
        NSLog(@"数组初始化话完成-----imageNames count: %ld\n",imageNameArray.count);
        
    }
    return self;
}


/**
 获取图片的名字
 */
- (void)getImageName
{
   
    while (true) {
        NSString *imageName;
        // 通过打印 count 发现 在一开始的时候三个 1024 出现 
//        NSLog(@"imageNames count: %ld",imageNameArray.count);
        // 注意 ！！！！ baseControl 的多线程访问会造成 crash  多线程的访问并不会一定会造成 crash 但是概率是挺高的 
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        }else{
            // 很明显
            now = CFAbsoluteTimeGetCurrent();  // 获取线程 执行的时间
            NSLog(@"%30s_lock: %f sec ---- imageNames count:%ld",[self.title UTF8String],now-then,imageNameArray.count);
            return;   // 返回退出循环
        }
    }
}


/**
 多线程 获取图片
 */
- (void)getIamgeNameWithMutiThread
{
    // 获取 线程 开始的时间
    NSLog(@"开始 多线程操作 一次开启三个 线程访问,删除数组中的元素");
//  NSLog(@"没有 线程保护 这样访问会造成 问题 ？？");
    then = CFAbsoluteTimeGetCurrent();
    for (int i =0; i<3; i++) {
        // 创建一个 单线程访问的
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getImageName];
        });
    }
}



























@end
