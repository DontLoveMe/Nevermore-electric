//
//  LocationController.h
//  Electic-Project
//
//  Created by coco船长 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "StateViewController.h"

@interface LocationController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,UISearchBarDelegate>{

    BMKMapView *_mapView;
    BMKLocationService *_locationService;
    
    UIButton    *_zoomIn;
    UIButton    *_zoomOut;

}

@end
