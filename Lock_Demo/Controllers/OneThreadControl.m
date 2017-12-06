//
//  OneThreadControl.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/4.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "OneThreadControl.h"

@implementation OneThreadControl

// 重写的 只提交一个 thread
 - (void)getIamgeNameWithMutiThread
{
    [self getImageName];
}


@end
