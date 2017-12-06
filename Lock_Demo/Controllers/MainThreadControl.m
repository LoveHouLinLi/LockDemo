//
//  MainThreadControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "MainThreadControl.h"

@implementation MainThreadControl

- (void)getIamgeNameWithMutiThread
{
    //
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"currentThread is %@",currentThread);
    
    while (true) {
        NSString *imageName;
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        }else{
            now = CFAbsoluteTimeGetCurrent();  // 获取线程 执行的时间
            NSLog(@"%30s_lock: %f sec ---- imageNames count:%ld",[self.title UTF8String],now-then,imageNameArray.count);
            return;   // 返回退出循环
        }
    }
    //    很明显在 主线程还是单线程中 时间都是  534044933.887550 sec 
    //    MainThreadControl_lock: 534044933.887550 sec ---- imageNames count:0
}

@end
