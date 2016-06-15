//
//  HomeViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"

#import "BindController.h"
#import "MineViewController.h"
#import "StateViewController.h"
#import "AlarmViewController.h"
#import "HistoryViewController.h"
#import "DeviceVerdifyController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    
    UITableView *_tableView;
    NSString *_identify;
    NSArray * _data;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赛飞奇";

    //初始化子视图
    [self initViews];
}
//初始化子视图
- (void)initViews{
    //创建标题视图
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-270)/2, 15, 270, 40.f)];
    titleView.image = [UIImage imageNamed:@"首页_标题"];
    [self.view addSubview:titleView];
    
    //创建表示图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, KScreenWidth, KScreenHeight-80.f-kNavigationBarHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
  
    //注册单元格
    _identify = @"HomeCell";
    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:_identify];
    
    //数据加载
    [self loadData];
}
//数据加载
- (void)loadData {
    
    //定义数据
    NSDictionary *dic0 = @{@"image":@"首页_绑定",@"name":@"绑定操作",@"annotate":@"设备绑定，一键完成!"};
    NSDictionary *dic1 = @{@"image":@"首页_状态",@"name":@"状态",@"annotate":@"一键搜索，定位精准查询。"};
    NSDictionary *dic2 = @{@"image":@"首页_报警",@"name":@"报警",@"annotate":@"随手掌握异常情况！"};
    NSDictionary *dic3 = @{@"image":@"首页_历史",@"name":@"历史",@"annotate":@"数据保存，方便查询。"};
    NSDictionary *dic4 = @{@"image":@"首页_我的",@"name":@"我的",@"annotate":@"个人资料完美改善！"};
    NSDictionary *dic5 = @{@"image":@"首页_设备验证",@"name":@"设备验证",@"annotate":@"设备验证，方便快捷！"};
    
    _data = @[dic0,dic1,dic2,dic3,dic4,dic5];
    [_tableView reloadData];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dic = _data[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 98.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            BindController *BVC = [[BindController alloc] init];
            BVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:BVC animated:YES];
            
        }
            break;
        case 1:
        {
            StateViewController *SVC = [[StateViewController alloc] init];
            [self.navigationController pushViewController:SVC animated:YES];
            
        }
            break;
        case 2:
        {
            AlarmViewController *AVC = [[AlarmViewController alloc] init];
            [self.navigationController pushViewController:AVC animated:YES];
            
        }
            break;
        case 3:
        {
            HistoryViewController *HVC = [[HistoryViewController alloc] init];
            [self.navigationController pushViewController:HVC animated:YES];
            
        }
            break;
        case 4:
        {
            MineViewController *MVC = [[MineViewController alloc] init];
            [self.navigationController pushViewController:MVC animated:YES];
            
        }
            break;
        case 5:
        {
            DeviceVerdifyController *DVC = [[DeviceVerdifyController alloc] init];
            [self.navigationController pushViewController:DVC animated:YES];
            
        }
            break;
        default:
            break;
    }
}

@end
