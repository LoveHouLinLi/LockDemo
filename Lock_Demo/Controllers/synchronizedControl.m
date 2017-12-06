//
//  synchronizedControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "synchronizedControl.h"

@implementation synchronizedControl

- (void)getIamgeNameWithMutiThread
{
    while (true) {
        NSString *imageName;
        @synchronized(self){
            
            // 通过打印 count 对比在
            NSLog(@"imageNames count: %ld",imageNameArray.count);
            if (imageNameArray.count>0) {
                imageName = [imageNameArray firstObject];
                [imageNameArray removeObjectAtIndex:0];
            } else {
                now = CFAbsoluteTimeGetCurrent();
                printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
                return;
            }
        }
    }
}

@end
