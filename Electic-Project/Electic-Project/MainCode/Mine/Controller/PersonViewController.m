//
//  PersonViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonView.h"
#import "UIImageView+AFNetWorking.h"


@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *alterButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@end

@implementation PersonViewController

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
    
    self.title = @"个人资料";
    
    [self initNavBar];
    
    
    _iconImgView.layer.cornerRadius = _iconImgView.width/2;
    _iconImgView.layer.masksToBounds = YES;
    //设置头像
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSURL *headPhotoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/epFile%@",BASE_URL,userDic[@"headPhoto"]]];
    [_iconImgView setImageWithURL:headPhotoURL placeholderImage:[UIImage imageNamed:@"我的_头像.png"]];
    
    [self initSubviews];
}

- (void)initSubviews {
    //取登录储存的数据
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSString *name = userDic[@"name"];
    NSString *phone = userDic[@"phone"];
    NSString *gender = nil;
    if ([userDic[@"gender"] integerValue]==1) {
        
        gender = @"男";
    }else if ([userDic[@"gender"] integerValue]==2) {
        
        gender = @"女";
    }
    NSString *homeAddress = userDic[@"homeAddress"];

    //定义数据
    NSDictionary *dic1 = @{@"image":@"个人资料_姓名",@"title":@"姓名",@"content":name};
    NSDictionary *dic2 = @{@"image":@"个人资料_电话",@"title":@"电话",@"content":phone};
    NSDictionary *dic3 = @{@"image":@"个人资料_性别",@"title":@"性别",@"content":gender};
    NSDictionary *dic4 = @{@"image":@"个人资料_住址",@"title":@"住址",@"content":homeAddress};

    
    NSArray *dicArr = @[dic1,dic2,dic3,dic4];
    
    for (int i = 0; i < dicArr.count; i ++) {
        PersonView *pView = [[PersonView alloc] initWithFrame:CGRectMake(0, 130+70*i, KScreenWidth, 60)];
        pView.tag = 100 + i;
        pView.textFiel.userInteractionEnabled = NO;
        NSDictionary *dic = dicArr[i];
        [pView setImageName:dic[@"image"] labelText:dic[@"title"] textFielText:dic[@"content"]];
        [self.view addSubview:pView];
        
        pView.textFiel.delegate = self;
    }
    float height = 60 * dicArr.count;
    //退出登录的按钮
    UIButton *preserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    preserveButton.tag = 200;
    preserveButton.hidden = YES;
    preserveButton.frame = CGRectMake((KScreenWidth-280)/2, height+50+120, 280, 50);
    [preserveButton setTitle:@"保存" forState:UIControlStateNormal];
    [preserveButton setBackgroundImage:[UIImage imageNamed:@"按钮点击前"] forState:UIControlStateNormal];
    [preserveButton addTarget:self action:@selector(preserveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preserveButton];

    
}
#pragma mark - 按钮的点击
//编辑
- (IBAction)alterAction:(UIButton *)sender {
    sender.hidden = YES;
    
    UIButton *preserveButton = [self.view viewWithTag:200];
    preserveButton.hidden = NO;
    
    for (int i = 0; i < 4; i ++) {
         PersonView *pView = [self.view viewWithTag:100+i];
        pView.textFiel.userInteractionEnabled = YES;
    }
}

//保存
- (void)preserveAction:(UIButton *)button {
    
    button.hidden = YES;
    self.alterButton.hidden = NO;
    
    NSMutableArray *userArr = [NSMutableArray array];

    for (int i = 0; i < 4; i ++) {
        PersonView *pView = [self.view viewWithTag:100+i];
        pView.textFiel.userInteractionEnabled = NO;
//        NSLogSFQ(@"%@",pView.textFiel.text);
        [userArr addObject:pView.textFiel.text];
    }
    //取登录储存的数据
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userDic[@"staffId"] forKey:@"id"];
    [params setObject:userArr[0] forKey:@"name"];
    [params setObject:userArr[1] forKey:@"phone"];
    
    NSNumber *gender = @0;
    if ([userArr[2] isEqualToString:@"男"]) {
        
        gender = @1;
    }else if ([userArr[2] isEqualToString:@"女"]) {
        
        gender = @2;
    }
    [params setObject:gender forKey:@"gender"];
    [params setObject:userArr[3] forKey:@"homeAddress"];
    
    [self showHUD:@"正在修改"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ModifyUserMsgURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               [self hideSuccessHUD:[json objectForKey:@"msg"]];
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               if (isSuccess) {
                   
                   NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
                   NSMutableDictionary *userDic = dic.mutableCopy;
                   userDic[@"name"] = params[@"name"];
                   userDic[@"phone"] = params[@"phone"];
                   userDic[@"gender"] = params[@"gender"];
                   userDic[@"homeAddress"] = params[@"homeAddress"];
                   
                   [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"userDic"];
                   
                   
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
    
    for (int i = 0; i < 4; i ++) {
        PersonView *pView = [self.view viewWithTag:100+i];
        if ([pView.textFiel isFirstResponder]) {
            [pView.textFiel resignFirstResponder];
        }
        
    }
    
}
@end
