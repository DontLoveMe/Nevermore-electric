//
//  TrendController.h
//  Electic-Project
//
//  Created by coco船长 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface TrendController : BaseViewController<UIWebViewDelegate>{
    
    UIWebView   *_webView;
    
    UIActivityIndicatorView     *_activityView;
    
}

@property (nonatomic,assign)NSInteger boxID;


@end
