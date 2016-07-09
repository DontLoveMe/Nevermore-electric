//
//  ListViewController.m
//  Electic-Project
//
//  Created by 杨浩斌 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ListViewController.h"
#import "TestTool.h"
#import "MyTwoTableViewCell.h"
#import "MyTwoModel.h"
@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    MyTwoModel *_model;
    
    UITableView *_tab;
    
    UITableView *_Tab;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_dataArr;
    
    BOOL _isCurrent;
}

@end

@implementation ListViewController
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
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25.f, 25.f)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"右按钮"]
                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(rightClick:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    
}

-(void)rightClick:(UIButton *)button
{

    TrendController *TVC = [[TrendController alloc] init];
    TVC.boxID = [_listBoxID integerValue];
    TVC.isCurrent = _isCurrent;
    [self.navigationController pushViewController:TVC
                                         animated:YES];

}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    _dataArray = [NSMutableArray array];
    
    _dataArr = [NSMutableArray array];
    
    [self initNavBar];
    
    self.title = @"配电箱详情";
    
    //创建分段选择器
     [self  createSegmented];
    
    //创建视图
    [self creatTab];
    
    //创建温度数据
    [self creatTemptureData];
}


-(void)createSegmented
{
    NSArray *arr = @[@"温度",@"电流"];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:arr];
    
   // [seg setBackgroundImage:[UIImage imageNamed:@"选择器背景图"] forState:UIControlStateNormal barMetrics:UIBarMetricsCom];
    
    seg.frame = CGRectMake(40, 20, KScreenWidth-80, 30);
    
    seg.selectedSegmentIndex=0;
    
    seg.tintColor = [UIColor whiteColor];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    
    [seg setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    [seg addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
}

-(void)creatTab
{

    
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KScreenWidth, KScreenHeight-125) style:UITableViewStylePlain];
    
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
      _tab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页_背景"]];
    _tab.dataSource = self;
    
    _tab.hidden=YES;
    
    
    _tab.delegate = self;
    
    
    [self.view addSubview:_tab];
    
    _Tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KScreenWidth, KScreenHeight-125) style:UITableViewStylePlain];
    
     _Tab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页_背景"]];
    
    _Tab.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    _Tab.dataSource = self;

    _Tab.delegate = self;
    
    [self.view addSubview:_Tab];
    
    
  
}

-(void)creatTemptureData
{


   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];
    
    
    [params setObject:@{@"boxId":_listBoxID,
                        @"staffId":[userDic objectForKey:@"staffId"]
                        } forKey:@"paramsMap"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,WarnningHistoryListURL];
    
    [TestTool post:url params:params success:^(id json) {
        
        NSArray *rootArray = [json objectForKey:@"data"];
        
        for (NSDictionary *dic in rootArray) {
           
            if ([[dic objectForKey:@"wranType"]integerValue]==1) {
                
               
                _model = [[MyTwoModel alloc]init];
                
                [_model setValuesForKeysWithDictionary:dic];
                
                [_dataArr addObject:_model];
                
                
            }else if ([[dic objectForKey:@"wranType"]integerValue]==2)
            {
             
                _model = [[MyTwoModel alloc]init];
                
                [_model setValuesForKeysWithDictionary:dic];
                
                [_dataArray addObject:_model];
                
             }
            
            
        }
    
       
        [_Tab reloadData];
        
        [_tab reloadData];
        
    } failure:^(NSError *error) {
        
    }];

  

}

-(void)valueChanged:(UISegmentedControl *)seg
{
    
    
    if(seg.selectedSegmentIndex==0)
    {
        
        _Tab.hidden=NO;
        
        _tab.hidden=YES;
        
        _isCurrent = NO;
    }else
    {
        
        _tab.hidden=NO;
        _Tab.hidden=YES;
        
        _isCurrent = YES;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([tableView isEqual:_tab]) {
        
        return _dataArray.count;
        
        
    }else if([tableView isEqual:_Tab])
    {
    
        return _dataArr.count;
    }else
    {
        return 0;
    }
  
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
  
    if ([tableView isEqual:_tab])
    {
    
        MyTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[MyTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.lineOne.image = [UIImage imageNamed:@"线"];
            
            cell.lineTwo.image = [UIImage imageNamed:@"线"];
            
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页_背景"]];
            
            
        }
        
        MyTwoModel *model = _dataArray[indexPath.row];
                
        [cell configCellWithModelTwo:model];
        
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;

    
    }else if ([tableView isEqual:_Tab])
    {
    
    
        MyTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        if (!cell) {
            
            cell = [[MyTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
            
            cell.lineOne.image = [UIImage imageNamed:@"线"];
            
            cell.lineTwo.image = [UIImage imageNamed:@"线"];
            
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页_背景"]];
        }
        
        MyTwoModel *model = _dataArr[indexPath.row];
        
        [cell configCellWithModelTwo:model];
        
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
        

      
    
    }else
    {
    
    
        return nil;
    }

    
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 50;
    
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
