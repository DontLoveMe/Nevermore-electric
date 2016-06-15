//
//  HistoryAlarmController.m
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HistoryAlarmController.h"
#import "Common.h"
#import "TestTool.h"
#import "MyOneTableViewCell.h"
#import "MyTwoModel.h"
@interface HistoryAlarmController ()<UITableViewDataSource,UITableViewDelegate>
{


    NSMutableArray *_dataArray;
    
    UITableView *_TableView;
    
    MyTwoModel *_model;

}

@end

@implementation HistoryAlarmController


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
    
    _dataArray = [NSMutableArray array];
    
    self.title = @"历史报警";
    
    [self initNavBar];
    
    
    [self creatData];
    
    
    [self creatTableView];
}

#pragma mark---数据源相关
-(void)creatData
{

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];

    
    [params setObject:@{@"boxId":_boxIDD,
                        @"staffId":[userDic objectForKey:@"staffId"]
                        } forKey:@"paramsMap"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,WarnningHistoryListURL];
    
    
    [TestTool post:url params:params success:^(id json) {
        
        NSLog(@"%@",json);
//        
//        NSArray *rootArray = [json objectForKey:@"data"];
//        
//        for (NSDictionary *dic in rootArray) {
//            
//            
//            _model = [[MyTwoModel alloc]init];
//            
//            [_model setValuesForKeysWithDictionary:dic];
//            
//            [_dataArray addObject:_model];
//            
//            
//            
//        }
//        
        [_TableView reloadData];

        
    } failure:^(NSError *error) {
        
    }];

   


}

-(void)creatTableView
{


    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    
    _TableView.dataSource = self;
    
    _TableView.delegate = self;
    
    [self.view addSubview:_TableView];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[MyOneTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.iconView.image = [UIImage imageNamed:@"警告图像"];
    }
    
    
    MyTwoModel *model = _dataArray[indexPath.row];
    
    [cell configCellWithModel:model];
    
    return cell;
   

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
