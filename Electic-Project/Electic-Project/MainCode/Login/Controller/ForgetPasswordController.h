//
//  ForgetPasswordController.h
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//
#import "BaseViewController.h"
#import "LoginTextField.h"

@interface ForgetPasswordController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF1;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF2;


@end
