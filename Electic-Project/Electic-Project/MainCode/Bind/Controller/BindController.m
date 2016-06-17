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
    _selectID = @"";
    _selectArr = [NSMutableArray array];
    _params = [NSMutableDictionary dictionary];
    [_params setObject:@"1"
                forKey:@"isExists"];
    
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
    _addressLabel.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:_addressLabel];
    
    _addressTF = [[UITextField alloc] initWithFrame:CGRectMake(84.f, _addressLabel.bottom + 6.f, KScreenWidth - 96.f, 36.f)];
    _addressTF.tag = 100;
    _addressTF.backgroundColor = [UIColor clearColor];
    _addressTF.textColor = [UIColor whiteColor];
    _addressTF.font = [UIFont systemFontOfSize:15];
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
    _deviceIDTF.tag = 101;
    _deviceIDTF.backgroundColor = [UIColor clearColor];
    _deviceIDTF.textColor = [UIColor whiteColor];
    _deviceIDTF.font = [UIFont systemFontOfSize:15];
    _deviceIDTF.layer.cornerRadius = 5.f;
    _deviceIDTF.layer.masksToBounds = YES;
    _deviceIDTF.layer.borderWidth = 1.f;
    _deviceIDTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _deviceIDTF.delegate = self;
    [_bgScrollView addSubview:_deviceIDTF];
    
    _deviceIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, _deviceImg.bottom + 14.f, KScreenWidth - 20.f - _deviceIDTF.width - 16.f, 20.f)];
    _deviceIDLabel.text = @"序列号:";
    _deviceIDLabel.textColor = [UIColor whiteColor];
    _deviceIDLabel.font = [UIFont systemFontOfSize:15];
    _deviceIDLabel.textAlignment = NSTextAlignmentRight;
    [_bgScrollView addSubview:_deviceIDLabel];
    
    _devicePhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(_addressTF.left, _deviceIDTF.bottom + 4.f, _addressTF.width, 36.f)];
    _devicePhoneTF.userInteractionEnabled = NO;
    _devicePhoneTF.backgroundColor = [UIColor clearColor];
    _devicePhoneTF.textColor = [UIColor whiteColor];
    _devicePhoneTF.font = [UIFont systemFontOfSize:15];
    _devicePhoneTF.layer.cornerRadius = 5.f;
    _devicePhoneTF.layer.masksToBounds = YES;
    _devicePhoneTF.layer.borderWidth = 1.f;
    _devicePhoneTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_bgScrollView addSubview:_devicePhoneTF];
    
    _devicePhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, _deviceIDTF.bottom + 14.f, KScreenWidth - 20.f - _deviceIDTF.width - 16.f, 20.f)];
    _devicePhoneLabel.text = @"号码:";
    _devicePhoneLabel.textColor = [UIColor whiteColor];
    _devicePhoneLabel.font = [UIFont systemFontOfSize:15];
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
    _complanyTF.font = [UIFont systemFontOfSize:15];
    _complanyTF.layer.cornerRadius = 5.f;
    _complanyTF.layer.masksToBounds = YES;
    _complanyTF.layer.borderWidth = 1.f;
    _complanyTF.layer.borderColor = [[UIColor whiteColor] CGColor];
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
    
    _acountView = [[UIView alloc] initWithFrame:CGRectMake(84.f, _acountImg.bottom + 6.f, KScreenWidth - 96.f, 72.f)];
    _acountView.backgroundColor = [UIColor clearColor];
    _acountView.layer.cornerRadius = 5.f;
    _acountView.layer.masksToBounds = YES;
    _acountView.layer.borderWidth = 1.f;
    _acountView.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_bgScrollView addSubview:_acountView];
    
    _acountSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(_acountView.left + 8.f, _acountView.top + 12.f, 16.f, 16.f)];
    _acountSelectButton.tag = 200;
    _acountSelectButton.selected = YES;
    [_acountSelectButton setBackgroundImage:[UIImage imageNamed:@"绑定-未选"]
                                   forState:UIControlStateNormal];
    [_acountSelectButton setBackgroundImage:[UIImage imageNamed:@"绑定-已选"]
                                   forState:UIControlStateSelected];
    [_acountSelectButton addTarget:self
                            action:@selector(selectAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_acountSelectButton];
    
    _acountUnselectButton = [[UIButton alloc] initWithFrame:CGRectMake(_acountView.left + 8.f, _acountView.top + 44.f, 16.f, 16.f)];
    _acountUnselectButton.tag = 201;
    [_acountUnselectButton setBackgroundImage:[UIImage imageNamed:@"绑定-未选"]
                                   forState:UIControlStateNormal];
    [_acountUnselectButton setBackgroundImage:[UIImage imageNamed:@"绑定-已选"]
                                   forState:UIControlStateSelected];
    [_acountUnselectButton addTarget:self
                            action:@selector(selectAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_acountUnselectButton];
    
    
    _acountexistLabel = [[UILabel alloc] initWithFrame:CGRectMake(_acountSelectButton.right + 4, _acountView.top + 8.f, 64.f, 24.f)];
    _acountexistLabel.textColor = [UIColor whiteColor];
    _acountexistLabel.text = @"已有账号:";
    _acountexistLabel.font = [UIFont systemFontOfSize:14];
    [_bgScrollView addSubview:_acountexistLabel];
    
    _acountAddlabel = [[UILabel alloc] initWithFrame:CGRectMake(_acountSelectButton.right + 4, _acountView.top + 40.f, 64.f, 24.f)];
    _acountAddlabel.textColor = [UIColor whiteColor];
    _acountAddlabel.text = @"新增:";
    _acountAddlabel.font = [UIFont systemFontOfSize:14];
    [_bgScrollView addSubview:_acountAddlabel];
    
    _acountexistTF = [[UITextField alloc] initWithFrame:CGRectMake(_acountView.left + 88.f, _acountView.top + 8.f, _acountView.width - 100.f, 24.f)];
    _acountexistTF.tag = 102;
    _acountexistTF.userInteractionEnabled = YES;
    _acountexistTF.backgroundColor = [UIColor clearColor];
    _acountexistTF.textColor = [UIColor whiteColor];
    _acountexistTF.font = [UIFont systemFontOfSize:14];
    _acountexistTF.layer.cornerRadius = 5.f;
    _acountexistTF.layer.masksToBounds = YES;
    _acountexistTF.layer.borderWidth = 1.f;
    _acountexistTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _acountexistTF.delegate = self;
    [_bgScrollView addSubview:_acountexistTF];
    
    _acountAddTF = [[UITextField alloc] initWithFrame:CGRectMake(_acountView.left + 88.f, _acountView.top + 40.f, _acountView.width - 100.f, 24.f)];
    _acountAddTF.userInteractionEnabled = NO;
    _acountAddTF.backgroundColor = [UIColor clearColor];
    _acountAddTF.textColor = [UIColor whiteColor];
    _acountAddTF.font = [UIFont systemFontOfSize:14];
    _acountAddTF.layer.cornerRadius = 5.f;
    _acountAddTF.layer.masksToBounds = YES;
    _acountAddTF.layer.borderWidth = 1.f;
    _acountAddTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_bgScrollView addSubview:_acountAddTF];
    
    //提交按钮
    _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(36.f, _acountView.bottom + 36.f, KScreenWidth - 72.f, 40.f)];
    [_commitButton setTitle:@"保存"
                   forState:UIControlStateNormal];
    [_commitButton setBackgroundImage:[UIImage imageNamed:@"绑定-保存按钮"]
                             forState:UIControlStateNormal];
    [_commitButton addTarget:self
                      action:@selector(commitAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_commitButton];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _commitButton.bottom + 36.f);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    
    CGRect rect1 = _bgScrollView.frame;
    rect1.size.height = KScreenHeight - kNavigationBarHeight - 216 - 50;
    _bgScrollView.frame = rect1;
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    
    CGRect rect1 = _bgScrollView.frame;
    rect1.size.height = KScreenHeight - kNavigationBarHeight;
    _bgScrollView.frame = rect1;
    
}

