//
//  AlarmViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "AlarmViewController.h"

@interface AlarmViewController ()

@end

@implementation AlarmViewController

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
    
    self.title = @"报警";
    self.view.backgroundColor = [UIColor blackColor];
    
    _warmArr = [NSMutableArray array];
    
    [self initNavBar];

    [self initViews];
    
}

- (void)initViews{

    _searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(4.f, 8.f, KScreenWidth - 8.f, 40.f)];
    _searchView.barStyle = UIBarStyleBlack;
    _searchView.placeholder = @"搜索";
    [self.view addSubview:_searchView];
    
    _warmTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom + 8.f, KScreenWidth, KScreenHeight - kNavigationBarHeight - 20.f - _searchView.bottom)];
    _warmTable.backgroundColor = [UIColor clearColor];
    _warmTable.delegate = self;
    _warmTable.dataSource = self;
    [_warmTable registerNib:[UINib nibWithNibName:@"WarmCell"
                                           bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Warm_Cell"];
    [self.view addSubview:_warmTable];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self requestData];

}

- (void)requestData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];
    NSString *stuffID = [userDic objectForKey:@"staffId"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"20" forKey:@"rows"];
    [params setObject:@{@"staffId":stuffID}
               forKey:@"paramsMap"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,WarnningListURL];
    [TestTool post:url
            params:params
           success:^(id json) {
               
               NSInteger resultFlag = [[json objectForKey:@"flag"] boolValue];
               if (resultFlag) {
                   
                   [self hideSuccessHUD:@"加载成功"];
                   _warmArr = [json objectForKey:@"data"];
                   [_warmTable reloadData];
                   
               }else{
                   
                   [self hideFailHUD:@"加载失败，请重新加载"];
                   
               }
               
           } failure:^(NSError *error) {
               
               [self hideFailHUD:@"加载失败，请重新加载"];
               
           }];
    

}

#pragma mark -  UITableViewDelegate,UITableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _warmArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Warm_Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [_warmArr objectAtIndex:indexPath.row];
    if (![[dic objectForKey:@"boxName"] isKindOfClass:[NSNull class]]) {
        cell.nameLabel.text = [dic objectForKey:@"staffName"];
    }else{
        cell.nameLabel.text = @"无数据";
    }
    
    if (![[dic objectForKey:@"phone"] isKindOfClass:[NSNull class]]) {
        cell.phoneLabel.text = [dic objectForKey:@"phone"];
    }else{
        cell.phoneLabel.text = @"无数据";
    }
    
    cell.eventLabel.text = [NSString stringWithFormat:@"%@%@接收到警报",[dic objectForKey:@"orgName"],[dic objectForKey:@"boxName"]];
    
    NSInteger status = [[dic objectForKey:@"status"] integerValue];
    if (status == 0) {
        cell.stateLabel.text = @"未完成";
        cell.stateLabel.textColor = [UIColor redColor];
    }else{
        cell.stateLabel.text = @"已解决";
        cell.stateLabel.textColor = [UIColor whiteColor];
    }

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 72.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = [_warmArr objectAtIndex:indexPath.row];
    NSInteger status = [[dic objectForKey:@"status"] integerValue];
    NSInteger boxID = [[dic objectForKey:@"id"] integerValue];
    if (status == 1) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                 message:@"该警报已经处理。" preferredStyle:UIAlertControllerStyleAlert];
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
    
    }else{
        
        AlarmDetailController *ADVC = [[AlarmDetailController alloc] init];
        ADVC.boxID = boxID;
        ADVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ADVC
                                             animated:YES];
    
    }
    

    
}

@end