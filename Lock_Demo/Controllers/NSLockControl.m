//
//  NSLockControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/2.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "NSLockControl.h"

@interface NSLock()


@end

@implementation NSLockControl
{
    NSLock *lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        lock = [[NSLock alloc] init];
    }
    return self;
}

//  重写的方法
- (void)getImageName
{
    while (true) {
        NSString *imageName;
        [lock lock];
//        NSLog(@"imageNames count: %ld",imageNameArray.count);
        if (imageNameArray.count > 0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        }else{
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            return;
        }
        [lock unlock];
        
    }
}












@end
