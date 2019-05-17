//
//  AppDelegate+Severs.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "AppDelegate+Severs.h"
#import "SYTabBarController.h"
#import "IQKeyboardManager.h"
#import "FPSDisplay.h"
#import <UMShare/UMShare.h>
#import "AFNetworking.h"
#import "GuideView.h"

@implementation AppDelegate (Severs)

-(void)initAnything{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
        
    [[UIImageView appearance]setContentMode:UIViewContentModeScaleToFill];
    
    [self.window makeKeyAndVisible];
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    if ([Tools IsFirst]) {
        GuideView *vc = [[GuideView alloc]init];
        vc.pageControlShow=YES;
        vc.currentPageIndicatorColor = KAPPMAINCOLOR;
        [vc showGuideViewWithImageArray:@[@"引导1",@"引导2",@"引导1",@"引导2"] WindowRootController:[SYTabBarController new]];
        self.window.rootViewController = vc;
        USERDEFAULT_SET_value(@(1), KUSER_FIRST);
    }else{
        self.window.rootViewController = [[SYTabBarController alloc]init];
    }
    
}
-(void)setKeyBord{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.enableAutoToolbar=NO;//不显示上面的东西
}

-(void)initSystem{
    
    
    NSMutableDictionary *dict= [[NSMutableDictionary alloc]init];
    [dict setObject:@"1" forKey:@"os"];
    [HttpTool POST:[SY_system getWholeUrl] param:dict success:^(id responseObject) {
        SYUSERINFO *system = [SYUSERINFO info];
        system.systemModel = [systemModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
    } error:^(NSString *error) {
         SYUSERINFO *system = [SYUSERINFO info];
        system.systemModel.coin_name = @"金币";
    }];
    
}


- (void)confitUShareSettings
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5cda8a550cafb2916b000267"];
    [[UMSocialManager defaultManager] openLog:YES];
    [UMSocialGlobal shareInstance].isUsingWaterMark = NO;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxec2c9116dd9abb70" appSecret:@"5e286de52c7501ccd43ef8a9b10cc7a3" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}



-(void)netWorkStart{
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    }];
    [afNetworkReachabilityManager startMonitoring]; 
}


@end
