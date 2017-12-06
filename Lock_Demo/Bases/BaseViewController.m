//
//  BaseViewController.m
//  Lock_Demo
//
//  Created by meitianhui2 on 2017/12/2.
//  Copyright © 2017年 DeLongYang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)initWithControl:(BaseControl *)control
{
    self = [super init];
    if (self) {
        _control = control;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 400, 220, 25);
    [button setTitle:@"getImageName" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getImageNameWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    self.control.title = self.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getImageNameWithMultiThread
{
    [self.control getIamgeNameWithMutiThread];
}


@end
