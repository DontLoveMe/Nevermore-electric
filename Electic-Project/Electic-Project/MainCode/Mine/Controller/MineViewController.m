//
//  MineViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "SetViewController.h"
#import "PersonViewController.h"
#import "IdeaViewController.h"
#import "EditionViewController.h"
#import "MinePhotoView.h"
#import "UIImageView+AFNetworking.h"

@interface MineViewController ()

@end

@implementation MineViewController {
    
    NSString *_identify;
    NSArray *_data;
    MinePhotoView *_photoView;
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
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 20.f)];
    rightButton.tag = 102;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"我的_设置.png"]
                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)NavAction:(UIButton *)button{
    if (button.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (button.tag == 102) {
        
        SetViewController *SVC = [[SetViewController alloc] init];
        [self.navigationController pushViewController:SVC animated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [self initNavBar];
    
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //定义数据
    NSDictionary *dic1 = @{@"image":@"我的_个人资料",@"name":@"个人资料"};
    NSDictionary *dic2 = @{@"image":@"我的_联系我们",@"name":@"联系我们"};
    NSDictionary *dic3 = @{@"image":@"我的_意见反馈",@"name":@"意见反馈"};
    NSDictionary *dic4 = @{@"image":@"我的_版本信息",@"name":@"版本信息"};
    
    _data = @[dic1,dic2,dic3,dic4];
    
    
    //设置头像和名字
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSURL *headPhotoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL,userDic[@"headPhoto"]]];
    [_iconImgView setImageWithURL:headPhotoURL placeholderImage:[UIImage imageNamed:@"我的_头像.png"]];
    _nameLabel.text = userDic[@"name"];

    
    
}
- (void)initSubviews {
    _iconImgView.layer.cornerRadius = _iconImgView.width/2;
    _iconImgView.layer.masksToBounds = YES;
    
//    _iconImgView.layer.borderColor = [[UIColor redColor] CGColor];
//    _iconImgView.layer.borderWidth = 1.f;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    //设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //注册单元格
    _identify = @"MineCell";
    [_tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:_identify];

    
    _photoView = [[[NSBundle mainBundle] loadNibNamed:@"MinePhotoView" owner:nil options:nil] lastObject];
    _photoView.hidden = YES;
    _photoView.frame = CGRectMake(0, -64, KScreenWidth, KScreenHeight);
    _photoView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

    __weak typeof(UIImageView *)weakIcon = _iconImgView;
    [_photoView setPhotoBlock:^(NSString *filePath) {
        NSURL *headPhotoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL,filePath]];
        [weakIcon setImageWithURL:headPhotoURL placeholderImage:[UIImage imageNamed:@"我的_头像.png"]];
        
    }];
    [self.view addSubview:_photoView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.iconImgView.userInteractionEnabled = YES;
    [self.iconImgView addGestureRecognizer:tap];
    
}

- (void)tapAction {
    _photoView.hidden = NO;
    
   
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
        case 0://个人资料
        {
            PersonViewController *PVC = [[PersonViewController alloc] init];
            [self.navigationController pushViewController:PVC animated:YES];
            
        }
            
            break;
        case 1://联系我们
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"联系我们"
                                                                                     message:@"0755-27588064" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [alertController dismissViewControllerAnimated:YES
                                                                                                          completion:nil];
                                                                  }];
            UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"拨打"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      UIWebView *webView = [[UIWebView alloc] init];
                                                                      
                                                                      NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"0755-27588064"]];
                                                                      [webView loadRequest:[NSURLRequest requestWithURL:url]];
                                                                      [self.view addSubview:webView];
                                                                  }];
            [alertController addAction:cancelAction1];
            [alertController addAction:cancelAction2];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];



            
        }
            break;
        case 2://意见反馈
        {
            IdeaViewController *IVC = [[IdeaViewController alloc] init];
            [self.navigationController pushViewController:IVC animated:YES];
            
        }
            break;
        case 3://版本信息
        {
            EditionViewController *EVC = [[EditionViewController alloc] init];
            [self.navigationController pushViewController:EVC animated:YES];
            
        }
            break;
            
        default:
            
            break;
            
    }
    
}

@end
