//
//  HistoryViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()<UISearchBarDelegate,UIScrollViewDelegate>
{

    UISearchBar *_searchBar;
    

    
}

@end

@implementation HistoryViewController

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
    
    self.title = @"历史数据";
    
    [self initNavBar];
    
    
    //创建搜索
    [self creatSearch];
    
    //创建列表视图
    [self creatUI];
    
}

-(void)creatSearch
{

    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(11, 7, KScreenWidth-22, 60)];
    
    _searchBar.placeholder = @"搜索";
    
    _searchBar.delegate = self;
    
    [_searchBar setImage:[UIImage imageNamed:@"搜索图"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
   _searchBar.backgroundImage = [UIImage imageNamed:@"搜索背景图"];
    
    
    
    [self.view addSubview:_searchBar];
    

}

-(void)creatUI
{

    //名字
    UILabel  *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 85, 60, 40)];
    
    nameLabel.text = @"黎小美";
    
    nameLabel.textColor = [UIColor colorWithRed:26/256.0 green:154/256.0 blue:245/256.0 alpha:1];
    
    [self.view addSubview:nameLabel];
    
    //地址
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(19, 130, 20, 25)];
    
    iconView.image = [UIImage imageNamed:@"地址图标"];
    
    [self.view addSubview:iconView];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 130, 200, 25)];
    
    addressLabel.text = @"航天亚卫科技园";
    
    addressLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:addressLabel];
    
    //配电箱按钮
   
    NSArray *titleArray = @[@"1#配电箱",@"2#配电箱",@"3#配电箱",@"4#配电箱",@"5#配电箱",@"6#配电箱",@"7#配电箱",@"8#配电箱",@"9#配电箱"];
    
    CGFloat xSpace = (self.view.frame.size.width-150*3)/4;
    
    
    for(NSInteger i=0 ; i<titleArray.count;i++)
    {
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(xSpace+(i%3)*(xSpace+80), 160+(i/3)*(xSpace+20), 100, 40);
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateSelected];
        
        
        
        [self.view addSubview:btn];
    
    }


    //地址图
    UIImageView *iconView2 = [[UIImageView alloc]initWithFrame:CGRectMake(19, 330, 20, 25)];
    
    iconView2.image = [UIImage imageNamed:@"地址图标"];
    
    [self.view addSubview:iconView2];
    
    UILabel *addressLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(45, 330, 100, 25)];
    
    addressLabel2.text = @"湘邮科技园";
    
    addressLabel2.textColor = [UIColor whiteColor];

    [self.view addSubview:addressLabel2];
    
    for (NSInteger i=0; i<titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(xSpace+(i%3)*(xSpace+80), 360+(i/3)*(xSpace+20), 100, 40);
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"未选中状态"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateSelected];
        
        
        
        [self.view addSubview:btn];
        
    }
    
    
  

}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    NSLog(@"%@",searchText);

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    [self didClickedSearchButton:nil];//点击按钮
}

- (void)didClickedSearchButton:(UIButton *)sender{
    
    [self refreshData];//点击按钮的网络请求
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [_searchBar resignFirstResponder];

}

-(void)refreshData
{

    [_searchBar resignFirstResponder];
 

}





@end
