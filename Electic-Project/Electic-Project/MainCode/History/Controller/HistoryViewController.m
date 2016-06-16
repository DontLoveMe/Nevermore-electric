//
//  HistoryViewController.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"
#import "HistoryHeaderView.h"

@interface HistoryViewController ()<UISearchBarDelegate,UIScrollViewDelegate>
{

    UISearchBar *_searchBar;
    
    UICollectionView *_collectionView;
    
    NSMutableArray *_data;
    
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
    [self creatCollectionView];
    
    //数据加载
    [self loaddata];
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

-(void)creatCollectionView
{

    //名字
    UILabel  *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 70, 100, 40)];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    nameLabel.text = userDic[@"name"];
    
    nameLabel.textColor = [UIColor colorWithRed:26/256.0 green:154/256.0 blue:245/256.0 alpha:1];
    
    [self.view addSubview:nameLabel];

    //创建UICollectionViewFlowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置item内边距大小
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 创建UICollectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, KScreenWidth, KScreenHeight-110-64) collectionViewLayout:flowLayout];
    
    //设置数据源代理、collection代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellWithReuseIdentifier:@"HistoryCell"];
 
    //注册headerView
    [_collectionView registerNib:[UINib nibWithNibName:@"HistoryHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HistoryHeaderView"];
    
    

}
//加载数据
- (void)loaddata {
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    
    //取登录储存的数据
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userDic[@"staffId"] forKey:@"staffId"];
    
    [self showHUD:@"正在加载"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticHistoryListURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               [self hideSuccessHUD:[json objectForKey:@"msg"]];
               BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
               
               if (isSuccess) {
                   _data = [json objectForKey:@"data"];
                   [_collectionView reloadData];
               }
               
           } failure:^(NSError *error) {
               
               [self hideFailHUD:@"加载失败"];
               NSLogSFQ(@"error:%@",error);
               
           }];
    

    
}
#pragma mark - UICollectionViewDataSource
//组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _data.count;
}

//每一组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dic = _data[section];
    NSArray *arr = dic[@"boxs"];
    return arr.count;
}

//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.去重用队列中查找
    HistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //数据处理
    NSDictionary *dic = _data[indexPath.section];
    NSArray *arr = dic[@"boxs"];
    NSDictionary *boxDic = arr[indexPath.row];
    cell.titleLabel.text = boxDic[@"boxName"];
    
    return cell;
}

#pragma mark 处理点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _data[indexPath.section];
    NSArray *arr = dic[@"boxs"];
    NSDictionary *boxDic = arr[indexPath.row];
    NSLog(@"%@",boxDic[@"id"]);
    
    ListViewController *VC = [[ListViewController alloc]init];
    
    VC.name = [NSString stringWithFormat:@"%@",boxDic[@"boxName"]];
    
    VC.listBoxID = [NSString stringWithFormat:@"%@",boxDic[@"id"]];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark 设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 40);
}

#pragma mark 设置header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        // 去重用队列取可用的header
        HistoryHeaderView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HistoryHeaderView" forIndexPath:indexPath];
        
        reusableView.backgroundColor = [UIColor clearColor];
       
        //数据处理
        NSDictionary *dic = _data[indexPath.section];
        NSString *orgName = dic[@"orgName"];
        reusableView.placeLabel.text = orgName;
        
        return reusableView;
    }
    return nil;
}

#pragma mark 设置header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 50);
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    NSLog(@"%@",searchText);

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [_searchBar resignFirstResponder];

}






@end
