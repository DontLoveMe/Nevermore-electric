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
#import "ListViewController.h"
@interface DetailViewController ()

//背景图
@property(nonatomic,strong)UIImageView *backView;

@property(nonatomic,strong)UILabel *nextName;

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

    self.title =  @"配电箱";
    
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
        

        if (!json[@"flag"]) {
            return ;
        }
        
        NSDictionary *rootDic = [json objectForKey:@"data"];
        
        
        NSDictionary *dic = [rootDic objectForKey:@"boxs"];
        
    
        if ([[[dic objectForKey:@"isError"]stringValue] isEqualToString:@"0"]) {
            
            _detectorLabel.text = @"探测器: 正常";
            
        }else{
        
            _detectorLabel.textColor = [UIColor redColor];
            
            _detectorLabel.text = @"探测器: 异常";
        }
        
        if ([[[dic objectForKey:@"isOnline"]stringValue] isEqualToString:@"0"]) {
            
            _dispatchLabel.textColor = [UIColor redColor];
            _dispatchLabel.text = @"通讯:离线";
            
        }else{

            _dispatchLabel.text = @"通讯:正常";
        
        }
        
        _addressLabel.text=[NSString stringWithFormat:@"%@%@",_name,[dic objectForKey:@"boxName"]];
        
        
        if (![dic[@"monitors"] isEqual:[NSNull null]]) {
            NSDictionary *monitors = dic[@"monitors"];
            NSArray *temperatures = monitors[@"temperature"];
            if (temperatures.count>0) {
                NSMutableArray *tems = [NSMutableArray array];
                for (int i=0; i<temperatures.count; i++) {
                    NSDictionary *tDic = temperatures[i];
                    NSString *tString = [NSString stringWithFormat:@"%@℃",tDic[@"curValue"]];
                    [tems addObject:tString];
                }
                _tempytureLabel.text = [NSString stringWithFormat:@"温度：%@",[tems componentsJoinedByString:@"  "]];
            }
            
            NSArray *currents = monitors[@"current"];
            if (currents.count>0) {
                NSMutableArray *curs = [NSMutableArray array];
                for (int i=0; i<currents.count; i++) {
                    NSDictionary *cDic = currents[i];
                    NSString *tString = [NSString stringWithFormat:@"%@mA",cDic[@"curValue"]];
                    [curs addObject:tString];
                }
                _currentLabel.text = [NSString stringWithFormat:@"剩余电流：%@",[curs componentsJoinedByString:@"  "]];
            }
            
        }
        
            
        
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    

 
}

-(void)creatUI
{

    //背景
    _backView = [[UIImageView alloc]init];
    
    _backView.image = [UIImage imageNamed:@"配电箱背景"];
    
    [self.view addSubview:_backView];
    
    _backView.sd_layout
    .leftSpaceToView(self.view,10)
    .topSpaceToView(self.view,57)
    .rightSpaceToView(self.view,10)
    .heightIs(300);
    
    
    //给背景添加手势
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    tgr.numberOfTapsRequired = 1;
    
    tgr.numberOfTouchesRequired = 1;
    
    [_backView addGestureRecognizer:tgr];
    
    _backView.userInteractionEnabled = YES;
    
    //地址
    _addressLabel = [[UILabel alloc]init];
    
    _addressLabel.font = [UIFont boldSystemFontOfSize:14];
    
    _addressLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_addressLabel];
    
    _addressLabel.sd_layout
    .leftSpaceToView(self.view,40)
    .topSpaceToView(self.view,80)
    .widthIs(200)
    .heightIs(20);
    
    //户主
    _nameLabel = [[UILabel alloc]init];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    _nameLabel.text = userDic[@"name"];
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.view,KScreenWidth-100)
    .topSpaceToView(self.view,80)
    .widthIs(200)
    .heightIs(20);
    
    
     //探测器
    _detectorView = [[UIImageView alloc]init];
    
    _detectorView.image = [UIImage imageNamed:@"探测器"];
    
    [self.view addSubview:_detectorView];
   
    _detectorView.sd_layout
    .leftSpaceToView(self.view,40)
    .topSpaceToView(_addressLabel,25)
    .widthIs(20)
    .heightIs(25);
    
    _detectorLabel = [[UILabel alloc]init];
    
    _detectorLabel.font = [UIFont boldSystemFontOfSize:14];
    
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
    .leftSpaceToView(self.view,40)
    .topSpaceToView(_detectorView,30)
    .widthIs(20)
    .heightIs(25);
    
    _dispatchLabel = [[UILabel alloc]init];
    
    _dispatchLabel.font = [UIFont boldSystemFontOfSize:14];
    
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
    .leftSpaceToView(self.view,40)
    .topSpaceToView(_dispatchView,30)
    .widthIs(20)
    .heightIs(25);
    
    _tempytureLabel = [[UILabel alloc]init];
    
    _tempytureLabel.text = @"温度：未知";
    _tempytureLabel.font = [UIFont boldSystemFontOfSize:14];
    _tempytureLabel.numberOfLines = 2;
    _tempytureLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_tempytureLabel];
    
    _tempytureLabel.sd_layout
    .leftSpaceToView(_temptureView,32)
    .topSpaceToView(_dispatchLabel,24)
    .rightSpaceToView(self.view,20)
    .heightIs(36);
    
    _currentView = [[UIImageView alloc]init];
    
    _currentView.image = [UIImage imageNamed:@"剩余电量"];
    
    [self.view addSubview:_currentView];
    
    _currentView.sd_layout
    .leftSpaceToView(self.view,40)
    .topSpaceToView(_temptureView,30)
    .widthIs(20)
    .heightIs(25);
    
    _currentLabel = [[UILabel alloc]init];
    
    _currentLabel.text = @"剩余电流：未知";
    _currentLabel.font = [UIFont boldSystemFontOfSize:14];
    _currentLabel.numberOfLines = 2;
    _currentLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_currentLabel];
    _currentLabel.sd_layout
    .leftSpaceToView(_currentView,32)
    .topSpaceToView(_tempytureLabel,24)
    .rightSpaceToView(self.view,20)
    .heightIs(36);
    
    
    //报警按钮
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_btn setBackgroundImage:[UIImage imageNamed:@"报警按钮"] forState:UIControlStateNormal];
    
    [_btn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btn setTitle:@"历史报警" forState:UIControlStateNormal];
    
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_btn];
    
    _btn.sd_layout
    .rightSpaceToView(self.view,30)
    .topSpaceToView(_nameLabel,40)
    .widthIs(84)
    .heightIs(40);
    
    
}

#pragma mark --手势相关
-(void)tap:(UITapGestureRecognizer *)tgr
{

  
    ListViewController *VC = [[ListViewController alloc]init];
    
    VC.name = _textTitle;
    
    VC.listBoxID = [_boxID stringValue];
        
    [self.navigationController pushViewController:VC animated:YES];

}

-(void)Clicked:(UIButton *)btn
{

    HistoryAlarmController *VC = [[HistoryAlarmController alloc]init];
    
    VC.boxIDD=[_boxID stringValue];
    
    
    [self.navigationController pushViewController:VC animated:YES];

}



@end
