//
//  AppDelegate.m
//  Electic-Project
//
//  Created by coco船长 on 16/6/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//  2acf72d06f8716aab8a5353ccd123157

#import "AppDelegate.h"
#import "BPush.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册百度地图应用
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"jNcpkw8b0LnBDz1TnPISjfwmwG9sOz3c"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    self.window.rootViewController = [[LoginViewController alloc] init];
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        //IOS8
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:notiSettings];
        
    } else {//ios7
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
#pragma clang diagnostic pop
    }
    
    //测试 开发环境 时需要修改BPushMode 为 BPushModeDevelopment 需要修改Apikey为自己的Apikey
    
    // App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:APIKEY pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil useBehaviorTextInput:NO isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [BPush handleNotification:userInfo];
//        OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] init];
//        [(UINavigationController *)self.window.rootViewController pushViewController:orderConfirmVC animated:YES];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"RemoteNotifications deviceToken：\n%@", deviceToken);
    //<c61e5a13 2d048382 124c26cd 0c16f67c 7478b35f 6b370a42 4fe797dc 9f3a5410>
    [BPush registerDeviceToken:deviceToken];
    //绑定Push服务通道，必须在设置好Access Token或者API Key并且注册deviceToken后才可绑定。绑定结果通过BPushCallBack回调返回。绑定成功后可以获取appid,channelid,userid等信息、以及进行 settag listtag deletetag unbind 操作。
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if (![userDefaults objectForKey:PushChannelID]) {
        //有通知开关，在此进行绑定只为了获取channelid
        [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
            NSLog(@"绑定返回值：\n%@", [NSString stringWithFormat:@"Method: %@\n%@", BPushRequestMethodBind, result]);
//            if (result) {
//                [userDefaults setObject:[result objectForKey:@"channel_id"] forKey:PushChannelID];
//                [userDefaults synchronize];
//                [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {
//                    NSLog(@"解绑返回值：\n%@", [NSString stringWithFormat:@"Method: %@\n%@", BPushRequestMethodUnbind, result]);
//                    NSLog(@"===%@", [BPush getChannelId]);
//                }];
//            }
        }];
//    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo//ios7.0之前
{
    NSLog(@"RemoteNotification userInfo：\n%@", userInfo);
    /*
     "aps" : {
     "alert" : "You got your emails.",
     "badge" : 9,
     "sound" : "bingbong.aiff",
     "acme1" : "bar",
     "acme2" : 42
     }
     */
    [BPush handleNotification:userInfo];//用于对推送消息的反馈和统计
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"Inacitve or background");
        if (userInfo[@"aps"][@"alert"]) {
//            OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] init];
//            [(UINavigationController *)self.window.rootViewController pushViewController:orderConfirmVC animated:YES];
        }
    } else if (application.applicationState == UIApplicationStateActive) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[userInfo[@"aps"][@"sound"] componentsSeparatedByString:@"."][0] ofType:@"wav"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return;
        SystemSoundID hintSound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &hintSound);//path为空报错
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"VoiceSwitch"]) {
            AudioServicesPlaySystemSound(hintSound);//播放
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShakeSwitch"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动效果（模拟器报错）
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {//iOS7.0之后
    
    NSLog(@"RemoteNotification userInfo：\n%@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
    // 应用非活动状态下（后台）点击推送通知，直接跳转页面
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"Inacitve or background");
        if (userInfo[@"aps"][@"alert"]) {
//            OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] init];
//            [(UINavigationController *)self.window.rootViewController pushViewController:orderConfirmVC animated:YES];
        }
    } else if (application.applicationState == UIApplicationStateActive) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[userInfo[@"aps"][@"sound"] componentsSeparatedByString:@"."][0] ofType:@"wav"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return;
        SystemSoundID hintSound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &hintSound);//path为空报错
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"VoiceSwitch"]) {
            AudioServicesPlaySystemSound(hintSound);//播放
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShakeSwitch"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动效果（模拟器报错）
        }
    }
}

// 在 iOS8 系统中，需要添加此方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"RemoteNotifications Regist fail：\n%@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {

    //当后台切换至后台
//    [BMKMapView willBackGround];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //应用恢复前台，重新调用，渲染界面
//    [BMKMapView didForeGround];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
