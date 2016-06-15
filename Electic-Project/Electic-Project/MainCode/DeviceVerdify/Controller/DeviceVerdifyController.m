//
//  DeviceVerdifyController.m
//  Electic-Project
//
//  Created by coco船长 on 16/6/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "DeviceVerdifyController.h"

@interface DeviceVerdifyController ()

@end

@implementation DeviceVerdifyController
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
    
    self.title = @"设备验证";
    _selectArr = [NSMutableArray array];
    _params = [NSMutableDictionary dictionary];
    
    [self initNavBar];
    
    [self initViews];

}

- (void)initViews{

    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _singleTap.delegate = self;
    [self.view addGestureRecognizer:_singleTap];
    
    //设备
    _deviceImg = [[UIImageView alloc] initWithFrame:CGRectMake(16.f, 36.f, 16.f, 20.f)];
    _deviceImg.image = [UIImage imageNamed:@"绑定-设备"];
    [self.view addSubview:_deviceImg];
    
    _deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_deviceImg.right + 4, 36.f, KScreenWidth - 52.f, 20.f)];
    _deviceLabel.textColor = [UIColor whiteColor];
    _deviceLabel.text = @"设备:";
    _deviceLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_deviceLabel];
    
    _deviceIDTF = [[UITextField alloc] initWithFrame:CGRectMake(84.f, _deviceImg.bottom + 6.f, KScreenWidth - 96.f, 36.f)];
    _deviceIDTF.backgroundColor = [UIColor clearColor];
    _deviceIDTF.textColor = [UIColor whiteColor];
    _deviceIDTF.font = [UIFont systemFontOfSize:15];
    _deviceIDTF.layer.cornerRadius = 5.f;
    _deviceIDTF.layer.masksToBounds = YES;
    _deviceIDTF.layer.borderWidth = 1.f;
    _deviceIDTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    _deviceIDTF.delegate = self;
    [self.view addSubview:_deviceIDTF];
    
    _deviceIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, _deviceImg.bottom + 14.f, KScreenWidth - 20.f - _deviceIDTF.width - 16.f, 20.f)];
    _deviceIDLabel.text = @"序列号:";
    _deviceIDLabel.textColor = [UIColor whiteColor];
    _deviceIDLabel.font = [UIFont systemFontOfSize:15];
    _deviceIDLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_deviceIDLabel];
    
    _devicePhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(84.f, _deviceIDTF.bottom + 4.f, KScreenWidth - 96.f, 36.f)];
    _devicePhoneTF.userInteractionEnabled = NO;
    _devicePhoneTF.backgroundColor = [UIColor clearColor];
    _devicePhoneTF.textColor = [UIColor whiteColor];
    _devicePhoneTF.font = [UIFont systemFontOfSize:15];
    _devicePhoneTF.layer.cornerRadius = 5.f;
    _devicePhoneTF.layer.masksToBounds = YES;
    _devicePhoneTF.layer.borderWidth = 1.f;
    _devicePhoneTF.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:_devicePhoneTF];
    
    _devicePhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, _deviceIDTF.bottom + 14.f, KScreenWidth - 20.f - _deviceIDTF.width - 16.f, 20.f)];
    _devicePhoneLabel.text = @"号码:";
    _devicePhoneLabel.textColor = [UIColor whiteColor];
    _devicePhoneLabel.font = [UIFont systemFontOfSize:15];
    _devicePhoneLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_devicePhoneLabel];
    
    float buttonWidth = KScreenWidth / 5;
    _resetButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth + 10.f, _devicePhoneTF.bottom + 36.f, buttonWidth, 30.f)];
    [_resetButton setBackgroundImage:[UIImage imageNamed:@"验证-按钮"]
                            forState:UIControlStateNormal];
    [_resetButton setTitle:@"复位"
                  forState:UIControlStateNormal];
    [_resetButton addTarget:self
                     action:@selector(resetAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetButton];
    
    _dampButton = [[UIButton alloc] initWithFrame:CGRectMake(_resetButton.right + buttonWidth - 20.f, _devicePhoneTF.bottom + 36.f, buttonWidth, 30.f)];
    [_dampButton setBackgroundImage:[UIImage imageNamed:@"验证-按钮"]
                            forState:UIControlStateNormal];
    [_dampButton setTitle:@"消声"
                  forState:UIControlStateNormal];
    [_dampButton addTarget:self
                     action:@selector(dampAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dampButton];

    
}

#pragma mark - 按钮事件
- (void)resetAction:(UIButton *)button{
    
    NSLog(@"复位了");
    
}

- (void)dampAction:(UIButton *)button{

    NSLog(@"消声了");

}

#pragma mark - UITextfieldDelegate
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
               forKey:@"seqNum"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxSearchURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               NSLog(@"查询出来的数据：%@",[json objectForKey:@"data"]);
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               if (isSuccess) {
                   
                   _selectArr = [json objectForKey:@"data"];
                   _selectTable.frame = CGRectMake(tf.left, tf.bottom - 8.f, tf.width, _selectArr.count * 24);
                   [self.view addSubview:_selectTable];
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
    
    if (![[dic objectForKey:@"seqNum"] isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = [dic objectForKey:@"seqNum"];
    }else{
        cell.textLabel.text = @"暂无数据";
    }

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 28.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = [_selectArr objectAtIndex:indexPath.row];
    
    _deviceIDTF.text = [dic objectForKey:@"seqNum"];
    _devicePhoneTF.text = [dic objectForKey:@"phone"];
    [_params setObject:[dic objectForKey:@"boxId"] forKey:@"boxId"];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         CGRect rect = _selectTable.frame;
                         rect.size.height = 0;
                         _selectTable.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         
                         [_selectTable removeFromSuperview];
                         
                     }];
    
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
