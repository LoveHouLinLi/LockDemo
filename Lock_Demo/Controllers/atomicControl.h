//
//  atomicControl.h
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/2.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "BaseControl.h"

@interface atomicControl : BaseControl

/**
 新建的一个 atomic 的属性
 */
@property (atomic,strong)NSMutableArray *imageNames;

@end
