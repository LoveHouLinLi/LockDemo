//
//  EntirelyController.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/6.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "EntirelyController.h"

@interface EntirelyController ()

@end

@implementation EntirelyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    [self compareEntirely];
}


- (void)compareEntirely
{
    // 在整个过程中 不加锁的 就不要放进来 因为可能 会造成 crash
     NSArray *dataArray = @[@"NSLock",@"synchronized",@"DispatchSemaphore",@"NSCondition",@"NSConditionLock",@"NSRecursiveLock",@"POSIX",@"OSSpinLock",@"dispatch_barrier_async",@"dispatch_barrier_sync"];
    
    // 遍历所有的 元素 每过5秒进行一项测试，防止CPU占用冲突
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5*idx * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            id class = NSClassFromString([NSString stringWithFormat:@"%@Control",obj]);
            if ([class class]) {
                BaseControl *control = [[class alloc] init];
                control.title = obj;
                // 测试对比
                [control getIamgeNameWithMutiThread];
                self.title = obj;
            }
            if (idx == dataArray.count-1) {
                printf("\n\n\n");
            }
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
