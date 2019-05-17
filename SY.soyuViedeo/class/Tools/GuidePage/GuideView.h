//
//  GuideView.h
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuideView : UIViewController
/**
 引导页图片数组（gif图 需要添加后缀名：icon.gif）
 */
@property (nonatomic,strong)NSArray *imageArray;

/**
 跳过按钮是否显示(默认为NO)
 */
@property (nonatomic,assign)BOOL cancelButtonShow;

/**
 分页控件是否显示(默认为NO)
 */
@property (nonatomic,assign)BOOL pageControlShow;

/**
 未选中圆点颜色
 */
@property (nonatomic,strong)UIColor *pageIndicatorColor;

/**
 选中圆点颜色
 */
@property (nonatomic,strong)UIColor *currentPageIndicatorColor;

/**
 设置引导页图片
 
 @param imageArray 引导页数组
 @param rootController 根控制器
 */
- (void)showGuideViewWithImageArray:(NSArray *)imageArray WindowRootController:(UIViewController *)rootController;
@end

NS_ASSUME_NONNULL_END
