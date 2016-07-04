//
//  TrendController.m
//  Electic-Project
//
//  Created by coco船长 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "TrendController.h"

@interface TrendController ()

@end

@implementation TrendController
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
    
    self.title = @"报警详情";
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"121212"];
    
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)];
    _webView.backgroundColor = [UIColor colorFromHexRGB:@"121212"];
    _webView.delegate = self;
    //自动适配屏幕
//    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    //设置风火轮
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString *url;
    if (_isCurrent) {
        url = WarnningCurrentPicURL;
    }else {
        url = WarnningTemperaturePicURL;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?id=%ld",BASE_URL,url,_boxID]]];
    [_webView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [_activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_activityView stopAnimating];
    
    _activityView.hidden = YES;
    
    
}

@end
