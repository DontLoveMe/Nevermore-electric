//
//  LocationController.m
//  Electic-Project
//
//  Created by coco船长 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LocationController.h"

@interface LocationController ()

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation LocationController
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
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60.f, 32.f)];
    rightButton.tag = 102;
    [rightButton setTitle:@"切换" forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"按钮点击前.png"]
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
        
    }else if (button.tag == 102) {
//        //三目判断左右翻转
//        UIViewAnimationOptions options = _mapView.hidden?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
        
        
        //按钮翻转动画
        
//        [UIView transitionWithView:self.view
//                          duration:1
//                           options:UIViewAnimationOptionTransitionCrossDissolve
//                        animations:nil
//                        completion:nil];
        
        //视图的显示与隐藏
        _mapView.hidden = !_mapView.hidden;
        _collectionView.hidden = !_collectionView.hidden;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    self.title = @"赛飞奇";
    
    _anotationTag = 0;
    [self requestData];
    
    [self initViews];
    
    [self createSearchBar];
}

- (void)createSearchBar {
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 3, KScreenWidth-20, 30)];

    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    
    [self.view addSubview:_searchBar];
}

- (void)requestData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userDic = [defaults objectForKey:@"userDic"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[userDic objectForKey:@"staffId"] forKey:@"staffId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ElecticBoxPointURL];
    
    [TestTool post:url
            params:params
           success:^(id json) {
               
               if ([json[@"flag"] boolValue]) {
                   _data = json[@"data"];
                   [_collectionView reloadData];
                   for (int i = 0; i < _data.count; i ++) {
                       NSDictionary *dic = _data[i];
                       // 添加一个PointAnnotation
                       BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
                       CLLocationCoordinate2D coor;
                       coor.latitude = [dic[@"latitude"] floatValue];
                       coor.longitude = [dic[@"longitude"] floatValue];
                       annotation.coordinate = coor;
                       annotation.title = dic[@"orgName"];
                       [_mapView addAnnotation:annotation];
                       
                      
                       [_mapView setCenterCoordinate:coor];
                   }
                  
               }
               
               
           } failure:^(NSError *error) {
               
           }];

}

- (void)initViews{

    //地图
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)];
//    _mapView.showsUserLocation = YES;
    [_mapView setZoomLevel:15.f];
    [self.view addSubview:_mapView];
    
    
//    _locationService = [[BMKLocationService alloc] init];
//    _locationService.delegate = self;
//    [_locationService startUserLocationService];
    
    
    //放大
    _zoomIn = [[UIButton alloc] initWithFrame:CGRectMake(12.f, _mapView.bottom - 144.f, 55.f, 55.f)];
    [_zoomIn setBackgroundImage:[UIImage imageNamed:@"定位-放大.png"]
                       forState:UIControlStateNormal];
    [_zoomIn addTarget:self
                action:@selector(zoomInAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:_zoomIn];
    
    //缩小
    _zoomOut = [[UIButton alloc] initWithFrame:CGRectMake(12.f, _mapView.bottom - 67.f, 55.f, 55.f)];
    [_zoomOut setBackgroundImage:[UIImage imageNamed:@"定位-缩小.png"]
                        forState:UIControlStateNormal];
    [_zoomOut addTarget:self
                 action:@selector(zoomOutAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:_zoomOut];
    
    
    //创建collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KScreenWidth/2-20, 30);
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(50, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight) collectionViewLayout:layout];
    _collectionView.hidden = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
}

- (void)viewWillAppear:(BOOL)animated{

    [_mapView viewWillAppear];
    _mapView.delegate = self;

}

- (void)viewWillDisappear:(BOOL)animated{

    [_mapView viewWillDisappear];
    _mapView.delegate = nil;

}

#pragma mark - ButtonAction
- (void)zoomInAction:(UIButton *)button{

    [_mapView zoomIn];

}

- (void)zoomOutAction:(UIButton *)button{
    
    [_mapView zoomOut];
    
}

#pragma  mark - BMKMapUserlocationDelegate
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
//
//    [_mapView setCenterCoordinate:userLocation.location.coordinate];
//    [_mapView updateLocationData:userLocation];
//    
//}
//
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    
//    [_mapView setCenterCoordinate:userLocation.location.coordinate];
//    [_mapView updateLocationData:userLocation];
//
//}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

    NSDictionary *dic = self.data[view.tag];
//    NSLog(@"orgId%@tag%ld",dic[@"orgId"],view.tag);
    StateViewController *SVC = [[StateViewController alloc] init];
    SVC.orgId = dic[@"orgId"];
    [self.navigationController pushViewController:SVC animated:YES];
  
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
  
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        newAnnotationView.tag = _anotationTag;
        _anotationTag ++;
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未选中状态"]];
    UILabel *lable = [[UILabel alloc] initWithFrame:cell.bounds];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    [cell addSubview:lable];
    
    lable.text = self.data[indexPath.row][@"name"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.data[indexPath.row];
//    NSLog(@"org%@,tag%ld",dic[@"orgId"],indexPath.row);
    StateViewController *SVC = [[StateViewController alloc] init];
    SVC.orgId = dic[@"orgId"];
    [self.navigationController pushViewController:SVC animated:YES];
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_searchBar resignFirstResponder];
    
}


@end
