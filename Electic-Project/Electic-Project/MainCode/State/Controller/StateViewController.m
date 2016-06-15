//
//  StateViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "StateViewController.h"
#import "UIView+SDAutoLayout.h"
#import "MyOneCollectionViewCell.h"
#import "MyOneHeaderView.h"
#import "TestTool.h"
#import "Common.h"
#import "MyOneModel.h"
#import "DetailViewController.h"
static NSString *headerViewIdentifier = @"hederview";

@interface StateViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{

    UISearchBar *_searchBar;
    
    UILabel *_nameLabel;

    UICollectionView *_collectionView;
    
    NSMutableArray *_dataArray1;
    
    NSMutableArray *_dataArray2;
    
    MyOneModel *_model;
 

}

@end

@implementation StateViewController

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
    
    _dataArray1 = [NSMutableArray array];
    
    _dataArray2 = [NSMutableArray array];

    
    self.title = @"配电箱";
    
    [self initNavBar];
    
    //创建搜索
    [self creatSearch];
    
    //创建数据源
    [self creatData];
    
    
    //创建列表视图
    [self collectionView];
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

#pragma mark--数据源相关

-(void)creatData
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[userDic objectForKey:@"staffId"] forKey:@"staffId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxStatusListURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               
               NSArray *rootArray = [json objectForKey:@"data"];
               
               
               for (NSDictionary *rootDic in rootArray) {
                   
                   _model = [[MyOneModel alloc]init];
                   
                 [_model setValuesForKeysWithDictionary:rootDic];
                   
                 [_dataArray2 addObject:_model];
                   
                   NSArray *array = [rootDic objectForKey:@"boxs"];
                   
                   
                   for (NSDictionary *dic in array) {
                       
                       
                       
                       [_model setValuesForKeysWithDictionary:dic];
                       
                       [_dataArray1 addObject:_model];
                       
                   }
               }
               
              
              
               
    
               
               [_collectionView reloadData];

            
           } failure:^(NSError *error) {
           }];




}

#pragma mark---视图相关
-(void)collectionView
{

    //名字

    _nameLabel = [[UILabel alloc]init];
    
    [self.view addSubview:_nameLabel];

    _nameLabel.sd_layout
    .leftSpaceToView(self.view,KScreenWidth/2-30)
    .topSpaceToView(self.view,90)
    .widthIs(60)
    .heightIs(40);
    
    _nameLabel.text = @"黎小美";
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    
    
    //列表视图
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 5;
    
    flowLayout.headerReferenceSize = CGSizeMake(KScreenWidth, 20);
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 130, KScreenWidth, KScreenHeight-200) collectionViewLayout:flowLayout];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    //注册Item
    [_collectionView registerClass:[MyOneCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   
    //注册头视图
    [_collectionView registerClass:[MyOneHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
    
    [self.view addSubview:_collectionView];
    
    
}

#pragma mark--UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return _dataArray2.count;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _dataArray1.count;

}

//告知每个块应该有多大
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((KScreenWidth-40)/3.0, 140);

}

//设置偏移
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(10, 10, 10, 10);


}

//返回一个可以复用的视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    MyOneHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
    
    MyOneModel *model = _dataArray2[indexPath.section];
    
    [headerView configCellWithModel:model];
    
    return headerView;
 
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyOneModel *model = _dataArray1[indexPath.row];
    
    

    DetailViewController *VC = [[DetailViewController alloc]init];
    
    
    VC.boxID = model.id;
    
    VC.name = model.boxName;
    
    NSLog(@"%@",VC.boxID);
    
    [self.navigationController pushViewController:VC animated:YES];
    

}


#pragma mark---UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MyOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    MyOneModel *model = _dataArray1[indexPath.row];
    
    [cell configCellWithModel:model];
    
    
    return cell;

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
