//
//  SetViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "SetViewController.h"
#import "MineCell.h"
#import "PersonViewController.h"
#import "LoginViewController.h"
#import "ModifyPasswordController.h"

@interface SetViewController ()

@end

@implementation SetViewController {
    
    UITableView *_tableView;
    NSString *_identify;
    NSArray *_data;
}

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
    
    self.title = @"设置";
    
    [self initNavBar];
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //定义数据
    NSDictionary *dic1 = @{@"image":@"",@"name":@"修改密码"};
    NSDictionary *dic2 = @{@"image":@"",@"name":@"个人资料"};
    
    _data = @[dic1,dic2];

    float tableHeight = 70 * _data.count;
    if ( tableHeight > KScreenHeight - kNavigationBarHeight ) {
        
        _tableView.height = KScreenHeight - kNavigationBarHeight ;
        
    }else{
        
        _tableView.height = tableHeight;
        
    }
    //退出登录的按钮
    UIButton *leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leaveButton.tag = 100;
    leaveButton.frame = CGRectMake((KScreenWidth-280)/2, tableHeight+80, 280, 50);
    [leaveButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [leaveButton setBackgroundImage:[UIImage imageNamed:@"按钮点击前"] forState:UIControlStateNormal];
    [leaveButton addTarget:self action:@selector(leaveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveButton];
}

- (void)leaveAction:(UIButton *)button {
    LoginViewController *lVC = [[LoginViewController alloc] init];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = lVC;
}

- (void)initSubviews {
    
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 300) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    //设置代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //注册单元格
    _identify = @"MineCell";
    [_tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:_identify];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dic = _data[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0://修改密码
        {
            ModifyPasswordController *MPVC = [[ModifyPasswordController alloc] init];
            [self.navigationController pushViewController:MPVC animated:YES];
            
        }
            
            break;
        case 1://个人资料
        {
            PersonViewController *PVC = [[PersonViewController alloc] init];
            [self.navigationController pushViewController:PVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}
@end
