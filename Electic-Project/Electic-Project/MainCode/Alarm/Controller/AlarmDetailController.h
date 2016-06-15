//
//  AlarmDetailController.h
//  ElectricProject
//
//  Created by coco船长 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface AlarmDetailController : BaseViewController<UIWebViewDelegate>{

    UIWebView   *_webView;

    UIActivityIndicatorView     *_activityView;
    
}

@property (nonatomic,assign)NSInteger boxID;

@end
