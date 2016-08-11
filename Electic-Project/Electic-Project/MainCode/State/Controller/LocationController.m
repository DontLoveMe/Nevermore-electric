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
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    self.title = @"赛飞奇";
    
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
               }
               
               
           } failure:^(NSError *error) {
               
           }];

}

- (void)initViews{

    //地图
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight)];
    _mapView.showsUserLocation = YES;
    [_mapView setZoomLevel:15.f];
    self.view = _mapView;
    
    _locationService = [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    [_locationService startUserLocationService];
    
    
    //放大
    _zoomIn = [[UIButton alloc] initWithFrame:CGRectMake(12.f, _mapView.bottom - 144.f, 55.f, 55.f)];
    [_zoomIn setBackgroundImage:[UIImage imageNamed:@"定位-放大.png"]
                       forState:UIControlStateNormal];
    [_zoomIn addTarget:self
                action:@selector(zoomInAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomIn];
    
    //缩小
    _zoomOut = [[UIButton alloc] initWithFrame:CGRectMake(12.f, _mapView.bottom - 67.f, 55.f, 55.f)];
    [_zoomOut setBackgroundImage:[UIImage imageNamed:@"定位-缩小.png"]
                        forState:UIControlStateNormal];
    [_zoomOut addTarget:self
                 action:@selector(zoomOutAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomOut];
    
    
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
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{

    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    [_mapView updateLocationData:userLocation];
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    [_mapView updateLocationData:userLocation];

}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

        StateViewController *SVC = [[StateViewController alloc] init];
        [self.navigationController pushViewController:SVC animated:YES];
  
}


#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


@end
