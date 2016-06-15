//
//  BindController.m
//  ElectricProject
//
//  Created by coco船长 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BindController.h"

@interface BindController ()

@end

@implementation BindController
#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 25.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定操作";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{
    
    //背景滑动视图
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_bgScrollView];
    

}

@end
