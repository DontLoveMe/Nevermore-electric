//
//  ForgetPasswordController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "ForgetPasswordController.h"


@interface ForgetPasswordController ()

@end

@implementation ForgetPasswordController
#pragma mark - 导航栏左右栏按钮及点击事件
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
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self initNavBar];
    
    [self initViews];
    
}

#pragma mark - initViews
- (void)initViews{
    
    _userTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的手机号码"
                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _verifyTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _passwordTF1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"新密码（至少6位）"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _passwordTF2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入新密码（至少6位）"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];

}
// 获取验证码按钮
- (IBAction)verificationClickAction:(UIButton *)sender {
}
//保存
- (IBAction)preserveAction:(UIButton *)sender {
}

#pragma mark 点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITextField *textField in [self.view subviews]) {
        if ([textField isKindOfClass: [UITextField class]]) {
            [textField  resignFirstResponder];
        }
    }
}


@end
