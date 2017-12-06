//
//  ViewController.m
//  Lock_Demo
//
//  Created by 杨德龙 on 2017/12/1.
//  Copyright © 2017年 DeLongYang. All rights reserved.
/*
    1.0 我们当然可以修改 更多的初始化的 数据测试时间
 */

#import "ViewController.h"
#import "BaseViewController.h"
#import "EntirelyController.h"    // 所有的 control 按一下整体测试一遍

static NSString *identifier = @"identifier";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Lock Experiment";
    self.dataSource = @[@"Base",@"OneThread",@"MainThread",@"atomic",@"NSLock",@"synchronized",@"DispatchSemaphore",@"NSCondition",@"NSConditionLock",@"NSRecursiveLock",@"POSIX",@"OSSpinLock",@"dispatch_barrier_async",@"dispatch_barrier_sync",@"Entirely"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ---- UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark ---- UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger count = self.dataSource.count;
    NSInteger row = indexPath.row;
    if (row<count) {
        NSString *name = self.dataSource[row];
        NSString *className = [NSString stringWithFormat:@"%@Control",name];
        
        id class = NSClassFromString(className);
        if ([class class]) {
        
            BaseControl *control = [[class alloc] init];
            BaseViewController *baseVC = [[BaseViewController alloc] initWithControl:control];
            baseVC.title = className;
            [self.navigationController pushViewController:baseVC animated:YES];

        }
        
        if (row == count-1)
        {
            // 对比所有 的Lock
            EntirelyController *entirelyVC = [[EntirelyController alloc] init];
            entirelyVC.title = @"所有Lock 对比测试";
            [self.navigationController pushViewController:entirelyVC animated:YES];
        }
    }
}



@end











































