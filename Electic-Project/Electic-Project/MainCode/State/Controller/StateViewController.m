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
    
    DetailViewController *VC;
    //组
    NSArray *_data;

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

    
    self.title = @"配电箱";
    
    [self initNavBar];
    
    //创建搜索
//    [self creatSearch];
    
    //创建数据源
    [self creatData];
    
    
    //创建列表视图
    [self collectionView];
}


//-(void)creatSearch
//{
//    
//    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 7, KScreenWidth-20, 40)];
//    _searchBar.barStyle = UIBarStyleBlackTranslucent;
//    _searchBar.placeholder = @"搜索";
//    
//    
//    _searchBar.delegate = self;
//    
//    [_searchBar setImage:[UIImage imageNamed:@"搜索图"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

//    [self.view addSubview:_searchBar];
//    
//    
//}

#pragma mark--数据源相关

-(void)creatData
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[userDic objectForKey:@"staffId"] forKey:@"staffId"];
    if (_orgId) {
        [params setObject:_orgId forKey:@"orgId"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxStatusListURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               if (json[@"flag"]) {
                   _data = json[@"data"];
                    [_collectionView reloadData];
               }
               
            
           } failure:^(NSError *error) {
               
           }];

}

#pragma mark---视图相关
-(void)collectionView
{

    //名字
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLabel];

    _nameLabel.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,15)
    .widthIs(KScreenWidth)
    .heightIs(40);
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    _nameLabel.text = userDic[@"name"];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    _nameLabel.backgroundColor = [UIColor clearColor];
    
    //列表视图
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 5;
    
    flowLayout.headerReferenceSize = CGSizeMake(KScreenWidth, 20);
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, KScreenHeight-200) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
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

    return _data.count;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSArray *arr = [_data[section] objectForKey:@"boxs"];
    
    return arr.count;
   
}

//告知每个块应该有多大
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (KScreenWidth < 375) {
        return CGSizeMake((KScreenWidth-15)/2.0, 130);
    }
    return CGSizeMake((KScreenWidth-20)/3.0, 130);

}

//设置偏移
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(10, 5, 10, 5);


}

//返回一个可以复用的视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    MyOneHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
    
    headerView.backgroundColor = [UIColor clearColor];
    headerView.addressLabel.text = _data[indexPath.section][@"orgName"];
    
    return headerView;
 
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _data[indexPath.section][@"boxs"][indexPath.row];
    MyOneModel *model = [MyOneModel modelWithDic:dic];
//
    VC = [[DetailViewController alloc]init];
    VC.boxID = model.boxId;
    VC.name = _data[indexPath.section][@"orgName"];
    
    [self.navigationController pushViewController:VC animated:YES];
    

}


#pragma mark---UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
        MyOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
    
    [cell.backView setImage:[UIImage imageNamed:@"配电箱背景"]];
   
    NSDictionary *dic = _data[indexPath.section][@"boxs"][indexPath.row];
    MyOneModel *model = [MyOneModel modelWithDic:dic];
    
    cell.nameLabel.text = model.boxName;
    
    if ([model.isError boolValue]) {
        cell.stateLabel.textColor = [UIColor redColor];
        cell.stateLabel.text = @"异常";
    }else {
        cell.stateLabel.textColor = [UIColor whiteColor];
        cell.stateLabel.text = @"正常";
    }
    
    NSArray *temperatures = model.monitors[@"temperature"];
    if (temperatures.count>0) {
        NSMutableArray *tems = [NSMutableArray array];
        for (int i=0; i<1; i++) {
            NSDictionary *tDic = temperatures[i];
            NSString *tString = [NSString stringWithFormat:@"%@℃",tDic[@"curValue"]];
            [tems addObject:tString];
        }
        cell.temperatureLabel.text = [NSString stringWithFormat:@"温度：%@",[tems componentsJoinedByString:@","]];
    }
    NSArray *currents = model.monitors[@"current"];
    if (currents.count>0) {
        NSMutableArray *curs = [NSMutableArray array];
        for (int i=0; i<1; i++) {
            NSDictionary *cDic = currents[i];
            NSString *tString = [NSString stringWithFormat:@"%@mA",cDic[@"curValue"]];
            [curs addObject:tString];
        }
        cell.residualcurrentLabel.text = [NSString stringWithFormat:@"剩余电流：%@",[curs componentsJoinedByString:@","]];
    }

    
    return cell;
   

}


#pragma mark - UISearchBarDelegate

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    
//    NSLog(@"%@",searchText);
//    
//}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    
//    [self didClickedSearchButton:nil];//点击按钮
//}
//
//- (void)didClickedSearchButton:(UIButton *)sender{
//    
//    [self refreshData];//点击按钮的网络请求
//    
//}


#pragma mark - UIScrollViewDelegate

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    [_searchBar resignFirstResponder];
//    
//}
//
//-(void)refreshData
//{
//    
//    [_searchBar resignFirstResponder];
//    
//    
//}


@end