#pragma mark - 账户类型选择事件
- (void)selectAction:(UIButton *)button{

    if (button.tag == 200) {
        
        _acountSelectButton.selected = YES;
        _acountUnselectButton.selected = NO;
        
        _acountAddTF.text = @"";
//        if ([_acountAddTF isFirstResponder]) {
//            [_acountAddTF resignFirstResponder];
//        }
        _acountAddTF.userInteractionEnabled = NO;
//        _acountAddTF.delegate = nil;
        _acountexistTF.userInteractionEnabled = YES;
        [_params setObject:@"1"
                    forKey:@"isExists"];
        
    }else if (button.tag == 201){
    
        _acountSelectButton.selected = NO;
        _acountUnselectButton.selected = YES;
        
        _acountexistTF.text = @"";
//        if ([_acountexistTF isFirstResponder]) {
//            [_acountexistTF resignFirstResponder];
//        }
//        _acountexistTF.delegate = nil;
        _acountexistTF.userInteractionEnabled = NO;
        _acountAddTF.userInteractionEnabled = YES;
        [_params setObject:@"0"
                    forKey:@"isExists"];
        
    }
    
}

- (void)commitAction:(UIButton *)button{

    Boolean isExist = [[_params objectForKey:@"isExists"] boolValue];
    if (isExist) {
        
        if ([[_params objectForKey:@"staffId"] isKindOfClass:[NSNull class]]||_acountexistTF.text.length == 0) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                     message:@"请输入/选择账户！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [alertController dismissViewControllerAnimated:YES
                                                                                                         completion:nil];
                                                                 }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
            return;
            
        }
        
    }else{
    
        if (_acountAddTF.text.length != 0) {
            
            [_params setObject:_acountAddTF.text forKey:@"loginName"];
            
        }else{
        
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                     message:@"请选择账户！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [alertController dismissViewControllerAnimated:YES
                                                                                                         completion:nil];
                                                                 }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
            return;
        
        }
        
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxBindURL];
    [self showHUD:@"正在绑定"];
    [TestTool post:url
            params:_params
           success:^(id json) {
               
               [self hideSuccessHUD:[json objectForKey:@"msg"]];
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               if (isSuccess) {
                   [self.navigationController popViewControllerAnimated:YES];
               }
               
           } failure:^(NSError *error) {
               
               [self hideFailHUD:@"保存失败"];
               
           }];
    
}

