//
//  SYTabBarController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYTabBarController.h"
#import "SYNavigationController.h"
#import "SYHomePageController.h"
#import "SYMaincontroller.h"
#import "SYShareController.h"
#import "SYTestController.h"
#import "SYFindController.h"

@interface SYTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>
@property (nonatomic,strong) NSMutableArray *VCarray;

@end

@implementation SYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addChidController];
    [self.tabBar setTranslucent:NO];
    self.viewControllers = self.VCarray;
}


//添加子控制器
-(void)addChidController{
    
    NSArray *Controllerarray = @[@"SYHomePageController",@"SYFindController",@"SYLiveMainController",@"SYTestController",@"SYMaincontroller"];
    NSArray *titlearray = @[@"首页",@"发现",@"直播",@"任务",@"我的"];
    NSArray *SeleImageArray = @[@"icon_tabbar_home_pre",@"icon_tabbar_discover_pre",@"icon_tabbar_share_pre",@"icon_tabbar_task_pre",@"icon_tabbar_mine_pre"];
    NSArray *imgaearray = @[@"icon_tabbar_home_nor",@"icon_tabbar_discover_nor",@"icon_tabbar_share_nor",@"icon_tabbar_task_nor",@"icon_tabbar_mine_nor"];; //SeleImageArray
    for (int i= 0; i<Controllerarray.count; i++) {
        UIViewController *controller = [[NSClassFromString(Controllerarray[i]) alloc]init];
        [self ChangeController:controller withtitle:titlearray[i] andWithImageWith:imgaearray[i] andWithSeleImage:SeleImageArray[i]];
        SYNavigationController *nav = [[SYNavigationController alloc]initWithRootViewController:controller];
        [self.VCarray addObject:nav];
    }
    
}
//写一个方法 包装成NAV
-(void)ChangeController:(UIViewController *)controller withtitle:(NSString *)title andWithImageWith:(NSString *)image andWithSeleImage:(NSString *)seleIamge{
    controller.title = title;
    controller.tabBarItem.title = title;
    //设置选中状态下的图片！！！
    controller.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:seleIamge] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中字体的颜色和未选中字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
//RGBA(171, 21, 26, 1)

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KAPPMAINCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} forState:UIControlStateSelected];
}

-(NSMutableArray *)VCarray{
    
    if (!_VCarray) {
        _VCarray = [[NSMutableArray alloc]init];
    }
    return _VCarray;
    
}

@end
