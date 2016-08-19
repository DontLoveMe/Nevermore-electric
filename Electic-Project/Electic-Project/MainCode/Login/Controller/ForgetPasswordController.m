//
//  ForgetPasswordController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "ForgetPasswordController.h"
#import "WoReaderLoadingView.h"

@interface ForgetPasswordController ()

@end

@implementation ForgetPasswordController
#pragma mark - 导航栏左右栏按钮及点击事件
- (void)initNavBar {
    
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

- (void)NavAction:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    [self initNavBar];
    [self initViews];
}

#pragma mark - initViews
- (void)initViews {
    
    _userTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的手机号码"
                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _verifyTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _passwordTF1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"新密码（至少6位）"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _passwordTF2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入新密码"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
}

// 获取验证码按钮
- (IBAction)verificationClickAction:(UIButton *)sender {
    sender.enabled = NO;
    //获取验证码
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"loginName"] forKey:@"loginName"];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"phone"] forKey:@"phone"];
    
    [self showHUD:@"正在获取..."];
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, VerificationCodeURL];
    [TestTool post:url params:params success:^(id json) {
        NSLog(@"%@", json);
        [self hideSuccessHUD:[json objectForKey:@"msg"]];
        BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
        if (isSuccess) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"验证码已发送至您的手机，请注意查收！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }
    } failure:^(NSError *error) {
        
        [self hideFailHUD:@"获取验证码失败，请稍后重试！"];
        sender.enabled = YES;
        NSLog(@"error:%@", error);
    }];
}

//保存
- (IBAction)preserveAction:(UIButton *)sender {
    if (!_userTF.text || [_userTF.text isEqualToString:@""]) {
//        [self showHUD:@"请输入您的手机号码！"];
        [self showTitle:@"请输入您的手机号码！"];
//        [[WoReaderLoadingView sharedInstance] showNoticeWithTitle:@"请输入您的手机号码！" yOffset:@"0"];
        [_userTF becomeFirstResponder];
        return;
    }
    if (!_verifyTF.text || [_verifyTF.text isEqualToString:@""]) {
        [self showHUD:@"请输入验证码！"];
        [_verifyTF becomeFirstResponder];
        return;
    }
    if (!_passwordTF1.text || [_passwordTF1.text isEqualToString:@""]) {
        [self showHUD:@"请输入新密码！"];
        [_passwordTF1 becomeFirstResponder];
        return;
    }
    if (!_passwordTF2.text || [_passwordTF2.text isEqualToString:@""]) {
        [self showHUD:@"请再次输入新密码！"];
        [_passwordTF2 becomeFirstResponder];
        return;
    }
    if (![_passwordTF2.text isEqualToString:_passwordTF1.text]) {
        [self showHUD:@"两次新密码输入不一致，请重新输入！"];
        _passwordTF1.text = @"";
        _passwordTF2.text = @"";
        [_passwordTF1 becomeFirstResponder];
        return;
    }
    //修改密码
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"loginName"] forKey:@"loginName"];
    [params setObject:_userTF.text forKey:@"phone"];
    [params setObject:_verifyTF.text forKey:@"captcha"];
    [params setObject:_passwordTF1.text forKey:@"password"];
    
    [self showHUD:@"正在保存..."];
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, ModifyPasswordURL];
    [TestTool post:url params:params success:^(id json) {
        NSLog(@"%@", json);
        [self hideSuccessHUD:[json objectForKey:@"msg"]];
        BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
        if (isSuccess) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"密码修改成功，请使用新密码重新登录！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }
    } failure:^(NSError *error) {
        
        [self hideFailHUD:@"密码修改失败，请稍后重试！"];
        sender.enabled = YES;
        NSLog(@"error:%@", error);
    }];
}

#pragma mark 点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITextField *textField in [self.view subviews]) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }
}

@end
