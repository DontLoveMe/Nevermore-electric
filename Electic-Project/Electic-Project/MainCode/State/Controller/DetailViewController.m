//
//  DetailViewController.m
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "DetailViewController.h"
#import "TestTool.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "HistoryAlarmController.h"
@interface DetailViewController ()


@property(nonatomic,strong)UILabel *addressLabel;

@property(nonatomic,strong)UILabel *nameLabel;

//探测器
@property(nonatomic,strong)UIImageView *detectorView;

@property(nonatomic,strong)UILabel *detectorLabel;

//通讯

@property(nonatomic,strong)UIImageView *dispatchView;

@property(nonatomic,strong)UILabel *dispatchLabel;


//温度
@property(nonatomic,strong)UIImageView *temptureView;

@property(nonatomic,strong)UILabel *tempytureLabel;

//剩余电流
@property(nonatomic,strong)UIImageView *currentView;

@property(nonatomic,strong)UILabel *currentLabel;

//报警按钮

@property(nonatomic,strong)UIButton *btn;

@end

@implementation DetailViewController

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
    
    [self initNavBar];
    
    self.title = _name;
    
    
    //创建数据源
    [self creatData];
    
    [self creatUI];

   
}

-(void)creatData
{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[userDic objectForKey:@"staffId"] forKey:@"staffId"];
    
    [params setObject:_boxID forKey:@"id"];
    
    
     NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxStatusDetailURL];
    
    
    [TestTool post:url params:params success:^(id json) {
        

        
        
        NSDictionary *rootDic = [json objectForKey:@"data"];
        
        
        NSDictionary *dic = [rootDic objectForKey:@"boxs"];
        
    
        if ([[[dic objectForKey:@"isError"]stringValue] isEqualToString:@"0"]) {
            
            _detectorLabel.text = @"探测器: 正常";
            
            _dispatchLabel.text = @"通讯:正常";
        }
        
        _addressLabel.text=[NSString stringWithFormat:@"%@%@",[rootDic objectForKey:@"orgName"],[dic objectForKey:@"boxName"]];
        
        _tempytureLabel.text = [NSString stringWithFormat:@"温度:%@",[dic objectForKey:@"temperature"]];
        
        _currentLabel.text = [NSString stringWithFormat:@"剩余电流:%@",[dic objectForKey:@"current"]];
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    

 
}

-(void)creatUI
{

 
    //地址
    _addressLabel = [[UILabel alloc]init];
    
    _addressLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _addressLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_addressLabel];
    
    _addressLabel.sd_layout
    .leftSpaceToView(self.view,50)
    .topSpaceToView(self.view,80)
    .widthIs(200)
    .heightIs(20);
    
    //户主
    _nameLabel = [[UILabel alloc]init];
    
    _nameLabel.text = @"黎小美";
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_addressLabel,40)
    .topSpaceToView(self.view,80)
    .widthIs(200)
    .heightIs(20);
    
    
     //探测器
    _detectorView = [[UIImageView alloc]init];
    
    _detectorView.image = [UIImage imageNamed:@"探测器"];
    
    [self.view addSubview:_detectorView];
   
    _detectorView.sd_layout
    .leftSpaceToView(self.view,55)
    .topSpaceToView(_addressLabel,25)
    .widthIs(20)
    .heightIs(25);
    
    _detectorLabel = [[UILabel alloc]init];
    
    _detectorLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _detectorLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_detectorLabel];
    
    _detectorLabel.sd_layout
    .leftSpaceToView(_detectorView,32)
    .topSpaceToView(_addressLabel,30)
    .widthIs(100)
    .heightIs(20);
    
    
    //通讯
    _dispatchView = [[UIImageView alloc]init];
    
    _dispatchView.image = [UIImage imageNamed:@"通讯"];
    
    [self.view addSubview:_dispatchView];
    
    
    _dispatchView.sd_layout
    .leftSpaceToView(self.view,55)
    .topSpaceToView(_detectorView,30)
    .widthIs(20)
    .heightIs(25);
    
    _dispatchLabel = [[UILabel alloc]init];
    
    _dispatchLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _dispatchLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_dispatchLabel];
    
    _dispatchLabel.sd_layout
    .leftSpaceToView(_dispatchView,32)
    .topSpaceToView(_detectorLabel,33)
    .widthIs(100)
    .heightIs(20);
    
    
    //温度
    _temptureView = [[UIImageView alloc]init];
    
    _temptureView.image = [UIImage imageNamed:@"温度"];
    
    [self.view addSubview:_temptureView];
    
    _temptureView.sd_layout
    .leftSpaceToView(self.view,55)
    .topSpaceToView(_dispatchView,30)
    .widthIs(20)
    .heightIs(25);
    
    _tempytureLabel = [[UILabel alloc]init];
    
    _tempytureLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _tempytureLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_tempytureLabel];
    
    _tempytureLabel.sd_layout
    .leftSpaceToView(_temptureView,32)
    .topSpaceToView(_dispatchLabel,35)
    .widthIs(120)
    .heightIs(20);
    
    _currentView = [[UIImageView alloc]init];
    
    _currentView.image = [UIImage imageNamed:@"剩余电量"];
    
    [self.view addSubview:_currentView];
    
    _currentView.sd_layout
    .leftSpaceToView(self.view,55)
    .topSpaceToView(_temptureView,30)
    .widthIs(20)
    .heightIs(25);
    
    _currentLabel = [[UILabel alloc]init];
    
    _currentLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _currentLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_currentLabel];
    _currentLabel.sd_layout
    .leftSpaceToView(_currentView,32)
    .topSpaceToView(_tempytureLabel,35)
    .widthIs(120)
    .heightIs(20);
    
    
    //报警按钮
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_btn setBackgroundImage:[UIImage imageNamed:@"报警按钮"] forState:UIControlStateNormal];
    
    [_btn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btn setTitle:@"历史报警" forState:UIControlStateNormal];
    
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_btn];
    
    _btn.sd_layout
    .rightSpaceToView(self.view,20)
    .topSpaceToView(_nameLabel,40)
    .widthIs(100)
    .heightIs(50);
    
    

}

-(void)Clicked:(UIButton *)btn
{

    HistoryAlarmController *VC = [[HistoryAlarmController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];

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