//
//  BaseControl.h
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/2.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseControl : NSObject
{
    @public
    NSMutableArray *imageNameArray;
    __block double then,now;
}

@property (nonatomic,strong)NSString *title;
@property (nonatomic,readonly)dispatch_queue_t syncronizationQueue;

#pragma mark ----  多线程取出图片后删除
- (void)getImageName;
- (void)getIamgeNameWithMutiThread;






@end
