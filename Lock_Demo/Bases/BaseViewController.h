//
//  BaseViewController.h
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/2.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseControl.h"

@interface BaseViewController : UIViewController


/**
 需要初始化 方法 设置
 */
@property (nonatomic,strong,readonly)BaseControl *control;

/**
 使用 control 来初始化 baseVC

 @param control control description
 @return return value description
 */
- (instancetype)initWithControl:(BaseControl *)control;


@end
