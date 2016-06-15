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
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"121213"];
    _selectArr = [NSMutableArray array];
    
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{
    
    //背景滑动视图
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor colorFromHexRGB:@"121213"];
    [self.view addSubview:_bgScrollView];
    
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _singleTap.delegate = self;
    [_bgScrollView addGestureRecognizer:_singleTap];
    
    //地址
    _addressImg = [[UIImageView alloc] initWithFrame:CGRectMake(16.f, 16.f, 16.f, 20.f)];
    _addressImg.image = [UIImage imageNamed:@"绑定-地址"];
    [_bgScrollView addSubview:_addressImg];
    
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_addressImg.right + 4, 16.f, KScreenWidth - 52.f, 20.f)];
    _addressLabel.textColor = [UIColor whiteColor];
    _addressLabel.text = @"地址:";
    _addressLabel.font = [UIFont systemFontOfSize:14];
    [_bgScrollView addSubview:_addressLabel];
    
    _addressTF = [[UITextField alloc] initWithFrame:CGRectMake(84.f, _addressLabel.bottom + 6.f, KScreenWidth - 96.f, 36.f)];
    _addressTF.backgroundColor = [UIColor clearColor];
    _addressTF.textColor = [UIColor whiteColor];
    _addressTF.font = [UIFont systemFontOfSize:14];
    _addressTF.layer.cornerRadius = 5.f;
    _addressTF.layer.masksToBounds = YES;
    _addressTF.layer.borderWidth = 1.f;
    _addressTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _addressTF.delegate = self;
    [_bgScrollView addSubview:_addressTF];
    
    //设备
    _deviceImg = [[UIImageView alloc] initWithFrame:CGRectMake(16.f, _addressTF.bottom + 12.f, 16.f, 20.f)];
    _deviceImg.image = [UIImage imageNamed:@"绑定-设备"];
    [_bgScrollView addSubview:_deviceImg];
    
    _deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_deviceImg.right + 4, _addressTF.bottom + 12.f, KScreenWidth - 52.f, 20.f)];
    _deviceLabel.textColor = [UIColor whiteColor];
    _deviceLabel.text = @"设备:";
    _deviceLabel.font = [UIFont systemFontOfSize:16];
    [_bgScrollView addSubview:_deviceLabel];
    
    _deviceIDTF = [[UITextField alloc] initWithFrame:CGRectMake(_addressTF.left, _deviceImg.bottom + 6.f, _addressTF.width, 36.f)];
    _deviceIDTF.backgroundColor = [UIColor clearColor];
    _deviceIDTF.textColor = [UIColor whiteColor];
    _deviceIDTF.font = [UIFont systemFontOfSize:14];
    _deviceIDTF.layer.cornerRadius = 5.f;
    _deviceIDTF.layer.masksToBounds = YES;
    _deviceIDTF.layer.borderWidth = 1.f;
    _deviceIDTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_bgScrollView addSubview:_deviceIDTF];
    
    _deviceIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, _deviceImg.bottom + 14.f, KScreenWidth - 20.f - _deviceIDTF.width - 16.f, 20.f)];
    _deviceIDLabel.text = @"序列号:";
    _deviceIDLabel.textColor = [UIColor whiteColor];
    _deviceIDLabel.font = [UIFont systemFontOfSize:14];
    _deviceIDLabel.textAlignment = NSTextAlignmentRight;
    [_bgScrollView addSubview:_deviceIDLabel];
    
    _devicePhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(_addressTF.left, _deviceIDTF.bottom + 4.f, _addressTF.width, 36.f)];
    _devicePhoneTF.userInteractionEnabled = NO;
    _devicePhoneTF.backgroundColor = [UIColor clearColor];
    _devicePhoneTF.textColor = [UIColor whiteColor];
    _devicePhoneTF.font = [UIFont systemFontOfSize:14];
    _devicePhoneTF.layer.cornerRadius = 5.f;
    _devicePhoneTF.layer.masksToBounds = YES;
    _devicePhoneTF.layer.borderWidth = 1.f;
    _devicePhoneTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_bgScrollView addSubview:_devicePhoneTF];
    
    _devicePhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, _deviceIDTF.bottom + 14.f, KScreenWidth - 20.f - _deviceIDTF.width - 16.f, 20.f)];
    _devicePhoneLabel.text = @"号码:";
    _devicePhoneLabel.textColor = [UIColor whiteColor];
    _devicePhoneLabel.font = [UIFont systemFontOfSize:14];
    _devicePhoneLabel.textAlignment = NSTextAlignmentRight;
    [_bgScrollView addSubview:_devicePhoneLabel];

    //公司名
    _complanyImg = [[UIImageView alloc] initWithFrame:CGRectMake(16.f, _devicePhoneTF.bottom + 12.f, 16.f, 20.f)];
    _complanyImg.image = [UIImage imageNamed:@"绑定-公司名"];
    [_bgScrollView addSubview:_complanyImg];
    
    _complanyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_complanyImg.right + 4, _devicePhoneTF.bottom + 12.f, KScreenWidth - 52.f, 20.f)];
    _complanyLabel.textColor = [UIColor whiteColor];
    _complanyLabel.text = @"公司名字:";
    _complanyLabel.font = [UIFont systemFontOfSize:16];
    [_bgScrollView addSubview:_complanyLabel];
    
    _complanyTF = [[UITextField alloc] initWithFrame:CGRectMake(84.f, _complanyLabel.bottom + 6.f, KScreenWidth - 96.f, 36.f)];
    _complanyTF.userInteractionEnabled = NO;
    _complanyTF.backgroundColor = [UIColor clearColor];
    _complanyTF.textColor = [UIColor whiteColor];
    _complanyTF.font = [UIFont systemFontOfSize:14];
    _complanyTF.layer.cornerRadius = 5.f;
    _complanyTF.layer.masksToBounds = YES;
    _complanyTF.layer.borderWidth = 1.f;
    _complanyTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _complanyTF.delegate = self;
    [_bgScrollView addSubview:_complanyTF];
    
    //账号
    _acountImg = [[UIImageView alloc] initWithFrame:CGRectMake(16.f, _complanyTF.bottom + 12.f, 16.f, 20.f)];
    _acountImg.image = [UIImage imageNamed:@"绑定-账号"];
    [_bgScrollView addSubview:_acountImg];
    
    _acountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_complanyImg.right + 4, _complanyTF.bottom + 12.f, KScreenWidth - 52.f, 20.f)];
    _acountLabel.textColor = [UIColor whiteColor];
    _acountLabel.text = @"账号:";
    _acountLabel.font = [UIFont systemFontOfSize:16];
    [_bgScrollView addSubview:_acountLabel];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self requestListWithString:textField.text withTextField:textField];
    return YES;

}

