//
//  ModifyPasswordController.m
//  ElectricProject
//
//  Created by 刘毅 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ModifyPasswordController.h"

@interface ModifyPasswordController ()

@end

@implementation ModifyPasswordController

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
    
    self.title = @"修改密码";
    
    [self initNavBar];
    
    [self initSubviews];
}

- (void)initSubviews {
    _userTF.delegate = self;
    _userTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入您的手机号码"
                                                                    attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    _oldPasswordTF.delegate = self;
    _oldPasswordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入旧密码（至少6位）"
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    _passwordTF.delegate = self;
    _passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入新密码（至少6位）"
                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
}

#pragma mark - 修改密码按钮
- (IBAction)modifyPasswordAction:(UIButton *)sender {
    
    //取登录储存的数据
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userDic[@"id"] forKey:@"id"];
    [params setObject:[MD5Security MD5String:_oldPasswordTF.text] forKey:@"oldPassword"];
    [params setObject:[MD5Security MD5String:_passwordTF.text] forKey:@"newPassword"];
    
    
    [self showHUD:@"正在修改"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ModifyPasswordURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               [self hideSuccessHUD:[json objectForKey:@"msg"]];
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               //               NSLogSFQ(@"%@",[json objectForKey:@"msg"]);
               if (isSuccess) {
                   
               }
               
           } failure:^(NSError *error) {
               
               [self hideFailHUD:@"修改失败"];
               NSLog(@"error:%@",error);
               
           }];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([_userTF isFirstResponder]) {
        
        [_userTF resignFirstResponder];
        
    }
    
    if ([_oldPasswordTF isFirstResponder]) {
        
        [_oldPasswordTF resignFirstResponder];
    }
    if ([_passwordTF isFirstResponder]) {
        
        [_passwordTF resignFirstResponder];
    }
    
}

@end
