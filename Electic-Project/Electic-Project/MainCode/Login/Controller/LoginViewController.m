//
//  LoginViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextField.h"
#import "ForgetPasswordController.h"
#import "HomeViewController.h"
#import "TestTool.h"

@interface LoginViewController ()// <UITextFieldDelegate>

@end

@implementation LoginViewController {
    
    __weak IBOutlet LoginTextField *_userView;
    
    __weak IBOutlet LoginTextField *_verifyView;
    
    __weak IBOutlet LoginTextField *_passwordView;
    __weak IBOutlet NSLayoutConstraint *_verifyHeight;
    __weak IBOutlet UIButton *_rememberButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_userView setImageName:@"登录_手机" textFielText:@"请输入您的手机密码" verifyButtonHidden:NO];
    [_verifyView setImageName:@"登录_验证" textFielText:@"请输入验证码" verifyButtonHidden:YES];
//    _verifyView.textField.delegate = self;
    _verifyView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_verifyView.button addTarget:self action:@selector(getSecurityCode:) forControlEvents:UIControlEventTouchUpInside];
    _verifyView.hidden = YES;
    _verifyHeight.constant = 0;
    [_passwordView setImageName:@"登录_密码" textFielText:@"请输入您的密码（至少6位）" verifyButtonHidden:NO];
    _passwordView.textField.secureTextEntry = YES;

    //判断上次是否记住密码
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if (userDic) {
        _userView.textField.text = userDic[@"loginName"];
        _passwordView.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        _rememberButton.selected = YES;
    }
}

- (void)getSecurityCode:(UIButton *)sender
{
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

- (IBAction)memorizePasswordAction:(UIButton *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
    } else {
        sender.selected = NO;
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    }
}

- (IBAction)forgetPassword:(UIButton *)sender {
 
    ForgetPasswordController *FPVC = [[ForgetPasswordController alloc] init];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:FPVC];
    [self presentViewController:nVC animated:YES completion:nil];
}

- (IBAction)loginAction:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_userView.textField.text forKey:@"loginName"];
    [params setObject:[MD5Security MD5String:_passwordView.textField.text] forKey:@"password"];
    [params setObject:@"4" forKey:@"deviceType"];
//    NSString *channelID = [BPush getChannelId];
//    if (channelID.length == 0) {
//        [params setObject:channelID forKey:@"channelId"];
//    }
    
    [self showHUD:@"正在登录"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,LoginURL];
//    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://192.168.0.252:8887",@"/eps/sys/user/login"];
    [TestTool post:url params:params success:^(id json) {

        NSLog(@"%@", json);
        [self hideSuccessHUD:[json objectForKey:@"msg"]];
        BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
        if (isSuccess) {
            //保存密码
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_passwordView.textField.text forKey:@"password" ];
            
            //保存数据
            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[json objectForKey:@"data"]];
            for (int i = 0; i < userDic.allKeys.count; i ++) {
                
                if ([[userDic objectForKey:userDic.allKeys[i]] isEqual:[NSNull null]]) {
                    [userDic removeObjectForKey:userDic.allKeys[i]];
                    i = 0;
                }
            }
            [defaults setObject:userDic forKey:@"userDic"];
            [defaults synchronize];
            
            NSInteger isActivate = [[userDic objectForKey:@"isActivate"] boolValue];
            
            if (isActivate) {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                
                HomeViewController *HVC = [[HomeViewController alloc] init];
                
                UINavigationController *VHVC = [[UINavigationController alloc] initWithRootViewController:HVC];
                
                window.rootViewController = VHVC;
                
            } else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                         message:@"您没有权限，请绑定手机！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController
                                   animated:YES
                                 completion:nil];
                
                //短信验证，验证码输入框的显示
                _verifyView.hidden = NO;
                _verifyHeight.constant = 45;
            }
        }
    } failure:^(NSError *error) {
        
        [self hideFailHUD:@"登陆失败"];
        NSLog(@"error:%@", error);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    if (textField.text.length > 3) {//
        //用户激活
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"id"] forKey:@"id"];
        
        [params setObject:_verifyView.textField.text forKey:@"captcha"];
//        [params setObject:@"4" forKey:@"deviceType"];
        
        [self showHUD:@"正在激活"];
        NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, ActiveUserURL];
        [TestTool post:url params:params success:^(id json) {
            
            [self hideSuccessHUD:[json objectForKey:@"msg"]];
            BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
            if (isSuccess) {
                //短信验证，验证码输入框的显示
                _verifyView.hidden = NO;
                _verifyHeight.constant = 45;
                [self loginAction:nil];
            }
        } failure:^(NSError *error) {
            
            [self hideFailHUD:@"激活失败"];
            NSLog(@"error:%@", error);
        }];
    }
    return YES;
}

#pragma mark - 键盘收起事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([_userView.textField isFirstResponder]) {
        
        [_userView.textField resignFirstResponder];
    }
    if ([_verifyView.textField isFirstResponder]) {
        
        [_verifyView.textField resignFirstResponder];
    }
    if ([_passwordView.textField isFirstResponder]) {
        
        [_passwordView.textField resignFirstResponder];
    }
}

@end