#pragma mark - 模糊查询
- (void)requestListWithString:(NSString *)keyWord withTextField:(UITextField *)tf{

    if (!_selectTable) {
        _selectTable = [[UITableView alloc] init];
    }
    _selectTable.frame = CGRectMake(tf.left, tf.bottom - 8.f, tf.width, 0);
    _selectTable.backgroundColor = [UIColor colorFromHexRGB:@"0F0F0F"];
    _selectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _selectTable.dataSource = self;
    _selectTable.delegate = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:keyWord
               forKey:@"searchParam"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,SearchUserURL];
    [TestTool post:url
            params:params
           success:^(id json) {
               
//               NSLog(@"查询出来的数据：%@",[json objectForKey:@"data"]);
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               if (isSuccess) {
               
                   _selectArr = [json objectForKey:@"data"];
                   _selectTable.frame = CGRectMake(tf.left, tf.bottom - 8.f, tf.width, _selectArr.count * 24);
                   [_bgScrollView addSubview:_selectTable];
                   [_selectTable reloadData];
                   
               }else{
               
               }
               
           } failure:^(NSError *error) {
               
               
               
           }];

}

#pragma mark -  UITableViewDelegate,UITableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _selectArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    NSDictionary *dic = [_selectArr objectAtIndex:indexPath.row];
    if (![[dic objectForKey:@"homeAddress"] isKindOfClass:[NSNull class]]) {
            cell.textLabel.text = [dic objectForKey:@"homeAddress"];
    }else{
            cell.textLabel.text = @"数据不全";
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 28.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

#pragma mark - 点击位置，获取位置详情
- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap{
    
    if (_selectTable) {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             CGRect rect = _selectTable.frame;
                             rect.size.height = 0;
                             _selectTable.frame = rect;
                             
                         } completion:^(BOOL finished) {
                             
                             [_selectTable removeFromSuperview];
                             
                         }];
        
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (gestureRecognizer == _singleTap && ![touch.view isKindOfClass:[UIScrollView class]]){
        
        return NO;
        
    }
    
    return YES;
}


@end