#pragma mark - UITextfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag == 101 ) {
        _textFieldType = 101;
        if (_selectID.length != 0) {
            [self requestListWithString:_selectID withTextField:textField withType:_textFieldType];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                     message:@"请先选择地址！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [alertController dismissViewControllerAnimated:YES
                                                                                                         completion:nil];
                                                                 }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
            return NO;
        }
    }
    return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 100) {
        _textFieldType = 100;
        [self requestListWithString:string withTextField:textField withType:_textFieldType];
    }else if (textField.tag == 102) {
        _textFieldType = 102;
         [self requestListWithString:string withTextField:textField withType:_textFieldType];
    }
//    else if (textField.tag == 101) {
//        _textFieldType = 101;
//        [self requestListWithString:textField.text withTextField:textField withType:_textFieldType];
//    }
    return YES;

}

#pragma mark - 模糊查询
- (void)requestListWithString:(NSString *)keyWord withTextField:(UITextField *)tf withType:(NSInteger) type{

    if (!_selectTable) {
        _selectTable = [[UITableView alloc] init];
    }
    _selectTable.frame = CGRectMake(tf.left, tf.bottom - 8.f, tf.width, 0);
    _selectTable.backgroundColor = [UIColor colorFromHexRGB:@"0F0F0F"];
    _selectTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _selectTable.dataSource = self;
    _selectTable.delegate = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSString *url ;
    if (type == 100) {
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxListURL];
        [params setObject:keyWord
                   forKey:@"name"];
    }else if (type == 101){
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxSearchURL];
        [params setObject:keyWord
                   forKey:@"seqNum"];
    }else if (type == 102){
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,SearchUserURL];
        [params setObject:keyWord
                   forKey:@"searchParam"];
    }
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               NSLog(@"查询出来的数据：%@",[json objectForKey:@"data"]);
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
    
    if (_textFieldType == 100) {
   
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",[dic objectForKey:@"companyAddress"],[dic objectForKey:@"name"]];

    }else if (_textFieldType == 101) {
        if (![[dic objectForKey:@"seqNum"] isKindOfClass:[NSNull class]]) {
            cell.textLabel.text = [dic objectForKey:@"seqNum"];
        }else{
            cell.textLabel.text = @"暂无数据";
        }
    }else if (_textFieldType == 102) {
   
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"name"],[dic objectForKey:@"phone"]];

    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 28.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = [_selectArr objectAtIndex:indexPath.row];
    
    if (_textFieldType == 100) {
        
        _addressTF.text = [NSString stringWithFormat:@"%@  %@",[dic objectForKey:@"companyAddress"],[dic objectForKey:@"name"]];
        _selectID = [NSString stringWithFormat:@"%ld",[[dic objectForKey:@"id"] integerValue]];
        [_params setObject:[dic objectForKey:@"orgId"] forKey:@"orgId"];
        
    }else if (_textFieldType == 101) {
        
        _deviceIDTF.text = [dic objectForKey:@"seqNum"];
        _devicePhoneTF.text = [dic objectForKey:@"phone"];
        _complanyTF.text = [dic objectForKey:@"companyName"];
        [_params setObject:[dic objectForKey:@"boxId"] forKey:@"boxId"];
        
    }else if (_textFieldType == 102) {

        _acountexistTF.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"name"],[dic objectForKey:@"phone"]];
        [_params setObject:[dic objectForKey:@"staffId"]
                    forKey:@"staffId"];
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         CGRect rect = _selectTable.frame;
                         rect.size.height = 0;
                         _selectTable.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         
                         [_selectTable removeFromSuperview];
                         
                     }];

}

#pragma mark - 点击隐藏选择列表
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
