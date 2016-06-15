//
//  BaseViewController.h
//  健康芯
//
//  Created by coco船长 on 15/12/7.
//  Copyright © 2015年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController{

    MBProgressHUD *_hud;
    
}

//显示HUD提示
- (void)showHUD:(NSString *)title;

//隐藏HUD(成功)
- (void)hideSuccessHUD:(NSString *)title;

//隐藏HUD(失败)
- (void)hideFailHUD:(NSString *)title;


@end
