//
//  IdeaViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "IdeaViewController.h"

@interface IdeaViewController ()

@end

@implementation IdeaViewController

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
    
    self.title = @"意见反馈";
    
    [self initNavBar];
    
    _contactTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请留下您的联系方式（选填：QQ，电话，邮箱）"
                                                                      attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    
    _contactTF.delegate = self;
}
#pragma mark - 按钮的点击事件
- (IBAction)feedbackAction:(UIButton *)sender {
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_textView.text forKey:@"opinion"];
    [params setObject:_contactTF.text forKey:@"contact"];
    
    
    [self showHUD:@"正在提交"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,AdviceURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               [self hideSuccessHUD:[json objectForKey:@"msg"]];
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               if (isSuccess) {
                   
               }
               
           } failure:^(NSError *error) {
               
               [self hideFailHUD:@"提交失败"];
               NSLog(@"error:%@",error);
               
           }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([_contactTF isFirstResponder]) {
        
        [_contactTF resignFirstResponder];
       
    }
    
    if ([_textView isFirstResponder]) {
        
        [_textView resignFirstResponder];
    }

    
}

@end
