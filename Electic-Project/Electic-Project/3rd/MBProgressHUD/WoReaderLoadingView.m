//
//  WoReaderLoadingView
//  WoReader
//
//  Created by junlx  on 12-9-3.
//  Copyright (c) 2012年 ZTE. All rights reserved.
//

#import "WoReaderLoadingView.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation WoReaderLoadingView

+ (WoReaderLoadingView *) sharedInstance
{
    static WoReaderLoadingView *instance;
    
    @synchronized(self)
    {
        if (!instance)
        {
            instance = [[WoReaderLoadingView alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.isReadingText = NO;
    }
    return self;
}

#pragma mark - View lifecycle

- (void) showNoticeWithTitle:(NSString *)title yOffset:(NSString*)yOffset
{
    [self showNoticeContentWithTitle:title yOffset:yOffset];
    
    [self performSelector:@selector(removeNotice:) withObject:noticeHUD afterDelay:0.1];
}

- (void) showNoticeContentWithTitle:(NSString *)title yOffset:(NSString *)yOffset
{
    if (!noticeHUD)
    {
        noticeHUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:noticeHUD];
//    noticeHUD.mode = MBProgressHUDModeText;
    noticeHUD.detailsLabelFont = [UIFont systemFontOfSize:14];
    noticeHUD.yOffset = [yOffset floatValue];
    noticeHUD.detailsLabelText = title;
    
    if (([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoadscape"]) && self.isReadingText)
    {
        noticeHUD.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        noticeHUD.transform = CGAffineTransformMakeRotation(0);
        
    }
    
//    if (APPDELEGATE.epubIsHorizontal)
//    {
//        noticeHUD.transform = CGAffineTransformMakeRotation(M_PI*1.5);
//        
//    }
    
    [noticeHUD show:YES];
}

- (void) showNoticeWithTitle:(NSString *)title yOffset:(NSString*)yOffset delayTime:(NSInteger) delayTime
{
//    [self showWithOverlayPressed:title];
    [self showNoticeContentWithTitle:title yOffset:yOffset];
    [self performSelector:@selector(removeNotice:) withObject:noticeHUD afterDelay:delayTime];
}

- (void)removeNotice:(MBProgressHUD *)notice
{
    [notice hide:YES afterDelay:2.0];
}

-(void)HUDShow:(NSString *)labelText yOffset:(NSString *)yOffset
{
        if (!loadingHUD)
        {
            loadingHUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
        }
        [[[UIApplication sharedApplication] keyWindow] addSubview:loadingHUD];
        loadingHUD.labelFont = [UIFont systemFontOfSize:14];
        loadingHUD.minSize = CGSizeMake(100.f, 100.f);
        loadingHUD.labelText = labelText;
        loadingHUD.yOffset = [yOffset floatValue];
        
        if (([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoadscape"]) && self.isReadingText)
        {
            loadingHUD.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else
        {
            loadingHUD.transform = CGAffineTransformMakeRotation(0);
        }
        
        [loadingHUD show:YES];
        [loadingHUD hide:YES afterDelay:20];//20秒自动消失，防止,有的时候线程很卡或会卡死
}

- (void)HUDHide
{
    //NSLog(@"HUDHide");
    [loadingHUD hide:YES];
}

- (void)HUDHideWithNoAnimation
{
    //NSLog(@"HUDHideWithNoAnimation");
    [loadingHUD hide:NO];
}

- (void)showWithLabelDeterminateHorizontalBar
{
    //    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    //    [self.navigationController.view addSubview:HUD];
    
    [loadingHUD hide:YES];
    
    if (!progressHUD)
    {
        progressHUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:progressHUD];
    // Set determinate bar mode
//    progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    
    progressHUD.delegate = self;
    
    // myProgressTask uses the HUD instance to update progress
    [progressHUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)myProgressTask
{
    // This just increases the progress indicator in a loop
    //    float progress = 0.0f;
    //    while (progress < 1.0f) {
    //        progress += 0.01f;
    loadingHUD.progress = self.progress;
    //        usleep(50000);
    //    }
}

- (void) showNoticeWithTitleNoAutoHide:(NSString *)title yOffset:(NSString *)yOffset
{
    [self showNoticeContentWithTitle:title yOffset:yOffset];
    [self performSelector:@selector(removeNotice:) withObject:noticeHUD afterDelay:1.0];
}

- (void)HUDNoAutoHide
{
    //NSLog(@"HUDHide");
    [self performSelector:@selector(removeNotice:) withObject:noticeHUD afterDelay:2.5];
    
//    [noticeHUD hide:YES afterDelay:2.0];
}

@end

