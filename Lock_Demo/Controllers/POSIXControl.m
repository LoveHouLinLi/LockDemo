

//
//  POSIXControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "POSIXControl.h"
#import <pthread.h>

@interface POSIXControl()
{
    pthread_mutex_t mutex;  //
}
@end

@implementation POSIXControl
- (void)dealloc
{
    // 销毁 需要手动 销毁 不然有内存泄漏
    pthread_mutex_destroy(&mutex);
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        pthread_mutex_init(&mutex, NULL);
    }
    return self;
}

- (void)getImageName
{
    while (true) {
        NSString *imageName;
        // 加锁
        pthread_mutex_lock(&mutex);
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        }else{
            //
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            // 解锁
            pthread_mutex_unlock(&mutex);
            return;
        }
        
        //  解锁   
        pthread_mutex_unlock(&mutex);
    }
    
    
}


@end

















































































