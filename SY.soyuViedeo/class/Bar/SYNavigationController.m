//
//  SYNavigationController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYNavigationController.h"

@interface SYNavigationController ()

@end

@implementation SYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的颜色
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [[UINavigationBar appearance] setBarTintColor:KAPPMAINCOLOR];
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (@available(iOS 11.0, *)) {
        UIImage *backButtonImage = [[UIImage imageNamed:@"白色右边箭头"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationBar.backIndicatorImage = backButtonImage;
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, 0)forBarMetrics:UIBarMetricsDefault];//UIOffsetMake(-kScreenWidth, 0)zh只要横向偏移，纵向偏移返回图标也会偏移
    }
    else{
        UIImage *backButtonImage = [[UIImage imageNamed:@"白色右边箭头"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, -SCREENH_HEIGHT)forBarMetrics:UIBarMetricsDefault];
    }
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}


@end
