//
//  BaseViewController.m
//  健康芯
//
//  Created by coco船长 on 15/12/7.
//  Copyright © 2015年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页_背景"]];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    bgImgView.image = [UIImage imageNamed:@"首页_背景"];
    [self.view insertSubview:bgImgView atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    image.image = [UIImage imageNamed:self.title] ;
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        
        view.backgroundColor = [UIColor clearColor];
        
    }
    if ([self.navigationController.view.subviews[0] isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = self.navigationController.view.subviews[0];
        [imageView removeFromSuperview];
        
    }
    [self.navigationController.view insertSubview:image atIndex:0];

}

//设置导航控制器的属性
-(void)setNavigationBar{
    
    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexRGB:ThemeColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:22],
       NSForegroundColorAttributeName : [UIColor clearColor]}];
    [self _addBackItem];
}

//设置返回按钮
- (void)_addBackItem{
    
}

#pragma mark - 设置HUD
- (void)showHUD:(NSString *)title {
    
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    _hud.labelText = title;
    
    [_hud show:YES];
    
}

- (void)hideSuccessHUD:(NSString *)title {
    
    if (title.length == 0) {
        [_hud hide:YES afterDelay:1.f];
    } else {
        
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        //显示模式设置为：自定义视图模式
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.labelText = title;
        
        //延迟隐藏
        [_hud hide:YES afterDelay:1.5];
        [self performSelector:@selector(changgeModel)
                   withObject:nil
                   afterDelay:2.f];
    }
    
}

- (void)hideFailHUD:(NSString *)title {
    
    if (title.length == 0) {
        [_hud hide:YES afterDelay:1.5];
    } else {
        
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        //显示模式设置为：自定义视图模式
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.labelText = title;
        
        //延迟隐藏
        [_hud hide:YES afterDelay:1.5];
        [self performSelector:@selector(changgeModel)
                   withObject:nil
                   afterDelay:2.f];
    }
    
}

- (void)changgeModel{
    
    _hud.mode = MBProgressHUDModeIndeterminate;
    
}

@end
